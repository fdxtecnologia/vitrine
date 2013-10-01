/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.simplemail.Mailer;
import br.com.caelum.vraptor.simplemail.template.TemplateMailer;
import br.com.fdxtecnologia.comparador.model.Customer;
import br.com.fdxtecnologia.comparador.model.Order;
import br.com.fdxtecnologia.comparador.model.User;
import br.com.fdxtecnologia.vitrine.services.dao.OrderDAO;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;

/**
 *
 * @author Andre
 */
@Resource
@Path("/order")
public class OrderServices {

    private Result result;
    private OrderDAO orderDAO;
    private final TemplateMailer templates;
    private final Mailer mailer;

    public OrderServices(Result result, OrderDAO orderDAO, TemplateMailer templates, Mailer mailer) {
        this.result = result;
        this.orderDAO = orderDAO;
        this.templates = templates;
        this.mailer = mailer;
    }

    @Consumes("application/json")
    public void placeOrder(Order order) {
        System.out.println("Request Enviado");
        result.nothing();
    }

    @Path("/retrieveOrder")
    public void retrieveOrder(Long id) {
    }

    @Path("/confirmationEmail/{orderId}")
    public void sendConfirmationEmail(Long orderId) throws EmailException {

        Order order = new Order();
        order.setId(1238190l);
        Customer customer = new Customer();
        customer.setFirstName("André");
        customer.setLastName("Lima");
        customer.setUser(new User());
        customer.getUser().setEmail("lima.andre35@gmail.com");
        
        order.setCustomer(customer);
        
        Email email = this.templates
                .template("confirmOrder")
                .with("order", order)
                .to(order.getCustomer().getFirstName(), order.getCustomer().getUser().getEmail());
        email.setSubject("Confirmação de Pedido - " + order.getId());
        mailer.send(email); // Hostname, port and security settings are made by the Mailer
        result.nothing();
    }
}
