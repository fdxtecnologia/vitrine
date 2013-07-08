<%-- 
    Document   : myarea
    Created on : 12/06/2013, 10:26:17
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/public/header.jsp"%>
<div class="container">
        <script>
            function edit(){
                $('.no-edit').hide();
                $('.edit').show();
                $('#edit-submit').show();
            }
            function loadCart(cartId){
                $.ajax({
                    url: "<c:url value='/cart/load'/>",
                    type: 'POST',
                    data: { 
                      cartId: cartId
                    },
                    success: function () {
                    },
                    error: function () {                
                    }
                });
            }
        </script>
        <div id="customer-data" class="customer-data">
            <h2><fmt:message key="label.title.myarea"/></h2>
            <form form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/account/update" />" class="form-edit-customer">
                <div class="control-group">
                    <div class="controls">
                        <input type="button" class="btn btn-warning" value="<fmt:message key='label.customer.myarea.edit'/>" onclick="edit()"/><br>
                    </div>
                </div><br>
                <div class="control-group">
                    <label class="control-label" for="label.customer.name"><b><fmt:message key="label.customer.name"/></b></label>
                    <label class="no-edit">${customer.firstName}</label>
                    <div class ="controls">
                        <input type="text" style="display:none" class="edit" name="customer.firstName" value="${customer.firstName}" /><br>
                    </div>
                </div>
                <div class="control-group">
                        <label class="control-label" for="label.customer.lastname"><b><fmt:message key="label.customer.lastname"/></b></label>
                        <label class="no-edit">${customer.lastName}</label>                    
                    <div class ="controls">
                        <input type="text" style="display:none" class="edit" name="customer.lastName" value="${customer.lastName}" /><br>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="label.user.email"><b><fmt:message key="label.user.email"/></b></label>
                        <label class="no-edit">${customer.user.email}</label>
                    <div class="controls">
                        <input type="text" style="display:none" class="edit" name="customer.user.email" value="${customer.user.email}" /><br>
                    </div>
                </div>
                <div class="control-group">
                    <label class ="control-label" for="label.user.name"><b><fmt:message key="label.user.name"/></b></label>
                    <label>${customer.user.name}</label>
                </div>
                <div class="control-group">
                       <label class="control-label" for="label.user.password"><b><fmt:message key="label.user.password"/></b></label>
                       <a href="<c:url value="/myarea/editpass"/>" class="btn btn-small btn-info"><label for="label.customer.myarea.editpass"><fmt:message key="label.customer.myarea.editpass"/></label></a><br>
                </div>
                <input type="hidden" name="customer.id" value="${customer.id}" />
                <input type="hidden" name="customer.user.id" value="${customer.user.id}" />
                <input type="hidden" name="customer.user.enable" value="${customer.user.enable}" />
                <input type="hidden" name="customer.user.role" value="${customer.user.userRole}" />
                <input type="hidden" name="customer.user.lastacess" value="${customer.user.lastAccess}" />
                <div class="control-group">
                    <div class="controls">
                        <input type="submit" class="btn btn-success" style="display:none" id="edit-submit" value="<fmt:message key="label.customer.myarea.save"/>">
                    </div>
                </div>
            </form>
        </div><br>
        <div id="custome-cart-history" class="cart-list">
            <h2><fmt:message key="label.title.myarea.carts"/></h2>
            <table>
            <tr>
                <th><fmt:message key="label.customer.myarea.date" /></th>
            </tr>
            <c:forEach items="${carts}" var="cart">
            <tr>
                    <td>${cart.saveDate}</td>
                    <td><a class="button" href="<c:url value='/cart/load/${cart.id}'/>" onclick='loadCart(${cart.id});'><fmt:message key="label.customer.myarea.load.cart" /></a></td>
            </tr>
            </c:forEach>
            </table>
        </div>
 </div>
<%@include file="../template/public/footer.jsp" %>