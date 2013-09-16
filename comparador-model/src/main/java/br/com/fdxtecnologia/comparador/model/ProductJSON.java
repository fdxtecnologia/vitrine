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
    private Integer quantity;
    private BigDecimal price;
    private BigDecimal totalPrice;
    private String sku;
    public static final Type TYPE = new TypeToken<List<ProductJSON>>() {
    }.getType();
    private boolean isFav;
    private boolean isOnSale;

    public ProductJSON(Long idProduct, int quantity) {
        this.idProduct = idProduct;
        this.quantity = quantity;
    }

    public ProductJSON() {
    }

    public ProductJSON(Long idProduct, String sku, String title, Integer quantity, BigDecimal price) {
        this.sku = sku;
        this.idProduct = idProduct;
        this.title = title;
        this.quantity = quantity;
        this.price = price;
        this.totalPrice = this.price.multiply(new BigDecimal(this.quantity));
    }

    public ProductJSON(Product product) {

        this.sku = product.getSku();
        this.idProduct = product.getId();
        this.title = product.getTitle();
        this.quantity = 0;
        this.price = product.getPrice();
        this.totalPrice = BigDecimal.ZERO;
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

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
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

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public boolean isIsFav() {
        return isFav;
    }

    public void setIsFav(boolean isFav) {
        this.isFav = isFav;
    }

    public boolean isIsOnSale() {
        return isOnSale;
    }

    public void setIsOnSale(boolean isOnSale) {
        this.isOnSale = isOnSale;
    }
    
    
}
