/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.model.Market;
import br.com.fdxtecnologia.comparador.model.Product;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Andre
 */
@Component
public class ProductDAO extends GenericDAO<Product> {

    public ProductDAO(Session session) {
        super(session);
    }

    public List<Product> getProductsByMarket(Market m, int page, int limit) {
        String q = "from Product p where p.market = " + m.getId();
        Query query = session.createQuery(q).setFirstResult(page * limit).setMaxResults(limit);
        
        return query.list();
    }
}
