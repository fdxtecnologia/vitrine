/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.comparador.front.controllers;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.fdxtecnologia.comparador.dao.CustomerDAO;
import br.com.fdxtecnologia.comparador.login.Public;
import br.com.fdxtecnologia.comparador.model.Customer;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

/**
 *
 * @author guilherme
 */
@Public
@Resource
@SuppressWarnings("rawtypes")
public class PasswordForgotController {
    
    private HttpServletResponse response;
    private HttpServletRequest request;
    private final static String SALT = "sadifhasdu34hqo9ihadfsoivuhaewuihfasiuasiufhifaew";
    private Result result;
    private CustomerDAO customerDAO;
    private final static String urlToResetPassword = "http://localhost:8080/comparador-web/account/resetPassword/";
    private final static String fromEmail = "gnmfcastro@gmail.com";
    private final static String fromEmailOwnerName = "Guilherme";
    private final static String fromEmailPassword = "nyfpbenybsjqmfal";
    
    public PasswordForgotController(Result result, CustomerDAO customerDAO, HttpServletResponse response, HttpServletRequest request){
        this.result = result;
        this.customerDAO = customerDAO;
        this.response = response;
        this.request = request;
    }
    
    @Path("/account/forgottenpass")
    public void forgottenPassword(){
        
    }
    
    @Post("/account/password/sendNewPassword")
    public void sendPassword(String userEmail) throws EmailException{
        
        Customer cust = customerDAO.getCustomerByEmail(userEmail);
        if(cust==null){
            result.include("mensagem","mail.mail-not-found");
            result.redirectTo(FrontController.class).login();
        }else{
            HtmlEmail email = new HtmlEmail();  
            String token = DigestUtils.shaHex(System.nanoTime() + userEmail + SALT);
            // adiciona uma imagem ao corpo da mensagem e retorna seu id  
            //URL url = new URL("http://www.apache.org/images/asf_logo_wide.gif");  
            //String cid = email.embed(url, "Apache logo");     

            // configura a mensagem para o formato HTML  
            email.setHtmlMsg("<html><a href='<c:url value='/account/reserPassword/\"+token+\"'>'>Reset Your Password</a></html>");  

            // configure uma mensagem alternativa caso o servidor não suporte HTML  
            email.setTextMsg("Copie o endereço no seu navegador: <c:url value='/account/reserPassword/\"+token+\"'>");  

            email.setHostName("smtp.gmail.com"); // o servidor SMTP para envio do e-mail  
            email.addTo(cust.getUser().getEmail(), cust.getFirstName()); //destinatário  
            email.setFrom(fromEmail, fromEmailOwnerName); // remetente  
            email.setSubject("reset.password.comparator"); // assunto do e-mail  
            email.setMsg("<a href='"+urlToResetPassword+token+"'>Clique aqui para resetar sua senha</a>"); //conteudo do e-mail  
            email.setAuthentication(fromEmail, fromEmailPassword);  
            email.setSmtpPort(465);  
            email.setSSL(true);  
            email.setTLS(true);
            email.send();
            Cookie cookie = new Cookie("token-comparador-supermercado", token);
            cookie.setMaxAge(60*60);
            cookie.setPath("/");
            response.addCookie(cookie);
            result.redirectTo(FrontController.class).login();
        }
    }
    
    @Get("/account/resetPassword/{token}")
    public void resetPassword(String token){
        Cookie[] cookies = request.getCookies();
        for(int i=0;i<cookies.length;i++){
            String name = cookies[i].getName();
            String value = cookies[i].getValue();
            System.out.println("NOME COOKIE "+name+" VALOR DO COOKIE "+value);
            if(cookies[i].getName().equals("token-comparador-supermercado")){
                if(cookies[i].getValue().equals(token)){
                    result.redirectTo(PasswordForgotController.class).newPassword();
                }
            }
        }     
    }
    
    @Path("/account/newpass")
    public void newPassword(){
        
    }
    
    @Post("/account/password/reset")
    public void updateNewPassword(String email, String password){
        
        Customer customer = customerDAO.getCustomerByEmail(email);
        if(customer != null){
            customer.setId(customer.getId());
            customer.getUser().setPassword(password);
            customerDAO.update(customer);
            result.include("mensagem","reset.password.sucess");
        }else{
            result.include("mensagem","reset.password.invalid.email");
        }
        result.redirectTo(FrontController.class).login();
    }
    
}
