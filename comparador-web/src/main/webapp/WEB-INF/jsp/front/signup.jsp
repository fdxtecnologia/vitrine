<%-- 
    Document   : signup
    Created on : 13/06/2013, 11:59:34
    Author     : guilherme
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/public/header.jsp"%>
<script language='javascript' type='text/javascript'>
 function check(input){
   if (input.value != document.getElementById('passwordInput').value) {
    input.setCustomValidity('<fmt:message key="label.signup.err.confirmpass"/>');
   } else {
    input.setCustomValidity('');
   }
  }
  $(document).ready(function() {
     new dgCidadesEstados(
       document.getElementById('comboStates'),
       document.getElementById('comboCities'),
       true
     );
  });
</script>
<title><fmt:message key="title.site.signup"/></title>
<div class="container">
<c:if test="${mensagem != null}">
   <h2 class="message">${mensagem}</h2>
</c:if>
<form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/account/signup/save" />" class="form-horizontal">
    <h2><fmt:message key="signup.title"/></h2><br>
    <input type="hidden" name="customer.id" value="${customer.id}" />
    <input type="hidden" name="customer.user.id" value="${customer.user.id}" />
    <input type="hidden" name="customer.user.enable" value="${customer.user.enable}" />
    <input type="hidden" name="customer.user.enable" value="${customer.user.userRole}" />
    <input type="hidden" name="customer.user.enable" value="${customer.user.lastAccess}" />
    <div class="control-group">
        <label for="label.customer.name" class="control-label"><fmt:message key="label.customer.name" /></label>
        <div class="controls">
            <input type="text" name="customer.firstName" value="${customer.firstName}" required="required" placeholder="<fmt:message key="label.customer.name" />"/><br>
        </div>
    </div>
    <div class="control-group">
        <label for="label.customer.lastname" class="control-label"><fmt:message key="label.customer.lastname" /></label>
        <div class="controls">
            <input type="text" name="customer.lastName" value="${customer.lastName}" required="required" placeholder="<fmt:message key="label.customer.lastname" />"/><br>
        </div>
    </div>
    <div class="control-group">
        <label for="label.customer.cpf" class="control-label"><fmt:message key="label.customer.cpf" /></label>
        <div class="controls">
            <input type="text" name="customer.cpf" value="${customer.cpf}" required="required" placeholder="<fmt:message key="label.customer.cpf"/>" maxlength="14" pattern="\d*"/><br>
        </div>
    </div>
    <div class="control-group">
        <label for="label.user.name" class="control-label"><fmt:message key="label.user.name" /></label>
        <div class="controls">
            <input type="text" name="customer.user.name" value="${customer.user.name}" required="required" placeholder="<fmt:message key="label.customer.user.name" />"/><br>
        </div>
    </div>
    <div class="control-group">
        <label for="label.signup.password" class="control-label"><fmt:message key="label.signup.password" /></label>
        <div class="controls">
            <input type="password" id="passwordInput" name="customer.user.password" required="required" placeholder="<fmt:message key="label.signup.password" />"/></br>
        </div>
    </div>
    <div class="control-group">
        <label for="label.signup.confirmpass" class="control-label"><fmt:message key="label.signup.confirmpass"/></label>
        <div class="controls">
            <input type="password" id="passwordConfInput" name="confirm.password" oninput="check(this)" required="required" placeholder="<fmt:message key="label.signup.confirmpass"/>"/><br/>
        </div>
    </div>
    <div class="control-group">
        <lab><label for="label.user.email" class="control-label"><fmt:message key="label.user.email" /></label>
        <div class="controls">
            <input type="email" name="customer.user.email" value="${customer.user.email}" required="required" placeholder="<fmt:message key="label.user.email" />"/><br /> 
        </div>
    </div>
    <div class="control-group">
        <label for="label.user.state" class="control-label"><fmt:message key="label.user.state" /></label>
        <div class="controls">
                 <select class="span3" id="comboStates" name="customer.addresses.stateCity"></select><br>
        </div>
    </div>
    <div class="control-group">
        <label for="label.user.city" class="control-label"><fmt:message key="label.user.city" /></label>
        <div class="controls">
                <select class="span3" id="comboCities" name="customer.addresses.city"></select><br>
        </div> 
    </div>     
    <div class="control-group">
        <label for="label.user.address" class="control-label"><fmt:message key="label.user.address" /></label>
        <div class="controls">
            <input class="span3" type="text" name="customer.addresses.street" value="${customer.adresses.street}" required="required" placeholder="<fmt:message key="label.signup.address.street"/>">
        </div><br>
        <div class="controls controls-row">
            <input class="span2" type="text" name="customer.addresses.neighborhood" value="${customer.adresses.neighborhood}" required="required" placeholder="<fmt:message key="label.signup.address.neighborhood"/>">
            <input class="span1" type="text" name="customer.addresses.complement" value="${customer.adresses.complement}" placeholder="<fmt:message key="label.signup.address.complement"/>">
        </div><br>
        <div class="controls">
            <input class="span3" type="text" required="required" name="customer.addresses.zipcode" value="${customer.adresses.zipcode}" required="required" pattern="\d*" placeholder="<fmt:message key="label.signup.address.zipcode"/>" maxlength="8">
        </div><br>
    </div>
    <div class="control-group">
        <div class="controls">
            <button type="submit" class ="btn btn-large btn-primary"><fmt:message key="label.customer.save"/></button>
        </div>
    </div>    
</form>
</div>
<script type="text/javascript" src="http://cidades-estados-js.googlecode.com/files/cidades-estados-v0.2.js"></script>
<%@include file="../template/public/footer.jsp"%>
