/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.com.fdxtecnologia.comparador.model.Address;
import br.com.fdxtecnologia.comparador.model.CreditCard;
import br.com.fdxtecnologia.comparador.model.Customer;
import br.com.fdxtecnologia.comparador.model.Role;
import br.com.fdxtecnologia.vitrine.services.dao.CustomerDAO;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Andre
 */
@Resource
@Path("/customers")
public class CustomerServices {

    private Result result;
    private CustomerDAO dao;
    private Gson gson;

    public CustomerServices(Result result, CustomerDAO dao) {
        this.result = result;
        this.dao = dao;
        gson = new Gson();
    }

    @Post
    public void authenticate(String login, String password) {
        Customer cust = dao.getCustomerByUserAndPassword(login, password);
        if(cust == null){
            result.use(Results.http()).sendError(500, "Invalid Customer");
        }else{
            cust.setAddresses(new ArrayList<Address>(cust.getAddresses()));
            result.use(Results.json()).withoutRoot().from(cust).include("addresses", "user").serialize();
        }
    }

    @Path("/{id}/addresses")
    public void listAddresses(Long id) {
        Customer c = dao.findById(id);
        if (c != null) {
            result.use(Results.json()).withoutRoot().from(new ArrayList<Address>(c.getAddresses())).serialize();
        } else {
            result.use(Results.http()).sendError(500, "Invalid Customer");
        }
    }

    @Post
    @Consumes("application/json")
    public void loginCustomerFB(Customer customer) {
    }

    @Post
    @Consumes("application/json")
    public void addCustomer(Customer customer) {
        customer.getUser().setUserRole(Role.CUST);
        customer.getUser().setLastAccess(new Date());
        dao.saveOrUpdate(customer);
        result.use(Results.json()).withoutRoot().from(customer).serialize();
    }

    @Path("/cardList/{customerId}")
    public void getCustomerCardList(Long customerId) {
        List<CreditCard> cards = dao.getCreditCardsByCustomer(customerId);
        for (int x = 0; x < cards.size(); x++) {
            String num = cards.get(x).getNumber();
            num = num.substring(0, 4) + "XXXXXXXX" + num.substring(12, 16);
            cards.get(x).setNumber(num);
        }
        result.use(Results.json()).withoutRoot().from(cards).serialize();
    }
}
