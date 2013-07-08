/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.model;

/**
 *
 * @author Andre
 */
public enum Sort {

    PRICE_ASC("price", "asc", "sort.price.asc"), PRICE_DESC("price", "desc", "sort.price.desc"), A_Z("title", "asc", "sort.az.asc"), Z_A("title", "desc", "sort.az.desc");
    private String field;
    private String dir;
    private String label;

    private Sort(String field, String dir, String label) {
        this.field = field;
        this.dir = dir;
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public String getField() {
        return field;
    }

    public String getDir() {
        return dir;
    }
}
