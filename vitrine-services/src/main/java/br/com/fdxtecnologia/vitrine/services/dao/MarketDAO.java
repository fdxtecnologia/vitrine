/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.model.Market;
import org.hibernate.Session;

/**
 *
 * @author Andre
 */
@Component
public class MarketDAO extends GenericDAO<Market> {

    public MarketDAO(Session session) {
        super(session);
    }
}
