<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>

<c:if test="${mensagem != null}">
    <span class="message">${mensagem}</span>
</c:if>
<h1>${market.name} </h1>
<h1><fmt:message key="title.product.list" /></h1>

<table>
    <tr>
    <th><fmt:message key="title.product.title" /></th>
    <th><fmt:message key="title.product.shortDescription" /></th>
    <th><fmt:message key="title.product.price" /></th>
    <th><fmt:message key="title.product.unit" /></th>
    <th><fmt:message key="label.edit" /></th>
</tr>
<c:forEach items="${products}" var="product">
    <tr>
        <td>${product.title}</td>
        <td>${product.shortDescription}</td>
        <td>${product.formattedPrice}</td>
        <td>${product.unit}</td>
        <td><a class="button" href="../editProduct/${product.id}"><fmt:message key="label.product.edit" /></a></td>
    </tr>
</c:forEach>
</table>
<hr />
<form action="<c:url value="/admin/market/uploadProducts" />" method="POST" enctype="multipart/form-data" >
    Arquivo: <input type="file" name="arquivo" required="required" />
    <input type="hidden" name="m.id" value="${market.id}" />
    <input type="submit" value="Enviar" />
</form>
<hr />
<a href="<c:url value="/admin/market/addProduct/${market.id}" />"><fmt:message key="label.product.add" /> </a><br />
<a href="<c:url value="/admin/market/listMarket" />"><fmt:message key="label.back" /> </a>
<%@include file="../template/footer.jsp" %>