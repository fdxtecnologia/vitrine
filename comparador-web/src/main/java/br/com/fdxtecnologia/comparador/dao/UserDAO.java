/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.factory.HibernateFactory;
import br.com.fdxtecnologia.comparador.model.Role;
import br.com.fdxtecnologia.comparador.model.User;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author guilherme
 */
@Component
public class UserDAO extends GenericDAO<User>{
    
    public List<User> listUsers(){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from User as users");
        List<User> list = q.list();
        closeSession(session);
        return list;  
    }
    
    public User getById(Long id){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from User as users where users.id = "+id);
        User user = (User)q.uniqueResult();
        closeSession(session);
        return user;
    }
    
    public User authenticate(User user){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from User as users where users.name='"+user.getName()+"' and users.password='"+user.getPassword()+"' and users.userRole=1 or users.userRole=0");
        User usuario=(User)q.uniqueResult();
        if(usuario !=null){
            if(!usuario.isEnable()){
                usuario = null;
            }else{
                usuario.setLastAccess(new Date());
            }
        }
        closeSession(session);
        return usuario;
    }
    
    public User getUserByEmail(String email){
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from User as users where users.email='"+email+"'");
        User user = (User)q.uniqueResult();
        if(user !=null){
            if(!user.isEnable()){
                user = null;
            }
        }
        closeSession(session);
        return user;
    }
    
    public String generateNewPassword(){
        
        return "";
    }
}
