/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import org.apache.xmlbeans.impl.soap.Text;

/**
 *
 * @author Andre
 */
public class Utils {

    public static String getCookieValue(Cookie[] cookies, String name) {
        for (Cookie c : cookies) {
            if (c.getName().equals(name)) {
                return c.getValue();
            }
        }
        return null;
    }

    public static Cookie getCookie(Cookie[] cookies, String name) {

        for (Cookie c : cookies) {
            if (c.getName().equals(name)) {
                return c;
            }
        }
        return null;
    }

    public static void createCookie(HttpServletResponse response, String name, String value) {

        Cookie cookie = new Cookie(name, value);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    public static void setCookieValue(HttpServletResponse response, Cookie cookie, String value) {

        cookie.setValue(value);
        cookie.setPath(value);
        response.addCookie(cookie);
    }

    public static String getMonetaryFormatted(Number n) {
        DecimalFormat df = new DecimalFormat("#,###,##0.00");
        return df.format(df);
    }
    
    public static String digestToMD5(String str){
        try{
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(Integer.toHexString((int) (b & 0xff)));
            }
            return sb.toString();
        }catch(NoSuchAlgorithmException e){
            System.err.println(e);
        }
        return null;
    }
    
    public static boolean validaCPF (String strCpf ) {

        int     d1, d2;
        int     digito1, digito2, resto;
        int     digitoCPF;
        String  nDigResult;

        d1 = d2 = 0;
        digito1 = digito2 = resto = 0;

        for (int nCount = 1; nCount < strCpf.length() -1; nCount++)
        {
           digitoCPF = Integer.valueOf (strCpf.substring(nCount -1, nCount)).intValue();

           d1 = d1 + ( 11 - nCount ) * digitoCPF;

           d2 = d2 + ( 12 - nCount ) * digitoCPF;
        };

        resto = (d1 % 11);

        if (resto < 2)
           digito1 = 0;
        else
           digito1 = 11 - resto;

        d2 += 2 * digito1;

        resto = (d2 % 11);

        if (resto < 2)
           digito2 = 0;
        else
           digito2 = 11 - resto;

        String nDigVerific = strCpf.substring (strCpf.length()-2, strCpf.length());

        nDigResult = String.valueOf(digito1) + String.valueOf(digito2);

        return nDigVerific.equals(nDigResult);
     }
    
    public static boolean validateCEP(String cep){
      
      boolean isValid = false;  
        
      if (cep.length() == 8)
      {
         cep = cep.substring(0, 5) + "-" + cep.substring(5, 8);
         //txt.Text = cep;
      }
      
      Pattern pattern = Pattern.compile("[0-9]{5}-[0-9]{3}");
      
      Matcher m = pattern.matcher(cep);
      
      while(m.find()){
          if(m.group().equals(cep)){
              isValid=true;
          }
      }
      
       return isValid;
    }
}
