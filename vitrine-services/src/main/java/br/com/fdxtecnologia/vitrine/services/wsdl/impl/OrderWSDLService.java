/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.wsdl.impl;

import br.com.fdxtecnologia.comparador.model.Address;
import br.com.fdxtecnologia.comparador.model.Customer;
import br.com.fdxtecnologia.comparador.model.Order;
import br.com.fdxtecnologia.comparador.model.Payment;
import br.com.fdxtecnologia.comparador.model.ProductJSON;
import br.com.fdxtecnologia.vitrine.services.dao.OrderDAO;
import br.com.fdxtecnologia.vitrine.services.factory.HibernateFactory;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Andre
 */
@WebService(serviceName = "OrderWSDLService")
public class OrderWSDLService {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Operação de Web service
     */
    @WebMethod(operationName = "getNonProcessedOrders")
    public List<Order> getNonProcessedOrders() {
//        OrderDAO dao = new OrderDAO(HibernateFactory.getSession());
//        List<Order> orders = dao.getNonProcessedOrders();
        List<Order> orders = new ArrayList<Order>();
        //Pedido
        Order order = new Order();
        //Dados do Cliente
        Customer customer = new Customer();
        customer.setFirstName("Andre");
        customer.setLastName("Luis");
        customer.setCpf("391.123.123-22");
        //Endereço
        Address add = new Address();
        add.setCity("Itajubá");
        add.setStreet("Rua");
        add.setStateCity("MG");
        add.setZipcode("12312321");
        //Lista de Endereços
        List<Address> addresses = new ArrayList<Address>();
        addresses.add(add);
        customer.setAddresses(addresses);
        //seta cliente do pedido
        order.setCustomer(customer);
        //Informações de pagamento
        order.setPayment(new Payment());
        //Endereço de Entrega
        order.setShippingAddress(add);
        order.setShippingPrice(BigDecimal.TEN);
        order.setTotalPrice(BigDecimal.TEN.multiply(new BigDecimal("2.30")));

        ProductJSON produto = new ProductJSON(10l, "12345", "Produto Teste", 2, BigDecimal.TEN);
        List<ProductJSON> produtos = new ArrayList<ProductJSON>();
        produtos.add(produto);
        order.setProducts(produtos);

        orders.add(order);

        return orders;
    }
}
