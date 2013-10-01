/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.model;

import com.google.gson.reflect.TypeToken;
import java.io.Serializable;
import java.lang.reflect.Type;
import java.util.List;

/**
 *
 * @author Andre
 */
public class CreditCard implements Serializable {

    private String flag;
    private String number;
    private String owner;
    public static final Type TYPE = new TypeToken<List<CreditCard>>() {
    }.getType();

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 89 * hash + (this.flag != null ? this.flag.hashCode() : 0);
        hash = 89 * hash + (this.number != null ? this.number.hashCode() : 0);
        hash = 89 * hash + (this.owner != null ? this.owner.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final CreditCard other = (CreditCard) obj;
        if ((this.flag == null) ? (other.flag != null) : !this.flag.equals(other.flag)) {
            return false;
        }
        if ((this.number == null) ? (other.number != null) : !this.number.equals(other.number)) {
            return false;
        }
        if ((this.owner == null) ? (other.owner != null) : !this.owner.equals(other.owner)) {
            return false;
        }
        return true;
    }
}
