/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.model.Address;
import br.com.fdxtecnologia.comparador.model.Customer;
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
    
    public Customer getCustomerByUserAndPassword(String login, String password){
        return null;
    }
    
    public List<Address> getCustomerAddresses(Customer customer){
        Query q = session.createQuery("from Addresses a where a.customer = " + customer);
        return null;
    }
    
}
