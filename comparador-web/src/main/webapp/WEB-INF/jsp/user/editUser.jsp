<%-- 
    Document   : editUser
    Created on : 04/06/2013, 18:29:00
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp"%>
<h1><fmt:message key="title.user.edit" /></h1>
    <c:forEach var="error" items="${errors}">
    ${error.category} - ${error.message}<br />
    </c:forEach>
 <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="admin/user/update" />" class="form-edit-user">
     <input type="text" name="user.id" value="${user.id}" hidden=""/>
    <label for="label.user.name"><fmt:message key="label.user.name" /></label> <input type="text" name="user.name" value="${user.name}" /><br />
    <label for="label.user.email"><fmt:message key="label.user.email" /></label> <input type="text" name="user.email" value="${user.email}"/><br />
    <label for="label.user.password"><fmt:message key="label.user.password" /></label> <input type="password" name="user.password" value="${user.password}" /><br />
    <label for="label.user.role"><fmt:message key="label.user.role" /></label> <select name="user.userRole">
        <c:forEach items="${listRoles}" var="role">
            <c:if test="${user.userRole == role}">
                <option value="${role}" selected="">${role}</option>
            </c:if>
            <c:if test="${user.userRole != role}">
                <option value="${role}">${role}</option>
            </c:if>
        </c:forEach>
    </select><br />
    <input type="submit" value="<fmt:message key="label.user.save"/> " /><br/>
</form>
<%@include file="../template/footer.jsp" %>
