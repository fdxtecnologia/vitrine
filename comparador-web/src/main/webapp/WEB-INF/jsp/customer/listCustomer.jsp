<%-- 
    Document   : listCustomer
    Created on : 07/06/2013, 12:31:41
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>

<c:if test="${mensagem != null}">
    <span class="message">${mensagem}</span>
</c:if>
 
 <h1><fmt:message key="title.customer.list" /></h1>
<table>
    <tr>
        <th><fmt:message key="label.customer.id"/></th>
        <th><fmt:message key="label.customer.name" /></th>
        <th><fmt:message key="label.customer.lastname"/></th>
        <th><fmt:message key="label.user.name" /></th>
        <th><fmt:message key="label.user.email" /></th>
        <th><fmt:message key="label.user.enable"/></th>
    </tr>
    <c:forEach items="${customers}" var="customers">
        <tr>
            <td>${customers.id}</td>
            <td>${customers.firstName}</td>
            <td>${customers.lastName}</td>
            <td>${customers.user.name}</td>
            <td>${customers.user.email}</td>
            <td>${customers.user.enable}</td>
            <td><a href="<c:url value="/admin/customer/edit/${customers.id}" />"><fmt:message key="label.customer.edit" /></a></td>
            <td><a href="<c:url value="/admin/customer/remove/${customers.id}" />"><fmt:message key="label.customer.delete" /></a></td> 
        </tr>
    </c:forEach>
</table><br/>
<a href="<c:url value="/admin/customer/add" />"><fmt:message key="label.customer.add" /></a>
 
<%@include file="../template/footer.jsp" %>
