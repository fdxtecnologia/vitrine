/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.fdxtecnologia.comparador.dao.CategoryDAO;
import br.com.fdxtecnologia.comparador.dao.MarketDAO;
import br.com.fdxtecnologia.comparador.dao.ProductDAO;
import br.com.fdxtecnologia.comparador.login.Permission;
import br.com.fdxtecnologia.comparador.model.Category;
import br.com.fdxtecnologia.comparador.model.Market;
import br.com.fdxtecnologia.comparador.model.Product;
import br.com.fdxtecnologia.comparador.model.Role;
import com.google.gson.Gson;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Andre
 */
@Resource
@Path("/admin/market")
@Permission({Role.ADMIN, Role.USER})
public class MarketController {

    private MarketDAO dao;
    private Result result;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    public MarketController(MarketDAO dao, Result result, ProductDAO productDAO, CategoryDAO categoryDAO) {
        this.dao = dao;
        this.result = result;
        this.productDAO = productDAO;
        this.categoryDAO = categoryDAO;
    }

    public void listMarket() {
        List<Market> list = dao.listAll(Market.class);
        result.include("markets", list);
    }

    public void addMarket() {
    }

    @Path("/editMarket/{id}")
    public void editMarket(Long id) {
        result.include("market", dao.loadById(new Market(id)));
    }

    @Post
    public void saveMarket(Market market) {
        if (market.getId() == null) {
            dao.save(market);
        } else {
            dao.update(market);
        }
        result.include("mensagem", "Sucesso!");
        result.redirectTo(MarketController.class).listMarket();
    }

    @Path("/listProducts/{id}")
    public void listProducts(Long id) {
        Market market = dao.loadById(new Market(id));
        List<Product> products = productDAO.getProductsByMarket(market);
        result.include("market", market);
        result.include("products", products);
    }

    @Path("/addProduct/{id}")
    public void addProduct(Long id) {
        result.include("marketId", id);
    }

    @Path("/editProduct/{id}")
    public void editProduct(Long id) {
        Product product = productDAO.getProductWithCategories((id));
        result.include("product", product);
        List<String> categories = new ArrayList<String>();
        for (Category c : product.getCategories()) {
            categories.add(c.getId().toString());
        }
        Gson serializer = new Gson();
        String productCategories = serializer.toJson(categories);
        result.include("productCategories", productCategories);
    }

    @Post
    public void saveProduct(Product product, String categories) {
        if (!categories.isEmpty()) {
            String[] cats = categories.split(",");
            product.setCategories(new HashSet<Category>());
            for (String c : cats) {
                product.getCategories().add(categoryDAO.loadById(new Category(Long.parseLong(c))));
            }
        }

        if (product.getId() == null) {
            product.setMarket(dao.loadById(product.getMarket()));
            productDAO.save(product);
        } else {
            productDAO.update(product);
        }
        result.include("mensagem", "Sucesso!");
        result.redirectTo(MarketController.class).listProducts(product.getMarket().getId());
    }

    @Post
    public void uploadProducts(UploadedFile arquivo, Market m) {
        try {
            XSSFWorkbook workbook = new XSSFWorkbook(arquivo.getFile());
            XSSFSheet sheet = workbook.getSheetAt(0);
            for(int x = 1;x<sheet.getLastRowNum();x++){
                XSSFRow row = sheet.getRow(x);
                String sku = row.getCell(0).getStringCellValue();
                String productName = row.getCell(1).getStringCellValue();
                Double price = row.getCell(4).getNumericCellValue();
                
                Product p = new Product();
                p.setSku(sku);
                p.setMarket(dao.loadById(m));
                p.setTitle(productName);
                p.setDescription(productName);
                p.setPrice(new BigDecimal(price.toString()));
                p.setActive(true);
                p.setUnit("UN");
                productDAO.save(p);
                
            }
            result.include("mensagem","Produtos importados com sucesso");
            result.forwardTo(MarketController.class).listProducts(m.getId());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
