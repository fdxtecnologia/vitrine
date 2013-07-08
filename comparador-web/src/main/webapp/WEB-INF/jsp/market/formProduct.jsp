<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="error" items="${errors}">
    ${error.category} - ${error.message}<br />
</c:forEach>
<fieldset>
    <input type="hidden" name="product.id" value="${product.id}" />
    <input type="hidden" name="categories" value="" id="categories" />
    <input type="hidden" name="product.market.id" value="${marketId ne null ? marketId : product.market.id}" />
    <label for="product.title"><fmt:message key="label.product.title" /></label><input type="text" name="product.title" value="${product.title}" /><br />
    <label for="product.shortDescription"><fmt:message key="label.product.shortDescription" /></label><input type="text" name="product.shortDescription" value="${product.shortDescription}" /><br />
    <label for="product.description"><fmt:message key="label.product.description" /></label><textarea name="product.description">${product.description} </textarea><br />
    <label for="categories"><fmt:message key="label.product.categories" /></label><div id="tree"></div>
    <label for="product.unit"><fmt:message key="label.product.unit" /></label><input type="text" name="product.unit" value="${product.unit}" /><br />
    <label for="product.price"><fmt:message key="label.product.price" /></label><input name="product.price" value="${product.price}"/><br />
    <label for="product.active"><fmt:message key="label.product.active" /></label><input type="checkbox" name="product.active" ${product.active ? "checked" : ""} /><br />
    <input type="submit" value="<fmt:message key="label.product.save"/> " />
</fieldset>