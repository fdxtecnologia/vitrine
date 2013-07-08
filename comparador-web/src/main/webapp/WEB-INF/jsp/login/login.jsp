<%-- 
    Document   : login
    Created on : 05/06/2013, 15:04:08
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${not empty param.lingua}">
    <fmt:setLocale value="${param.lingua}" scope="session"/>
</c:if>
<fmt:setBundle basename="messages_pt" />
<!DOCTYPE html> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<c:url value='/js/jquery.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.cookie.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.dynatree.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/design.js'/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/style.css" />" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/pepper-grinder/jquery-ui.css" />" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/skin/ui.dynatree.css" />" />
    <title>Comparador de Produtos - ${titulo} </title>
</head>
<body>
<c:if test="${mensagem != null}">
    <span class="message">${mensagem}</span>
</c:if>
<div id="login">
    <h1><fmt:message key="title.user.login" /></h1>

     <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/admin/login/authenticate" />" class="form-login">
         <label for="label.user.name"><fmt:message key="label.user.name" /></label> <input type="text" name="user.name" required="required"/><br />
         <label for="label.user.password"><fmt:message key="label.user.password" /></label> <input type="password" name="user.password" required="required"/><br />
        <input type="submit" value="<fmt:message key="label.user.login"/> " />
    </form>
</div>
<%@include file="../template/footer.jsp"%>
