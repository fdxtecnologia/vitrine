<%-- 
    Document   : addCustomer
    Created on : 07/06/2013, 12:31:26
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>
<h1><fmt:message key="title.customer.add" /></h1>
<%--Mensagens podem retornar no include do Result:   error   ,   mensagem  --%>
    <c:forEach var="error" items="${errors}">
    ${error.category} - ${error.message}<br />
    </c:forEach>
    <c:forEach var="mensagem" items="${mensagem}">
    ${mesagem}<br />
    </c:forEach>
<%@include file="formCustomer.jsp" %>
<%@include file="../template/footer.jsp" %>
