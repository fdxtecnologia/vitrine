/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.controllers;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.dao.AddressDAO;

/**
 *
 * @author guilherme
 */
@Resource
public class AddressController {
    
    private Result result;
    private AddressDAO dao;
    
    public AddressController(Result result, AddressDAO dao){
        this.result = result;
        this.dao = dao;
    }
    
}
