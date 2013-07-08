<%-- 
    Document   : addUser
    Created on : 04/06/2013, 15:22:11
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>
<h1><fmt:message key="title.user.add" /></h1>
    <c:forEach var="error" items="${errors}">
    ${error.category} - ${error.message}<br />
    </c:forEach>
    <c:forEach var="mensagem" items="${mensagem}">
    ${mesagem}<br />
    </c:forEach>
 <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="admin/user/save" />" class="form-user">
    <label for="label.user.name"><fmt:message key="label.user.name" /></label> <input type="text" name="user.name" /><br />
    <label for="label.user.email"><fmt:message key="label.user.email" /></label> <input type="text" name="user.email" /><br />
    <label for="label.user.password"><fmt:message key="label.user.password" /></label> <input type="password" name="user.password" /><br />
    <label for="label.user.role"><fmt:message key="label.user.role" /></label> <select name="user.userRole">
        <c:forEach items="${listRoles}" var="role">
            <option value="${role}">${role}</option>
        </c:forEach>
    </select><br />
    <input type="submit" value="<fmt:message key="label.user.save"/> " />
</form>
<%@include file="../template/footer.jsp" %>
