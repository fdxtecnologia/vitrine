/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.dao.UserDAO;
import br.com.fdxtecnologia.comparador.login.Public;
import br.com.fdxtecnologia.comparador.login.UserSession;
import br.com.fdxtecnologia.comparador.model.User;
import java.util.Date;

/**
 *
 * @author guilherme
 */
@Resource
@Public
public class LoginController {
    
    private UserSession userSession;
    private UserDAO dao;
    private Result result;
    
    public LoginController(Result result, UserDAO dao, UserSession userSession){
        this.dao = dao;
        this.result = result;
        this.userSession = userSession;
    }
    
    @Path("/admin/login")
    public void login(){
        
    }
    
    @Path("/admin/login/authenticate")
    public void authenticate(User user){
        userSession.setUser(dao.authenticate(user));
        if(userSession.isLogged()){
            userSession.getUser().setLastAccess(new Date());
            dao.update(userSession.getUser());
            result.redirectTo(IndexController.class).index();
        }else{
            result.include("mensagem","Usuário e senha inválidos").redirectTo(LoginController.class).login();
        }
    }
    
    @Path("/admin/logout")
    public void logout(){
        userSession.logout();
        System.out.println("USUARIO :"+userSession.getUser());
        result.redirectTo(LoginController.class).login();
    }
    
}
