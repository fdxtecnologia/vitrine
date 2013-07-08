/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.factory.HibernateFactory;
import br.com.fdxtecnologia.comparador.model.Market;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Andre
 */
@Component
public class MarketDAO extends GenericDAO<Market> {

    public List<Market> getMarketsByProductSearch(String query) {
        Session s = HibernateFactory.getSession();
        try {
            Query q = s.createQuery("select distinct p.market from Product p where p.title like '%" + query + "%'");
            List<Market> list = (List<Market>) q.list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
        return null;
    }
    
    public static void main(String[] args) {
        List<Market> markets = new MarketDAO().getMarketsByProductSearch("produto");
    }
}
