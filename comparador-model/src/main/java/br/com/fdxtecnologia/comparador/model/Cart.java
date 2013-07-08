/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author guilherme
 */
@Entity
@Table(name = "carts")
public class Cart implements Serializable{
    
    @Id
    @GeneratedValue
    private Long id;
    @ManyToOne
    private Customer customer;
    @Temporal(TemporalType.TIMESTAMP)
    private Date saveDate;
    @Column(columnDefinition = "TEXT")
    private String listProdJSON;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Customer getCutomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Date getSaveDate() {
        return saveDate;
    }

    public void setSaveDate(Date saveDate) {
        this.saveDate = saveDate;
    }

    public String getListProdJSON() {
        return listProdJSON;
    }

    public void setListProdJSON(String listProdJSON) {
        this.listProdJSON = listProdJSON;
    }
    
}
