<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/public/header.jsp" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(".input_spin").spinner({
            min: 0,
            default: 1
        });
    });
</script>
<div class="container">
<form action="<c:url value="/cart/update" />" method="POST">
<h1><fmt:message key="title.cart.list" /></h1>
<table>
    <tr>
        <th>Market</th>
        <th>Product</th>
        <th>Quantity</th>
    </tr>
    <c:forEach items="${products}" var="product">
        <tr>
            <td>${product.key.market.name} </td>
            <td>${product.key.title}</td>
            <td><input type="text" name="qty_${product.key.id}" class="input_spin" value="${product.value}"/></td>
        </tr>
    </c:forEach> 
</table>
<input type="submit" class="button" value="<fmt:message key="label.cart.update" />" />
</form>
<form action="<c:url value="/cart/save" />" method="POST">
    <input type="submit" class="button" value="<fmt:message key='label.cart.save'/>">
</form>
</div>
<%@include file="../template/public/footer.jsp" %>
