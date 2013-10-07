/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.model;

import com.google.gson.Gson;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author Andre
 */
@Entity
@Table(name = "customers")
public class Customer implements Serializable {

    @Id
    @GeneratedValue
    private Long id;
    private String firstName;
    private String lastName;
    @Column(unique=true)
    private String cpf;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<Address> addresses;
    @ManyToOne(cascade = CascadeType.ALL)
    private User user;
    private String cardInfo;
    @Transient
    private List<CreditCard> cardListJSON;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Address> getAddresses() {
        return addresses;
    }

    public void setAddresses(List<Address> addresses) {
        this.addresses = addresses;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getCardInfo() {
        return cardInfo;
    }

    public void setCardInfo(String cardInfo) {
        this.cardInfo = cardInfo;
    }

    public List<CreditCard> getCardListJSON() {
        return cardListJSON;
    }

    public void setCardListJSON(List<CreditCard> cardListJSON) {
        this.cardListJSON = cardListJSON;
    }

    public void addCreditCard(CreditCard cc, Gson gson) {
        if (this.getCardInfo() != null) {
            this.setCardListJSON((List<CreditCard>) gson.fromJson(this.getCardInfo(), CreditCard.TYPE));
        } else {
            this.setCardListJSON(new ArrayList<CreditCard>());
        }
        this.getCardListJSON().add(cc);
        this.setCardInfo(gson.toJson(this.getCardListJSON(), CreditCard.TYPE));
    }

    public void removeCreditCard(CreditCard cc, Gson gson) {
        this.setCardListJSON((List<CreditCard>) gson.fromJson(this.getCardInfo(), CreditCard.TYPE));
        if (this.cardListJSON.contains(cc)) {
            this.cardListJSON.remove(cc);
        }
        this.setCardInfo(gson.toJson(this.getCardListJSON(), CreditCard.TYPE));
    }
}
