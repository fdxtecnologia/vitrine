/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.fdxtecnologia.comparador.dao.UserDAO;
import br.com.fdxtecnologia.comparador.login.Permission;
import br.com.fdxtecnologia.comparador.model.Role;
import br.com.fdxtecnologia.comparador.model.User;
import java.util.List;

/**
 *
 * @author guilherme
 */
@Resource
@Permission({Role.ADMIN})
public class UserController {
    
    private UserDAO dao;
    private Result result;
    private Validator validator;
   
    public UserController(UserDAO dao, Result result, Validator validator){
        this.dao = dao;
        this.result = result;
        this.validator = validator;
    }
    
    @Path("/admin/user/addUser")
    public void addUser(){
        result.include("listRoles", Role.values());
    }
    
    @Path("/admin/user/listUsers")
    public void listUsers(){
        List<User> userList = dao.listUsers();
        result.include("users",userList);
    }
    
    @Path("/admin/user/removeUser/{id}")
    public void removeUser(Long id){
        User user = dao.getById(id);
        user.setEnable(false);
        dao.update(user);
        result.include("mensagem","Usuário inativo!");
        result.redirectTo(UserController.class).listUsers();
    }
    
    @Path("/admin/user/editUser/{id}")
    public void editUser(Long id){
        User user = dao.getById(id);
        result.include("user",user);
        result.include("listRoles",Role.values());
    }
    
    @Path("/admin/user/save")
    public void save(final User user){
        
        if(user.getName()==null){
            validator.add(new ValidationMessage("Nome obrigatório", "user.name"));
        }
        
        if(user.getEmail()==null){
            validator.add(new ValidationMessage("E-Mail obrigatório", "user.email"));
        }
        
        if(user.getPassword()==null){
            validator.add(new ValidationMessage("Senha obrigatória", "user.password"));
        }
        
        validator.onErrorUsePageOf(UserController.class).addUser();
        
        dao.save(user);
        result.include("mensagem","Cadastrado!");
        result.redirectTo(UserController.class).listUsers();
    }
    
    @Path("/admin/user/update")
    public void update(User user){
        dao.update(user);
        result.include("mensagem","Usuário alterado!");
        result.redirectTo(UserController.class).listUsers();
    }
    
    public void index(){
        
    }
    
}
