/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.com.fdxtecnologia.comparador.dao.CategoryDAO;
import br.com.fdxtecnologia.comparador.login.Permission;
import br.com.fdxtecnologia.comparador.model.Category;
import br.com.fdxtecnologia.comparador.model.CategoryJSON;
import br.com.fdxtecnologia.comparador.model.Role;

/**
 *
 * @author Andre
 */
@Resource
@Permission({Role.ADMIN,Role.USER})
public class CategoriesController {

    private CategoryDAO dao;
    private final Result result;

    public CategoriesController(CategoryDAO dao, Result result) {
        this.dao = dao;
        this.result = result;
    }

    public void listCategories() {
    }
    
    @Post
    public void saveCategory(Category category){
        category.setParent(dao.loadById(category.getParent()));
        if(category.getId() != null){
            dao.update(category);
        } else {
            dao.save(category);
        }
        this.result.use(Results.nothing());
    }
    
    public void tree(){
        CategoryJSON tree = dao.getCategoryTree();
        this.result.use(Results.json()).withoutRoot().from(tree).include("children").serialize();
    }

    public void form() {
        System.out.println("Vish");
    }
}
