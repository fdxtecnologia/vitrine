<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>

<c:if test="${mensagem != null}">
    <span class="message">${mensagem}</span>
</c:if>

<h1><fmt:message key="title.product.list" /></h1>
<a href="<c:url value="/product/add" />"><fmt:message key="label.product.add" /> </a>
<%@include file="../template/footer.jsp" %>