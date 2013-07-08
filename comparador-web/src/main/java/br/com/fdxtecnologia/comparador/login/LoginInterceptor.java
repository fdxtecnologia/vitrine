/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.login;

import br.com.caelum.vraptor.InterceptionException;
import br.com.caelum.vraptor.Intercepts;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.InterceptorStack;
import br.com.caelum.vraptor.interceptor.Interceptor;
import br.com.caelum.vraptor.resource.ResourceMethod;
import br.com.fdxtecnologia.comparador.controllers.LoginController;
import br.com.fdxtecnologia.comparador.front.controllers.CustomerSession;
import br.com.fdxtecnologia.comparador.model.Role;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Collection;

/**
 *
 * @author guilherme
 */
//@Intercepts
public class LoginInterceptor implements Interceptor{
    
    private UserSession userSession;
    private CustomerSession customerSession;
    private Result result;
    private Method m;
    
    public LoginInterceptor(UserSession userSession,CustomerSession customerSession, Result result){
        this.customerSession = customerSession;
        this.userSession = userSession;
        this.result = result;
    }

    private boolean hasAcess(Permission permission) {
        if (permission == null) {
            return true;
        }
        Collection<Role> roles = Arrays.asList(permission.value());

        return roles.contains(userSession.getUser().getUserRole());
    }

    public void intercept(InterceptorStack is, ResourceMethod rm, Object o) throws InterceptionException {
        
        if (!userSession.isLogged()) {
            result.redirectTo(LoginController.class).login();
        } else {
            Permission methodPermission = rm.getMethod().getAnnotation(Permission.class);

            Permission controllerPermission = rm.getResource().getType().getAnnotation(Permission.class);

            if (hasAcess(methodPermission) && hasAcess(controllerPermission)) {
                is.next(rm, o);
            } else {
                System.out.println("Permission Denied");
            }
        }
    }

    public boolean accepts(ResourceMethod rm) {
        return !rm.getResource().getType().isAnnotationPresent(Public.class);
    }
}
