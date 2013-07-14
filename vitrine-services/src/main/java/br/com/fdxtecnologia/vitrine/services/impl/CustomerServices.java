/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.com.fdxtecnologia.comparador.model.Address;
import br.com.fdxtecnologia.comparador.model.Customer;
import br.com.fdxtecnologia.vitrine.services.dao.CustomerDAO;
import com.google.gson.Gson;
import java.util.ArrayList;

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

    @Path("/authenticate")
    public void authenticate() {
        Customer cust = dao.findById(1);
        cust.setAddresses(new ArrayList<Address>(cust.getAddresses()));
        result.use(Results.json()).withoutRoot().from(cust).include("addresses", "user").serialize();
    }

    @Path("/{id}/addresses")
    public void listAddresses(Long id) {
        Customer c = dao.findById(id);
        if(c != null){
            result.use(Results.json()).withoutRoot().from(new ArrayList<Address>(c.getAddresses())).serialize();
        } else {
            result.use(Results.http()).sendError(500, "Invalid Customer");
        }
    }

    @Path("/add")
    @Post
    public void addUser() {
    }
}
