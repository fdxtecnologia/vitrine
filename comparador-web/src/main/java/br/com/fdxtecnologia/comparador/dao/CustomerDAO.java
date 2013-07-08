/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.factory.HibernateFactory;
import br.com.fdxtecnologia.comparador.model.Address;
import br.com.fdxtecnologia.comparador.model.Customer;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author guilherme
 */
@Component
public class CustomerDAO extends GenericDAO<Object>{
    
    /**** Cria query e retorna toda lista de usuários ****/
    public List<Customer> listCustomers(){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from Customer as customers");
        List<Customer> lista = q.list();
        closeSession(session);
        return lista;
    }
    
    /**** Carrega um usuário utilizando o id unico como parametro ****/
    public Customer getById(Long id){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from Customer as customers where customers.id ="+id);
        Customer customer = (Customer)q.uniqueResult();
        closeSession(session);
        return customer;
    }
    
    /*** Carrega lista de endereços do cliente ***/
    public List<Address> getCustomerAddress(Long id){
        Customer customer=this.getById(id);
        List<Address> addresses = customer.getAddresses();
        
        return addresses;
    }
            
    /**** Carrega o usuário do cliente ****/
    public Customer getCustomerUser(String name, String password){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from Customer as customers where customers.user.name= '"+name+"' and customers.user.password = '"+password+"' and customers.user.userRole=2");
        Customer customer = (Customer)q.uniqueResult();
        if(customer !=null){
            if(!customer.getUser().isEnable()){
                customer = null;
            }else{
                customer.getUser().setLastAccess(new Date());
            }
        }
        closeSession(session);
        return customer;
    } 
    /**** Carrega o usuário do cliente ****/
    public Customer getCustomerByEmail(String email){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from Customer as customers where customers.user.email='"+email+"' and customers.user.userRole=2");
        Customer customer = (Customer)q.uniqueResult();
        if(customer !=null){
            if(!customer.getUser().isEnable()){
                customer = null;
            }
        }
        closeSession(session);
        return customer;
    }
    
}
