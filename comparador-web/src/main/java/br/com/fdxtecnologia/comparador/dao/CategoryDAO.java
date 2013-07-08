/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.dao;

import br.com.caelum.vraptor.ioc.Component;
import br.com.fdxtecnologia.comparador.factory.HibernateFactory;
import br.com.fdxtecnologia.comparador.model.Category;
import br.com.fdxtecnologia.comparador.model.CategoryJSON;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Andre
 */
@Component
public class CategoryDAO extends GenericDAO<Category> {

    public List<Category> getCategoriesByParent(Long parent) {
        Session s = HibernateFactory.getSession();
        Query q = s.createQuery("from Category as cat left join cat.children where cat.parent.id = :parent").setParameter("parent", parent);
        List<Category> lista = q.list();
        closeSession(s);
        return lista;
    }

    public CategoryJSON getCategoryTree() {
        Session s = HibernateFactory.getSession();
        Query q = s.createQuery("from Category root where root.parent is null");
        Category root = (Category) q.uniqueResult();
        CategoryJSON categoriesJSON = new CategoryJSON(root.getId(), root.getName(), getChildrenCategories(root), false);
        closeSession(s);
        return categoriesJSON;
    }

    private List<CategoryJSON> getChildrenCategories(Category root) {
        List<CategoryJSON> categories = new ArrayList<CategoryJSON>();
        for (Category c : root.getChildren()) {
            if (c.getChildren() != null && !c.getChildren().isEmpty()) {
                categories.add(new CategoryJSON(c.getId(), c.getName(), getChildrenCategories(c), false));
            } else {
                categories.add(new CategoryJSON(c.getId(), c.getName(), null, false));
            }
        }
        return categories;
    }
}
