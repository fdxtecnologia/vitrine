<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>

<c:if test="${mensagem != null}">
    <span class="message">${mensagem}</span>
</c:if>

<h1><fmt:message key="title.market.list" /></h1>
<table>
    <tr>
        <th><fmt:message key="label.market.name" /></th>
        <th><fmt:message key="label.market.address" /></th>
        <th><fmt:message key="label.market.productList" /></th>
        <th><fmt:message key="label.market.edit" /></th>
    </tr>
    <c:forEach items="${markets}" var="market">
        <tr>
            <td>${market.name}</td>
            <td>${market.address} </td>
            <td><a class="button" href="<c:url value="/admin/market/listProducts/${market.id}" />"><fmt:message key="label.market.productList" /></a> </td>
            <td><a class="button" href="<c:url value="/admin/market/editMarket/${market.id}" />"><fmt:message key="label.edit" /></a> </td>
        </tr>
    </c:forEach>
</table>
    <a href="<c:url value="/admin/market/addMarket" />">Cadastrar Supermercado</a>
<%@include file="../template/footer.jsp" %>