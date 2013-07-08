/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.model;

import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author guilherme
 */
public class ProductJSON {

    private Long idProduct;
    private String title;
    private int quantity;
    private BigDecimal price;
    private BigDecimal totalPrice;
    public static Type TYPE = new TypeToken<List<ProductJSON>>() {
    }.getType();

    public ProductJSON(Long idProduct, int quantity) {
        this.idProduct = idProduct;
        this.quantity = quantity;
    }

    public ProductJSON() {
    }

    public ProductJSON(Long idProduct, String title, int quantity, BigDecimal price) {
        this.idProduct = idProduct;
        this.title = title;
        this.quantity = quantity;
        this.price = price;
        this.totalPrice = this.price.multiply(new BigDecimal(this.quantity));
    }

    public Long getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(Long idProduct) {
        this.idProduct = idProduct;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }
}
