<%-- 
    Document   : formCustomer
    Created on : 07/06/2013, 15:44:40
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="admin/customer/save" />" class="form-customer">
    <input type="hidden" name="customer.id" value="${customer.id}" />
    <input type="hidden" name="customer.user.id" value="${customer.user.id}" />
    <input type="hidden" name="customer.user.enable" value="${customer.user.enable}" />
    <input type="hidden" name="customer.user.role" value="${customer.user.roleUser}" />
    <input type="hidden" name="customer.user.lastacess" value="${customer.user.lastAccess}" />
    <label for="label.customer.name"><fmt:message key="label.customer.name" /></label> <input type="text" name="customer.firstName" value="${customer.firstName}" required="required"/><br />
    <label for="label.customer.lastname"><fmt:message key="label.customer.lastname" /></label> <input type="text" name="customer.lastName" value="${customer.lastName}" required="required" /><br />
    <label for="label.user.name"><fmt:message key="label.user.name" /></label> <input type="text" name="customer.user.name" value="${customer.user.name}" required="required" /><br />
    <label for="label.user.password"><fmt:message key="label.user.password" /></label> <input type="password" name="customer.user.password" value="${customer.user.password}" required="required"/></br/>
    <label for="label.user.email"><fmt:message key="label.user.email" /></label> <input type="email" name="customer.user.email" value="${customer.user.email}" required="required"/><br />
    <input type="submit" value="<fmt:message key="label.customer.save"/>"/>
</form>
