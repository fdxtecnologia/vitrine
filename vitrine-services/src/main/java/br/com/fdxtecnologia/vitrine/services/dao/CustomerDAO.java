/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.model.Customer;
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
    
}
