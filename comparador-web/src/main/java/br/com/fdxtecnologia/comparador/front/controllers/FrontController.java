/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.front.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.com.fdxtecnologia.comparador.dao.AddressDAO;
import br.com.fdxtecnologia.comparador.dao.CartDAO;
import br.com.fdxtecnologia.comparador.dao.CustomerDAO;
import br.com.fdxtecnologia.comparador.dao.MarketDAO;
import br.com.fdxtecnologia.comparador.dao.OrderDAO;
import br.com.fdxtecnologia.comparador.dao.ProductDAO;
import br.com.fdxtecnologia.comparador.login.Permission;
import br.com.fdxtecnologia.comparador.login.Public;
import br.com.fdxtecnologia.comparador.model.Address;
import br.com.fdxtecnologia.comparador.model.Cart;
import br.com.fdxtecnologia.comparador.model.CartJSON;
import br.com.fdxtecnologia.comparador.model.Customer;
import br.com.fdxtecnologia.comparador.model.Category;
import br.com.fdxtecnologia.comparador.model.Market;
import br.com.fdxtecnologia.comparador.model.Order;
import br.com.fdxtecnologia.comparador.model.Product;
import br.com.fdxtecnologia.comparador.model.ProductJSON;
import br.com.fdxtecnologia.comparador.model.Role;
import br.com.fdxtecnologia.comparador.model.Sort;
import br.com.fdxtecnologia.comparador.utils.Constants;
import br.com.fdxtecnologia.comparador.utils.Utils;
import com.google.gson.Gson;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andre
 */
@Resource
@Public
@Path("/")
public class FrontController {

    private CustomerSession session;
    private ProductDAO productDAO;
    private MarketDAO marketDAO;
    private CustomerDAO customerDAO;
    private CartDAO cartDAO;
    private OrderDAO orderDAO;
    private Result result;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private AddressDAO addressDAO;

    public FrontController(CustomerSession session, ProductDAO productDAO, Result result, MarketDAO marketDAO, CustomerDAO customerDAO, CartDAO cartDAO, OrderDAO orderDAO, HttpServletRequest request, AddressDAO addressDAO, HttpServletResponse response) {
        this.session = session;
        this.productDAO = productDAO;
        this.result = result;
        this.marketDAO = marketDAO;
        this.customerDAO = customerDAO;
        this.cartDAO = cartDAO;
        this.orderDAO = orderDAO;
        this.request = request;
        this.addressDAO = addressDAO;
        this.response = response;
    }

    @Path("")
    public void index() {
        result.include("customer", session.getCustomer());
        result.include("products", productDAO.getProductsByMarket(new Market(3l), 1, 24));
    }

    @Path("/products/{marketId}/{page}")
    public void getProductList(Long marketId, int page) {
        result.use(Results.json()).withoutRoot().from(productDAO.getProductsByMarket(new Market(marketId), page, 24)).serialize();
    }

    @Path("/login")
    public void login() {
        if (session.isLogged()) {
            result.redirectTo(FrontController.class).index();
        }
    }

    @Path("/checkout")
    @Permission(Role.CUST)
    public void checkout() {
        result.include("customer", session.getCustomer());
        result.include("cAddresses", customerDAO.getCustomerAddress(session.getCustomer().getId()));
        result.include("products", cartDAO.getProducts(request, productDAO));
    }

    @Path("/myarea")
    @Permission(Role.CUST)
    public void myarea() {
        result.include("customer", session.getCustomer());
        result.include("carts", cartDAO.listCartHistory(session.getCustomer()));
    }

    @Path("/myarea/editpass")
    @Permission(Role.CUST)
    public void editpass() {

        result.include("customer", session.getCustomer());
    }

    @Path("/account/signup")
    public void signup() {
    }

    @Post("/account/authenticate")
    public void authenticate(String user, String password) {
        session.setCustomer(customerDAO.getCustomerUser(user, Utils.digestToMD5(password)));
        if (session.isLogged()) {
            result.redirectTo(FrontController.class).index();
            result.include("customer", session.getCustomer());
        } else if (!session.isLogged()) {
            result.include("mensagem", "usuário inválido");
            result.redirectTo(FrontController.class).login();
        }
    }

    @Post("/checkout/confirm")
    @Permission(Role.CUST)
    public void saveCheckout(String optionsRadios, Address address) throws UnsupportedEncodingException {
        Order order = new Order();
        order.setCustomer(session.getCustomer());
        if (optionsRadios.equals("radioAddress")) {
            //Endereço
            Address add = (Address) addressDAO.loadById(address);
            order.setShippingAddress(add);
        } else if (optionsRadios.equals("radioNewAddress")) {
            //Novo Endereço
            address.setId(null);
            List<Address> addresses = session.getCustomer().getAddresses();
            addresses.add(address);
            order.setShippingAddress(address);
            customerDAO.update(session.getCustomer());
        }
        Gson gson = new Gson();
        Cart cart = new Cart();
        cart.setCustomer(session.getCustomer());
        CartJSON cartJSON = gson.fromJson(URLDecoder.decode(Utils.getCookieValue(request.getCookies(), "cart"), "UTF-8"), CartJSON.class);
        cart.setListProdJSON(gson.toJson(cartJSON.getProducts(), ProductJSON.TYPE));
        cart.setSaveDate(new Date());

        if (cartJSON.getId() == null) {
            cartDAO.save(cart);
            cartJSON.setId(cart.getId());
        } else {
            cart.setId(cartJSON.getId());
            cartDAO.update(cart);
        }
        order.setCartInfo(gson.toJson(cartJSON));
        orderDAO.save(order);
    }

