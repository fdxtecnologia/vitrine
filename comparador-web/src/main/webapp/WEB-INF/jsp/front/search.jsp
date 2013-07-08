<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/public/header.jsp" %>
<script type="text/javascript">

    var addToCart = function(dropObject) {
        var cart = $.cookie("cart");
        if (cart === null) {
            cart = {"id": null, "products": []};
        } else {
            cart = JSON.parse(cart);
        }
        var id = parseInt(jQuery(dropObject.draggable).data("productId"));
        var found = false;
        var unitPrice;
        for (x = 0; x < cart.products.length; x++) {
            if (cart.products[x].idProduct === id) {
                found = true;
                cart.products[x].quantity++;
                cart.products[x].price;
                cart.products[x].totalPrice = cart.products[x].price * cart.products[x].quantity;
                break;
            }
        }
        if (!found) {
            var productTitle = $(".product_" + id + "_title").html();
            var price = $(".product_" + id + "_price").html();
            var totalPrice = $(".product_"+id+"_price").html();
            var product = {"idProduct": id, "title": productTitle, "quantity": 1, "price": parseFloat(price), "totalPrice": parseFloat(totalPrice) };
            cart.products.push(product);
        }
        $("#search-results #cart:visible").fadeOut(200);
        $("#msg_add").show(100, function() {
            setTimeout(function() {
                $("#msg_add").fadeOut(500);
            }, 1000);
        });
        $.cookie("cart", JSON.stringify(cart), {path: "/"});
        reloadCart();

    };

    var removeFromCart = function(id) {
        var cart = JSON.parse($.cookie("cart"));
        for (x = 0; x < cart.products.length; x++) {
            if (cart.products[x].idProduct === id) {
                if (cart.products[x].quantity === 1) {
                    cart.products.splice(x, 1);
                } else {
                    cart.products[x].quantity--;
                    cart.products[x].totalPrice = cart.products[x].price * cart.products[x].quantity;
                }
                break;
            }
        }
        $.cookie("cart", JSON.stringify(cart), {path: "/"});
        reloadCart();
    };

    //Loading cart from cookie
    var reloadCart = function() {
        var cart = $.cookie("cart");
        $("#cart_products table").empty();
        if (cart == null) {
        } else {
            cart = JSON.parse(cart);
            for (x = 0; x < cart.products.length; x++) {
                var product = cart.products[x];
                var row = $("<tr>");
                var colTitle = $("<td>").text(product.title + "(" + product.quantity + ")")
                var colPrice = $("<td>").text(product.totalPrice);
                var linkRemove = $("<a href='#' data-product-id='"+product.idProduct+"'>Remover</a>").click(function() {
                    removeFromCart($(this).data("productId"));
                });
                var colRemove = $("<td>").append(linkRemove);
                colTitle.appendTo(row);
                colPrice.appendTo(row);
                colRemove.appendTo(row);
                row.appendTo($("#cart_products table"));
            }
            ;
        }
    };


    $(document).ready(function() {
        $(".draggable > img").draggable({
            revert: true,
            start: function() {
                $("#search-results #cart").fadeIn(200);
            }, stop: function() {
                $("#search-results #cart:visible").fadeOut(200);
            }
        });

        $(".droppable").droppable({
            activeClass: "cart_active",
            accept: ".draggable > img",
            drop: function(event, ui) {
                addToCart(ui);
            }
        });
        reloadCart();
    });
</script>
<div class="container">
    <h1><fmt:message key="label.search.results" /></h1>
    <h3 id="msg_add" style="display: none;">Produto adicionado ao Carrinho com Sucesso</h3>
    <div id="search-results">
        <div id="add_cart" class="droppable">
            <h3>Seu Carrinho</h3>
            <div id="cart_products">
                <table>

                </table>
            </div>
        </div>
        <div id="filters">
            <div id="categories">
                <h2>Categories</h2>
                <ul>
                    <li><a href="<c:url value="/search?query=${query}&page=1&market=${market}"/>"><fmt:message key="label.search.all" /></a></li>
                        <c:forEach items="${categories}" var="cat">
                        <li><a href="<c:url value="/search?query=${query}&page=1&market=${market}&category=${cat.key.id}&order=${order}" />">${cat.key.name} (${cat.value})</a></li>
                        </c:forEach>
                </ul>
            </div>
            <div id="markets">
                <h2>Markets</h2>
                <ul>
                    <li><a href="<c:url value="/search?query=${query}&page=1&market=${market}"/>"><fmt:message key="label.search.all" /></a></li>
                        <c:forEach items="${markets}" var="m">
                        <li><a href="<c:url value="/search?query=${query}&page=1&market=${m.id}&category=${category}" />">${m.name}</a></li>
                        </c:forEach>
                </ul>
            </div>
        </div>
        <div id="products">
            <div id="order">
                <label for="order"><fmt:message key="label.product.order" /></label>
                <select onchange="window.location = '<c:url value='/search?query=${query}&category=${category}&page=1&market=${market}&order=' />' + this.value;">
                    <option value=""><fmt:message key="label.select" /></option>
                    <c:forEach items="${sortValues}" var="sortValue">
                        <option value="${sortValue}"><fmt:message key="${sortValue.label}" /></option>
                    </c:forEach>
                </select>
            </div>
            <div id="list">
                <div class="list_line">
                    <c:forEach items="${products}" var="product" varStatus="rkv">
                        <div class="list_product draggable">
                            <img src="<c:url value="/images/placeholder.png"/>" alt="${product.title}"data-product-id="${product.id}" style="width: 150px"/> <br />
                            <span class="product_${product.id}_title">${product.title}</span><br />
                            <span class="product_${product.id}_price">${product.formattedPrice}</span><br />
                        </div>
                        <c:if test="${rkv.count % 4 == 0}">
                        </div>
                        <div class="list_line">
                        </c:if> 
                    </c:forEach>
                </div>
            </div>
            <div id="paginator">

                <%--For displaying Page numbers.
                The when condition does not display a link for the current page--%>
                <table border="1" cellpadding="5" cellspacing="5">
                    <tr>
                        <%--For displaying Previous link except for the 1st page --%>
                        <c:if test="${page != 1}">
                            <td><a href="<c:url value="/search?query=${query}&page=${page-1}&market=${market}&category=${cat.key.id}&order=${order}" />"><fmt:message key="label.previous" /></a></td>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${page eq i}">
                                    <td>${i}</td>
                                </c:when>
                                <c:otherwise>
                                    <td><a href="<c:url value="/search?query=${query}&page=${i}&market=${market}&category=${cat.key.id}&order=${order}" />">${i}</a></td>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <%--For displaying Next link --%>
                            <c:if test="${page lt totalPages}">
                            <td><a href="<c:url value="/search?query=${query}&page=${page + 1}&market=${market}&category=${cat.key.id}&order=${order}" />"><fmt:message key="label.next" /></a></td>
                            </c:if>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="../template/public/footer.jsp" %>
