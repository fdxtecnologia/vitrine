/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.front.controllers.CustomerSession;
import br.com.fdxtecnologia.comparador.front.controllers.FrontController;
import br.com.fdxtecnologia.comparador.login.Public;
import br.com.fdxtecnologia.comparador.login.UserSession;

/**
 *
 * @author guilherme
 */
@Resource
@Public
public class IndexController {
    
    private Result result;
    private UserSession userSession;
    private CustomerSession customerSession;
    
    public IndexController(Result result, UserSession userSession, CustomerSession customerSession){
        this.result = result;
        this.userSession = userSession;
        this.customerSession = customerSession;
    }
    
    @Path({"/admin","/admin/"})
    public void index(){
        if(!userSession.isLogged()){
            result.redirectTo(LoginController.class).login();
        }
    }
    
}
