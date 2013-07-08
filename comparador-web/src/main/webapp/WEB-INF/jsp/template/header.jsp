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
        <div class="header">
        <nav id="menu">
            <ul>
                <li><a href="<c:url value="/admin/market/listMarket" />"><fmt:message key="label.index.market" /></a></li>
                <li><a href="<c:url value="/admin/categories/listCategories" />"><fmt:message key="label.index.categories" /></a></li>
                <li><a href="<c:url value="/admin/customer/list" />"><fmt:message key="label.index.customer" /></a></li>
                <li><a href="<c:url value="/admin/user/listUsers" />"><fmt:message key="label.index.user" /></a></li>
                <li><a href="<c:url value="/admin/logout" />"><fmt:message key="label.index.logout" /></a></li>
            </ul>
        </nav>
            </div>
        <div id="content">
