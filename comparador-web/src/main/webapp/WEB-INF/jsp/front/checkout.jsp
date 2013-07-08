<%-- 
    Document   : checkout
    Created on : 26/06/2013, 13:57:47
    Author     : guilherme
--%>

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
  $(document).ready(function() {
     new dgCidadesEstados(
       document.getElementById('comboStates'),
       document.getElementById('comboCities'),
       true
     );
         $("#newAddress").hide();
     });

    function checkOptionsAddress(){
        console.log($("input[name=optionsRadios]:checked").attr("id"));
        if($("input[name=optionsRadios]:checked").attr("id") == "radioAddress"){
            $("#address").show();
            $("#newAddress").hide();
            $("#newAddress input").removeAttr("required"); 
        }
        if($("input[name=optionsRadios]:checked").attr("id") == "radioNewAddress"){
            $("#newAddress").show();
            $("#address").hide();
            $("#newAddress input").attr("required","required"); 
       }
    }
    
    function teste(){
        
    }
</script>

<title><fmt:message key="title.site.signup"/></title>
<div class="container">
    <div class="row">
        <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/checkout/confirm" />">
        <div class="span4">
               <h2 class=""><fmt:message key="checkout.title.firststep"/></h2>
               <input type="hidden" name="customer.id" value="${customer.id}" />
               <input type="hidden" name="customer.user.id" value="${customer.user.id}" />
               <input type="hidden" name="customer.user.enable" value="${customer.user.enable}" />
               <input type="hidden" name="customer.user.enable" value="${customer.user.userRole}" />
               <input type="hidden" name="customer.user.enable" value="${customer.user.lastAccess}" /><br>
               <div class="control-group">
                   <label for="label.customer.fullname" class="control-label"><fmt:message key="label.customer.fullname" /></label>
                   <div class ="controls controls-row">
                       <input type="text" class="span2" name="customer.firstName" value="${customer.firstName}" required="required" placeholder="<fmt:message key="label.customer.name" />"/>
                       <input type="text" class="span2" name="customer.lastName" value="${customer.lastName}" required="required" placeholder="<fmt:message key="label.customer.lastname" />"/>                
                   </div>
               </div>
               <div class="control-group">
                   <lab><label for="label.user.email" class="control-label"><fmt:message key="label.user.email" /></label>
                   <div class="controls">
                       <input type="email" name="customer.user.email" value="${customer.user.email}" class="span4" required="required" placeholder="<fmt:message key="label.user.email" />"/><br /> 
                   </div>
               </div>
               <label class="radio" id="radioAddress">
                   <input type="radio" name="optionsRadios" checked="checked" value="radioAddress" id="radioAddress" onchange="checkOptionsAddress()"/>
                    <h5>Endereço</h5>
                </label><br>
                <div id="address">
                <div class="control-group">
                    <div class="controls">
                        <select class="span4" id="comboAddresses" name="address.id">
                            <c:forEach items='${cAddresses}' var="address">
                                 <option value="${address.id}">${address.street}, ${address.neighborhood}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                </div>
               <label class="radio">
                   <input type="radio" name="optionsRadios" value="radioNewAddress" id="radioNewAddress" onchange="checkOptionsAddress()"/>
                   <h5>Novo endereço</h5>
               </label><br>
               <div id="newAddress" style="display: none;">
               <div class="control-group">
                   <label for="label.user.state" class="control-label"><fmt:message key="label.user.state" /></label>
                   <div class="controls">
                            <select class="span4" id="comboStates" name="address.stateCity"></select><br>
                   </div>
               </div>
               <div class="control-group">
                   <label for="label.user.city" class="control-label"><fmt:message key="label.user.city" /></label>
                   <div class="controls">
                       <select class="span4" id="comboCities" name="address.city"></select><br>
                   </div> 
               </div>     
               <div class="control-group">
                   <label for="label.user.address" class="control-label"><fmt:message key="label.user.address" /></label>
                   <div class="controls">
                       <input class="span4" type="text" name="address.street" required placeholder="<fmt:message key="label.signup.address.street"/>">
                   </div><br>
                   <div class="controls controls-row">
                       <input class="span3" type="text" name="address.neighborhood" required placeholder="<fmt:message key="label.signup.address.neighborhood"/>">
                       <input class="span1" type="text" name="address.complement" required placeholder="<fmt:message key="label.signup.address.complement"/>">
                   </div><br>
                   <div class="controls">
                       <input class="span4" type="text" required="required" name="address.zipcode" required placeholder="<fmt:message key="label.signup.address.zipcode"/>">
                   </div><br>
               </div>
               </div>
         </div>
        <div class="span4">
            <h2><fmt:message key="checkout.title.secondstep"/><h2>
        </div>
        <div class="span4">
            <h2><fmt:message key="checkout.title.thirdstep"/><h2>
            <h5><fmt:message key="checkout.review.order"/></h5>
            <div class="review-order" style="height:200px;  overflow: hidden; overflow-y: scroll;">
            <table class="table">
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price<th>
                </tr>
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>${product.key.title}</td>
                        <td>${product.value}</td>
                        <td class="totalPrice" onshow="teste()">${product.key.price * product.value}</td>
                    </tr>
                </c:forEach> 
            </table>
            </div><br>
            <div class="control-group">
                <div class="controls">
                    <a href="<c:url value="/cart/list"/>" class="btn btn-warning"><fmt:message key="review.order.change"/></a><br><br>
                    <button type="submit" class="btn btn-large btn-success"><fmt:message key="review.order.comfirm"/></button>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>
<script type="text/javascript" src="http://cidades-estados-js.googlecode.com/files/cidades-estados-v0.2.js"></script>
<%@include file="../template/public/footer.jsp"%>
