/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.model;

import java.util.List;

/**
 *
 * @author Andre
 */
public class CartJSON {

    private Long id;
    private List<ProductJSON> products;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<ProductJSON> getProducts() {
        return products;
    }

    public void setProducts(List<ProductJSON> products) {
        this.products = products;
    }
}
