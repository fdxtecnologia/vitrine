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
public class CategoryJSON {

    private Long key;
    private String title;
    private boolean activate;
    private List<CategoryJSON> children;

    public CategoryJSON() {
    }

    public CategoryJSON(Long key, String title, List<CategoryJSON> children, boolean activate) {
        this.key = key;
        this.title = title;
        this.activate = activate;
        this.children = children;
    }

    public Long getKey() {
        return key;
    }

    public String getTitle() {
        return title;
    }

    public List<CategoryJSON> getChildren() {
        return children;
    }

    public boolean isActivate() {
        return activate;
    }

    public void setActivate(boolean activate) {
        this.activate = activate;
    }
}
