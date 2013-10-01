/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.test;

/**
 *
 * @author Andre
 */
public class Teste {

    public static void main(String[] args) {
        String num = "1234123412341234";
        num = num.substring(0,4)+"XXXXXXXX"+num.substring(12,16);
        System.out.println(num);
    }
}
