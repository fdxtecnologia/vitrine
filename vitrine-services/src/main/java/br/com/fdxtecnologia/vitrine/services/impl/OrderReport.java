/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.jasperreports.Report;
import br.com.fdxtecnologia.comparador.model.Order;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Andre
 */
@Resource
public class OrderReport implements Report {

    private final List<Order> data;
    private Map<String, Object> parameters;

    public OrderReport(List<Order> data) {
        this.data = data;
        this.parameters = new HashMap<String, Object>();
    }

    @Override
    public String getTemplate() {
        return "order.jasper";
    }

    @Override
    public Map<String, Object> getParameters() {
        return this.parameters;
    }

    @Override
    public Collection getData() {
        return this.data;
    }

    @Override
    public String getFileName() {
        return "order";// + data.get(0).getId();
    }

    @Override
    public Report addParameter(String string, Object o) {
        this.parameters.put(string, o);
        return this;
    }

    @Override
    public boolean isCacheable() {
        return false;
    }
}
