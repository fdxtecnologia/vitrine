<%-- 
    Document   : listUsers
    Created on : 04/06/2013, 16:29:51
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>

<c:if test="${mensagem != null}">
    <span class="message">${mensagem}</span>
</c:if>
 
 <h1><fmt:message key="title.user.list" /></h1>
<table>
    <tr>
        <th><fmt:message key="label.user.id"/></th>
        <th><fmt:message key="label.user.name" /></th>
        <th><fmt:message key="label.user.email"/></th>
        <th><fmt:message key="label.user.role" /></th>
    </tr>
    <c:forEach items="${users}" var="users">
        <tr>
            <td>${users.id}</td>
            <td>${users.name}</td>
            <td>${users.email}</td>
            <td>${users.userRole}</td>
            <td><a href="<c:url value="/admin/user/editUser/${users.id}" />"><fmt:message key="label.user.edit" /></a></td>
            <td><a href="<c:url value="/admin/user/removeUser/${users.id}" />"><fmt:message key="label.user.delete" /></a></td> 
        </tr>
    </c:forEach>
</table><br/>
<a href="<c:url value="/admin/user/addUser" />"><fmt:message key="label.user.add" /></a>
 
<%@include file="../template/footer.jsp" %>
