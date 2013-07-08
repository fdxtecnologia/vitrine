/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.dao.CategoryDAO;
import br.com.fdxtecnologia.comparador.dao.MarketDAO;
import br.com.fdxtecnologia.comparador.dao.ProductDAO;
import br.com.fdxtecnologia.comparador.login.Permission;
import br.com.fdxtecnologia.comparador.model.Category;
import br.com.fdxtecnologia.comparador.model.Market;
import br.com.fdxtecnologia.comparador.model.Product;
import br.com.fdxtecnologia.comparador.model.Role;
import java.util.List;

/**
 *
 * @author Andre
 */
@Resource
@Permission({Role.ADMIN, Role.USER})
public class ProductsController {

    private ProductDAO dao;
    private final Result result;
    private CategoryDAO categoryDAO;
    private MarketDAO marketDAO;

    public ProductsController(ProductDAO dao, Result result, CategoryDAO categoryDAO, MarketDAO marketDAO) {
        this.dao = dao;
        this.result = result;
        this.categoryDAO = categoryDAO;
        this.marketDAO = marketDAO;
    }

    public void listProducts() {
    }

    public void addProduct() {
        List<Category> categorias = categoryDAO.listAll(Category.class);
        List<Market> markets = marketDAO.listAll(Market.class);
        result.include("categories", categorias);
        result.include("markets", markets);
    }

    public void save(Product product) {
        product.setMarket(marketDAO.loadById(product.getMarket()));
        dao.save(product);
        result.include("message", "Produto salvo com sucesso!");
    }

    public void index() {
    }
}