    @Post("/account/updatePassword")
    @Permission(Role.CUST)
    public void updateCustomerPassword(String oldpassword, String newpass, String confirmnewpass) {
        if (session.getCustomer().getUser().getPassword().equals(Utils.digestToMD5(oldpassword))) {
            if (newpass.equals(confirmnewpass)) {
                session.getCustomer().getUser().setPassword(Utils.digestToMD5(newpass));
                customerDAO.update(session.getCustomer());
                result.include("mensagem", "edit.password.success");
            } else {
                result.include("mensagem", "edit.password.not.match");
            }
        } else {
            result.include("mensagem", "edit.old.password.not.match");
        }
        result.redirectTo(FrontController.class).myarea();
    }

    @Path("/search")
    public void search(String query, Integer page, Sort order, Long market, Long category) {
        /*
         * [0] = List<Product> - The product list from the search
         * [1] = BigInteger - The quantity of results, for pagination
         */
        Object[] searchResults = productDAO.getProductsByTitle(query, page != null ? page : 1, Constants.DEFAULT_MAX_PER_PAGE, order, market, category);
        List<Product> products = (List<Product>) searchResults[0];
        Map<Category, Integer> categories = products != null ? getCategoriesFromSearch(products) : new HashMap<Category, Integer>();
        List<Market> markets = marketDAO.getMarketsByProductSearch(query);
        int totalPages;
        totalPages = (int) Math.ceil(((Long) searchResults[1]).intValue() * 1.0 / Constants.DEFAULT_MAX_PER_PAGE);
        result.include("categories", categories);
        result.include("markets", markets);
        result.include("products", products);
        result.include("query", query);
        result.include("order", order);
        result.include("page", page == null ? 1 : page);
        result.include("category", category);
        result.include("sortValues", Sort.values());
        result.include("totalPages", totalPages);
    }

    @Post("/account/signup/save")
    public void saveCustomer(Customer customer) {

        if (customer.getId() == null) {
            boolean isRepeated = false;
            customer.getUser().setPassword(Utils.digestToMD5(customer.getUser().getPassword()));
            List<Customer> listCustomer = customerDAO.listCustomers();
            for (Customer c : listCustomer) {

                if (c.getUser().getName().equals(customer.getUser().getName())
                        && c.getUser().getEmail().equals(customer.getUser().getEmail())
                        && c.getCpf().equals(customer.getCpf())) {
                    isRepeated = true;
                    result.include("mensagem", "user.signup.err.email.name.cpf.exists");
                    break;
                } else {
                    if (c.getUser().getName().equals(customer.getUser().getName())) {
                        isRepeated = true;
                        result.include("mensagem", "user.signup.err.name.exists");
                        break;
                    }
                    if (c.getUser().getEmail().equals(customer.getUser().getEmail())) {
                        isRepeated = true;
                        result.include("mensagem", "user.signup.err.email.exists");
                        break;
                    }
                    if (c.getCpf().equals(customer.getCpf())) {
                        isRepeated = true;
                        result.include("mensagem", "user.signup.err.cpf.existis");
                        break;
                    }

                }
            }

            if (isRepeated) {
                result.include("mesagem", "usuario já existente");
                //result.include("customer", customer);
                result.redirectTo(FrontController.class).signup();
            } else {

                List<Address> list = customer.getAddresses();

                if (!Utils.validaCPF(customer.getCpf())) {
                    result.include("mensagem", "user.cpf.err");
                    //result.include("customer", customer);
                    result.redirectTo(FrontController.class).signup();
                    return;
                }

                for (Address a : list) {
                    if (!Utils.validateCEP(a.getZipcode())) {
                        result.include("mensagem", "user.cep.err");
                        //result.include("customer", customer);
                        result.redirectTo(FrontController.class).signup();
                        return;
                    }
                }

                customer.getUser().setUserRole(Role.CUST);
                customer.getUser().setEnable(true);
                customerDAO.save(customer);
                result.include("mensagem", "sucesso");
                result.redirectTo(FrontController.class).index();
            }
        } else {
            result.include("mensagem", "user.signup.err.user.exists");
            //result.include("customer", customer);
            result.redirectTo(FrontController.class).signup();
        }
    }

    @Path("/logout")
    @Permission(Role.CUST)
    public void logout() {
        session.setCustomer(null);
        result.redirectTo(FrontController.class).index();
    }

    @Post("/account/update")
    @Permission(Role.CUST)
    public void updateCustomer(Customer customer) {

        Customer cust = session.getCustomer();

        if (cust != null) {
            cust.setFirstName(customer.getFirstName());
            cust.setLastName(customer.getLastName());
            cust.getUser().setEmail(customer.getUser().getEmail());
            customerDAO.update(cust);
        }
        result.include("mensagem", "customer.data.updated");
        result.include("customer", session.getCustomer());
        result.redirectTo(FrontController.class).myarea();
    }

    /**
     * TODO remover isso quando for fazer a busca final
     *
     * @param products
     * @return
     */
    private Map<Category, Integer> getCategoriesFromSearch(List<Product> products) {
        Map<Category, Integer> categories = new HashMap<Category, Integer>();
        for (Product p : products) {
            if (p.getCategories() != null) {
                for (Category c : p.getCategories()) {
                    if (!categories.containsKey(c)) {
                        categories.put(c, 1);
                    } else {
                        categories.put(c, categories.get(c) + 1);
                    }
                }
            }
        }
        return categories;
    }
}
