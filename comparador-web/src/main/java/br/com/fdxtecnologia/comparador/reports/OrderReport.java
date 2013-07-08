/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.reports;

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

    public String getTemplate() {
        return "order.jasper";
    }

    public Map<String, Object> getParameters() {
        return this.parameters;
    }

    public Collection getData() {
        return this.data;
    }

    public String getFileName() {
        return "order";// + data.get(0).getId();
    }

    public Report addParameter(String string, Object o) {
        this.parameters.put(string, o);
        return this;
    }

    public boolean isCacheable() {
        return false;
    }
}
