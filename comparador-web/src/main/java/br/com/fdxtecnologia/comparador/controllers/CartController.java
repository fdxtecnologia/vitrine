/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.jasperreports.Report;
import br.com.caelum.vraptor.jasperreports.download.ReportDownload;
import br.com.caelum.vraptor.jasperreports.formats.ExportFormats;
import br.com.fdxtecnologia.comparador.dao.CartDAO;
import br.com.fdxtecnologia.comparador.dao.OrderDAO;
import br.com.fdxtecnologia.comparador.dao.ProductDAO;
import br.com.fdxtecnologia.comparador.front.controllers.CustomerSession;
import br.com.fdxtecnologia.comparador.front.controllers.FrontController;
import br.com.fdxtecnologia.comparador.model.Cart;
import br.com.fdxtecnologia.comparador.model.CartJSON;
import br.com.fdxtecnologia.comparador.model.Order;
import br.com.fdxtecnologia.comparador.model.ProductJSON;
import br.com.fdxtecnologia.comparador.reports.OrderReport;
import br.com.fdxtecnologia.comparador.utils.Utils;
import com.google.gson.Gson;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author guilherme
 */
@Resource
public class CartController {

    private Result result;
    private CartDAO dao;
    private HttpServletResponse response;
    private HttpServletRequest request;
    private ProductDAO productDAO;
    private CustomerSession custSession;
    private OrderDAO orderDAO;

    public CartController(CartDAO dao, Result result, HttpServletResponse response, HttpServletRequest request, ProductDAO productDAO, CustomerSession custSession, OrderDAO orderDAO) {
        this.dao = dao;
        this.result = result;
        this.response = response;
        this.request = request;
        this.productDAO = productDAO;
        this.custSession = custSession;
        this.orderDAO = orderDAO;
    }

    @Post("/cart/save")
    public void save() {
        Gson gson = new Gson();
        Cart cart = new Cart();
        cart.setCustomer(custSession.getCustomer());
        CartJSON cartJSON = gson.fromJson(Utils.getCookieValue(request.getCookies(), "cart"), CartJSON.class);
        cart.setListProdJSON(gson.toJson(cartJSON.getProducts(), ProductJSON.TYPE));
        cart.setSaveDate(new Date());
        if (cartJSON.getId() == null) {
            dao.save(cart);
        } else {
            cart.setId(cartJSON.getId());
            dao.update(cart);
        }
        result.redirectTo(FrontController.class).myarea();
    }

    public List<ProductJSON> deserializeJSON(String JSON) {
        Gson gson = new Gson();
        List<ProductJSON> list = (List<ProductJSON>) gson.fromJson(JSON, ProductJSON.TYPE);
        return list;
    }

    @Path("/cart/load/{cartId}")
    public void load(Long cartId) throws UnsupportedEncodingException {
        Gson gson = new Gson();
        Cookie cookie = Utils.getCookie(request.getCookies(), "cart");
        Cart cart = dao.getById(cartId);
        CartJSON cartJSON = new CartJSON();
        cartJSON.setId(cart.getId());
        cartJSON.setProducts(deserializeJSON(cart.getListProdJSON()));
        String jsonCart = URLEncoder.encode(gson.toJson(cartJSON), "UTF-8");
        if (cookie == null) {
            Utils.createCookie(response, "cart", jsonCart);
        } else {
            Utils.setCookieValue(response, cookie, jsonCart);
        }

        result.redirectTo(CartController.class).list();
    }

    @Post("/cart/add")
    public void add(Long productId, int qtd) {

        Cookie cookieCart = Utils.getCookie(request.getCookies(), "cart");
        List<ProductJSON> listProds = new ArrayList<ProductJSON>();
        if (qtd == 0) {
            qtd = 1;
        }
        ProductJSON productJson = new ProductJSON(productId, qtd);
        Gson gson = new Gson();
        if (cookieCart == null) {
            listProds.add(productJson);
            Utils.createCookie(response, "cart", gson.toJson(listProds));
        } else {
            listProds = deserializeJSON(Utils.getCookieValue(request.getCookies(), "cart"));
            boolean productRepeated = false;
            for (ProductJSON p : listProds) {
                if (p.getIdProduct() == productId) {
                    p.setQuantity(p.getQuantity() + qtd);
                    productRepeated = true;
                }
            }
            if (!productRepeated) {
                listProds.add(productJson);
            }
            Utils.setCookieValue(response, cookieCart, gson.toJson(listProds));
        }
    }

    public void list() {
        this.result.include("products", dao.getProducts(request, productDAO));
        this.result.include("customer", custSession.getCustomer());
    }

    public void update() {
        Gson gson = new Gson();
        Enumeration e = request.getParameterNames();
        List<ProductJSON> products = deserializeJSON(Utils.getCookieValue(request.getCookies(), "cart"));
        while (e.hasMoreElements()) {
            String param = (String) e.nextElement();
            Long id = Long.parseLong(param.substring(4));
            for (ProductJSON product : products) {
                if (product.getIdProduct().equals(id)) {
                    product.setQuantity(Integer.parseInt(request.getParameter(param)));
                }
            }
        }
        Utils.setCookieValue(response, Utils.getCookie(request.getCookies(), "cart"), gson.toJson(products));
        result.forwardTo(CartController.class).list();
    }

    @Path("/cart/report/pdf")
    public Download pdfReport() {
        Report report = generateReportTeste();
        return new ReportDownload(report, ExportFormats.pdf());
    }

    private Report generateReportTeste() {
        Order o = new Order();
        o.setId(1l);
        o = orderDAO.loadById(o);
        Report r = generateOrderReport(o);
        return r;
    }

    private Report generateOrderReport(Order order) {
        List<Order> reportData = new ArrayList<Order>();
        order.setProducts(deserializeJSON(order.getCartInfo()));
        reportData.add(order);
        Report r = new OrderReport(reportData);
        return r;
    }
}
