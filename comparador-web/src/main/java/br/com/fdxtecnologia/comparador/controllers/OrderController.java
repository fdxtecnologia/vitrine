/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.dao.OrderDAO;
import br.com.fdxtecnologia.comparador.login.Permission;
import br.com.fdxtecnologia.comparador.model.Role;

/**
 *
 * @author guilherme
 */
@Resource
@Permission(Role.CUST)
public class OrderController {
    
    private Result result;
    private OrderDAO dao;

    public OrderController(Result result, OrderDAO dao){
        this.result = result;
        this.dao = dao;
    }
    
}
