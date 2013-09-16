/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.model;

import com.thoughtworks.xstream.annotations.XStreamImplicit;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author guilherme
 */
@Entity
@Table(name = "orders")
public class Order implements Serializable {

    @Id
    @GeneratedValue
    private Long id;
    @ManyToOne
    private Customer customer;
    @Column(columnDefinition = "TEXT")
    private String cartInfo;
    @Transient
    private Payment payment;
    @ManyToOne
    private Address shippingAddress;
    private BigDecimal totalPrice;
    private BigDecimal shippingPrice;
    @Transient
    @XStreamImplicit(itemFieldName = "products")
    private List<ProductJSON> products;
    /*@Temporal(TemporalType.TIMESTAMP)
     private Date processedDate;*/

    public List<ProductJSON> getProducts() {
        return products;
    }

    public void setProducts(List<ProductJSON> products) {
        this.products = products;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getCartInfo() {
        return cartInfo;
    }

    public void setCartInfo(String cartInfo) {
        this.cartInfo = cartInfo;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public Address getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(Address shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getShippingPrice() {
        return shippingPrice;
    }

    public void setShippingPrice(BigDecimal shippingPrice) {
        this.shippingPrice = shippingPrice;
    }

    /*public Date getProcessedDate() {
     return processedDate;
     }

     public void setProcessedDate(Date processedDate) {
     this.processedDate = processedDate;
     }*/
}
