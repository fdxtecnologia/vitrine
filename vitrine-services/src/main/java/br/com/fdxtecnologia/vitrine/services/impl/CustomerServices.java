/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.vitrine.services.dao.CustomerDAO;

/**
 *
 * @author Andre
 */
@Path("/customers")
public class CustomerServices {

    private Result result;
    private CustomerDAO dao;

    public CustomerServices(Result result, CustomerDAO dao) {
        this.result = result;
        this.dao = dao;
    }
}
