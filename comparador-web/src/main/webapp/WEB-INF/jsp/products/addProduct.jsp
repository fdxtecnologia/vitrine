<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>
<h1><fmt:message key="title.product.add" /></h1>
<c:forEach var="error" items="${errors}">
    ${error.category} - ${error.message}<br />
</c:forEach>
<form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/products/save" />" class="form-product">
    <fieldset>
        <div class="form_container">
            <label for="product.title"><fmt:message key="label.product.title" /></label><input type="text" name="product.title" /><br />
        </div>
        <label for="product.shortDescription"><fmt:message key="label.product.shortDescription" /></label><input type="text" name="product.shortDescription" /><br />
        <label for="product.description"><fmt:message key="label.product.description" /></label><textarea name="product.description"></textarea><br />
        <label for="product.unit"><fmt:message key="label.product.unit" /></label><input type="text" name="product.unit" /><br />
        <label for="product.market.id">Market:</label>
        <select name="product.market.id">
            <c:forEach items="${markets}" var="market">
                <option value="${market.id}">${market.name}</option>
            </c:forEach>
        </select><br />
        <input type="submit" value="<fmt:message key="label.product.save"/> " />
    </fieldset>
</form>
<%@include file="../template/footer.jsp" %>