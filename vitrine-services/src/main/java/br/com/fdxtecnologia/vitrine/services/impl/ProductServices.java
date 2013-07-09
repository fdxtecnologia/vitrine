/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.com.fdxtecnologia.comparador.model.Market;
import br.com.fdxtecnologia.comparador.model.Product;
import br.com.fdxtecnologia.comparador.model.ProductJSON;
import br.com.fdxtecnologia.vitrine.services.dao.MarketDAO;
import br.com.fdxtecnologia.vitrine.services.dao.ProductDAO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Andre
 */
@Resource
@Path("/products")
public class ProductServices {

    private ProductDAO productDAO;
    private MarketDAO marketDAO;
    private Result result;

    public ProductServices(ProductDAO productDAO, MarketDAO marketDAO, Result result) {
        this.productDAO = productDAO;
        this.marketDAO = marketDAO;
        this.result = result;
    }

    @Post
    public void listProducts(Long marketId, int page, int limit) {
        Market m = marketDAO.findById(marketId);
        List<Product> list = productDAO.getProductsByMarket(m, page, limit);
        List<ProductJSON> products = new ArrayList<ProductJSON>();
        for (Product p : list) {
            products.add(new ProductJSON(p));
        }
        result.use(Results.json()).withoutRoot().from(products).serialize();
    }
}
