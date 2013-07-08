/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.factory.HibernateFactory;
import br.com.fdxtecnologia.comparador.model.Market;
import br.com.fdxtecnologia.comparador.model.Product;
import br.com.fdxtecnologia.comparador.model.Sort;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Andre
 */
@Component
public class ProductDAO extends GenericDAO<Product> {

    public List<Product> getProductsByMarket(Market market) {
        Session s = HibernateFactory.getSession();
        try {
            Query q = s.createQuery("select p from Product p where p.market.id = :market");
            q.setParameter("market", market.getId());
            List<Product> list = new ArrayList<Product>((List<Product>) q.list());
            return list;
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
        return null;
    }
    
    public List<Product> getProductsByMarket(Market market, int page, int limit){
        Session s = HibernateFactory.getSession();
        try {
            Query q = s.createQuery("select p from Product p where p.market.id = :market");
            q.setParameter("market", market.getId());
            q.setFirstResult((page - 1) * limit);
            q.setMaxResults(limit);
            List<Product> list = new ArrayList<Product>((List<Product>) q.list());
            return list;
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
        return null;
    }

    public Object[] getProductsByTitle(String search, int page, int limit, Sort order, Long market, Long category) {
        Session s = HibernateFactory.getSession();
        try {
            String where;
            Integer count = null;
            if (category != null) {
                Query queryIds = s.createSQLQuery("select products_id from products_categories where categories_id = " + category);
                List idProdutos = queryIds.list();
                String idsString = "";
                for (BigInteger l : (List<BigInteger>) idProdutos) {
                    idsString += l.intValue() + ",";
                }
                idsString = idsString.substring(0, idsString.length() - 1);
                where = " where lower(p.title) like '%" + search + "%' and p.id in (" + idsString + ")";
                count = idProdutos.size();
            } else {
                where = " where lower(p.title) like '%" + search + "%' ";
            }

            String query = "from Product p"
                    + where
                    + (market != null ? " and p.market.id = " + market : "")
                    + (order != null ? " order by " + order.getField() + " " + order.getDir() : "");

            Query q = s.createQuery(query);
            q.setFirstResult((page - 1) * limit);
            q.setMaxResults(limit);
            List<Product> list = (List<Product>) q.list();
            /**
             * Result Object, containing the list of results and the quantity of
             * results (for pagination)
             */
            Object[] res = new Object[2];
            res[0] = list;
            res[1] = count != null ? count : ((Long) s.createQuery("select count(id) " + query).iterate().next()).longValue();
            return res;
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
        return null;
    }

    public Product getProductWithCategories(Long id) {
        Session s = HibernateFactory.getSession();
        try {
            Query q = s.createQuery("from Product p where p.id = :id").setLong("id", id);
            Product p = (Product) q.uniqueResult();
            Hibernate.initialize(p.getCategories());
            return p;
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            closeSession(s);
        }
        return null;
    }

    public static void main(String[] args) {
        new ProductDAO().getProductsByTitle("produto", 1, 10, Sort.A_Z, null, null);
    }
}
