/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.login;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.SessionScoped;
import br.com.fdxtecnologia.comparador.model.User;

/**
 *
 * @author guilherme
 */
@Component
@SessionScoped
public class UserSession {
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    public boolean isLogged(){
        return user!=null;
    }
    
    public void logout(){
        user = null;
    }
}
