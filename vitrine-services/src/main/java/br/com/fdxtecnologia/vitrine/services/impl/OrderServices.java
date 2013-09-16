/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.model.Order;
import br.com.fdxtecnologia.vitrine.services.dao.OrderDAO;

/**
 *
 * @author Andre
 */
@Resource
@Path("/order")
public class OrderServices {

    private Result result;
    private OrderDAO orderDAO;

    public OrderServices(Result result, OrderDAO orderDAO) {
        this.result = result;
        this.orderDAO = orderDAO;
    }

    @Consumes("application/json")
    public void placeOrder(Order order) {
        System.out.println("Request Enviado");
        result.nothing();
    }

    @Path("/retrieveOrder")
    public void retrieveOrder(Long id) {
        
    }
}
