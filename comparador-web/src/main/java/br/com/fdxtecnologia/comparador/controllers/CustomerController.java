/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.dao.CustomerDAO;
import br.com.fdxtecnologia.comparador.login.Permission;
import br.com.fdxtecnologia.comparador.model.Customer;
import br.com.fdxtecnologia.comparador.model.Role;
import java.util.List;

/**
 *
 * @author guilherme
 */
@Resource
@Permission({Role.ADMIN, Role.USER, Role.CUST})
public class CustomerController {
    
    CustomerDAO dao;
    Result result;
    
    public CustomerController(Result result, CustomerDAO dao){
        this.dao = dao;
        this.result = result;
    }
    
    /**** Adiciona Cliente(/customer/add) e Edita Cliente(/customer/add/{id}) *****/
    @Path({"admin/customer/add"})
    public void addCustomer(){
        
    }
    
    @Path({"admin/customer/edit/{id}"})
    public void editCustomer(Long id){
        
        result.include("customer", dao.getById(id));
    }
    
    /**** Lista Clientes *****/
    @Path("admin/customer/list")
    public void listCustomer(){
        result.include("customers", dao.listCustomers());
    }
    
    /**** Remove Cliente *****/
    @Path("admin/customer/remove/{id}")
    public void removeCustomer(Long id){
        Customer customer = dao.getById(id);
        customer.getUser().setEnable(false);
        dao.update(customer);
        result.include("mensagem","Sucesso");
        result.redirectTo(CustomerController.class).listCustomer();
    }
    
    /**** Salva Cliente ****/
    @Path("admin/customer/save")
    public void save(Customer customer){
        if (customer.getId() == null) {
            List<Customer> listCustomers = dao.listCustomers();
            int countEmail=0;
            int countUser=0;
           for(Customer c: listCustomers){
               if(c.getUser().getEmail().equals(customer.getUser().getEmail())){
                   countEmail++;
               }
               if(c.getUser().getName().equals(customer.getUser().getName())){
                   countUser++;
               }
           }
           if(countEmail==0 && countUser==0){
             customer.getUser().setUserRole(Role.CUST);
             customer.getUser().setEnable(true);
             dao.save(customer);
           }else{
               if(countEmail!=0 && countUser!=0){
                   result.include("mensagem","email.username.already.in.use");
               }if(countEmail!=0){
                   result.include("mensagem","email.already.in.use");
               }else if(countUser!=0){
                   result.include("mensagem","username.already.in.use");
               }
           }

        } else {
            dao.update(customer);
        }
        result.include("mensagem","Sucesso");
        result.redirectTo(CustomerController.class).listCustomer();
    }
    
    public void index(){
        
    }
    
}
