/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.model.Address;
import br.com.fdxtecnologia.comparador.model.CreditCard;
import br.com.fdxtecnologia.comparador.model.Customer;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Andre
 */
@Component
public class CustomerDAO extends GenericDAO<Customer> {

    public CustomerDAO(Session session) {
        super(session);
    }

    public Customer getCustomerByUserAndPassword(String login, String password) {
        Query q = session.createQuery("from Customer c where c.user.name = '"+login+"' and c.user.password = '"+password+"'");
        Customer c = (Customer)q.uniqueResult();
        return c;
    }

    public List<Address> getCustomerAddresses(Customer customer) {
        Query q = session.createQuery("from Addresses a where a.customer = " + customer);
        return (List<Address>) q.list();
    }

    public List<CreditCard> getCreditCardsByCustomer(Long customerId) {
        Query q = session.createQuery("from Customer where id = " + customerId);
        Customer c = (Customer) q.uniqueResult();
        if (c.getCardInfo() != null) {
            Gson gson = new Gson();
            return (List<CreditCard>) gson.fromJson(c.getCardInfo(), CreditCard.TYPE);
        } else {
            return new ArrayList<CreditCard>();
        }
    }
}
