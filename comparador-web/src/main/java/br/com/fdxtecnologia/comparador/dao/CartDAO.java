/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.controllers.CartController;
import br.com.fdxtecnologia.comparador.factory.HibernateFactory;
import br.com.fdxtecnologia.comparador.model.Cart;
import br.com.fdxtecnologia.comparador.model.CartJSON;
import br.com.fdxtecnologia.comparador.model.Customer;
import br.com.fdxtecnologia.comparador.model.Product;
import br.com.fdxtecnologia.comparador.model.ProductJSON;
import br.com.fdxtecnologia.comparador.utils.Utils;
import com.google.gson.Gson;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author guilherme
 */
@Component
public class CartDAO extends GenericDAO<Cart>{
    
    
    /*** Retorna lista de carrinhos ordenadas por data**/
    public List<Cart> listCartHistory(Customer customer){
        
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from Cart as carts where carts.customer.id ="+customer.getId()+" order by carts.saveDate");
        List<Cart> list = q.list();
        closeSession(session);
        
        return list;
    }
 
   public Map<Product,Integer> getProducts(HttpServletRequest request, ProductDAO productDAO){     
        Gson gson = new Gson();
        String cart = "";
        try {
            cart = URLDecoder.decode(Utils.getCookieValue(request.getCookies(), "cart"), "UTF-8");
        } catch (Exception e) {
            Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, e);
        }
        Map<Product, Integer> products = new HashMap<Product, Integer>();
        if (cart != null) {
            CartJSON cartJSON = gson.fromJson(cart, CartJSON.class);
            for (ProductJSON p : cartJSON.getProducts()) {
                Product product = productDAO.getProductWithCategories(p.getIdProduct());
                products.put(product, p.getQuantity());
            }
        }
        
        return products;
    }
   
    /*** Retorna carrinho passando como parametro apenas o id ***/
    public Cart getById(Long id){
        
        Session session = HibernateFactory.getSession();
        Query q = session.createQuery("from Cart as carts where carts.id="+id);
        Cart cart = (Cart)q.uniqueResult();
        
        closeSession(session);
        return cart;
    }
    
}
