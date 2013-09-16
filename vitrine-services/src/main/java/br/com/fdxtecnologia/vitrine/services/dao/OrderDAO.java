/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.model.Order;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Andre
 */
@Component
public class OrderDAO extends GenericDAO<Order> {

    public OrderDAO(Session session) {
        super(session);
    }

    public List<Order> getNonProcessedOrders() {
        Criteria criteria = session.createCriteria(Order.class);
        criteria.add(Restrictions.isNull("processedDate"));
        return criteria.list();
    }
}
