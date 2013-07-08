<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>
<h1><fmt:message key="title.product.add" /></h1>

<script type="text/javascript">
    var tree;
    $(document).ready(function() {
        tree = $("#tree").dynatree({
            initAjax: {
                url: "<c:url value='/categories/tree' />"
            },
            checkbox: true,
            selectMode: 2,
            onSelect: function(select, node) {
                var cats = "";
                for (var x = 0; x < node.tree.getSelectedNodes().length; x++) {
                    cats += node.tree.getSelectedNodes()[x].data.key + ",";
                }
                $("#categories").val(cats.charAt(cats.length-1) === "," ? cats.substring(0,cats.length-1) : cats);
            }
        });

    });
</script>
<form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/admin/market/saveProduct" />" class="form-product">
    <%@include file="formProduct.jsp" %>
</form>
<%@include file="../template/footer.jsp" %>