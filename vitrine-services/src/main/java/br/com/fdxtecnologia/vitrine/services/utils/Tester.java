/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.utils;

import java.io.IOException;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;

/**
 *
 * @author Andre
 */
public class Tester {

    public static void main(String[] args) throws IOException {
        String url = "http://localhost:8080/vitrine-services/products/listProducts";
        HttpClient client = new HttpClient();
        PostMethod method = new PostMethod(url);
        method.setParameter("marketId", "3");
        method.setParameter("page", "0");
        method.setParameter("limit", "24");
        int executeMethod = client.executeMethod(method);
        System.out.println(method.getResponseBodyAsString());
    }
}
