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
            var totalPrice = $(".product_" + id + "_price").html();
            var product = {"idProduct": id, "title": productTitle, "quantity": 1, "price": parseFloat(price), "totalPrice": parseFloat(totalPrice)};
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
                var linkRemove = $("<a href='#' data-product-id='" + product.idProduct + "'>Remover</a>").click(function() {
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
        $(".product > img").draggable({
            revert: true,
            start: function() {
                $("#search-results #cart").fadeIn(200);
                $(this).css("z-index", 1000);
            }, stop: function() {
                $("#search-results #cart:visible").fadeOut(200);
                $(this).css("z-index", 1);
            }
        });

        /*$(".droppable").droppable({
         activeClass: "cart_active",
         accept: ".draggable > img",
         drop: function(event, ui) {
         addToCart(ui);
         }
         });
         reloadCart();*/
    });
    
    
    
</script>
<style type="text/css">
    #content {
        margin-top: -25px;
        background: url("images/bg_shelf.png") repeat scroll 0 0 transparent;
    }

    .container {
        width: 1270px !important;
    }

    .shelf {
        width: 100%;
        height: 850px;
        background: url('images/prats.png') no-repeat;
        margin-left: 300px;
    }

    #shelf .row .product {
        width: 125px;
        padding: 0 5px;
        float: left;
    }

    #shelf .row {
        padding-top:20px;
    }

    #shelf .row:first-child {
        padding-top:60px;
    }

    #shelf .row .left {
        float:left;
        margin-left: 25px;
    }
    #shelf .row .right {
        float:right;
        margin-right: 10px;
    }

    #shelf .row .product img {
        width: 125px;
        max-height: 125px;
    }

    #shelf .row .product .price {
        background: url(images/etiqueta.png) no-repeat scroll 0 0 transparent;
        height: 30px;
        width: 70px;
        text-align:center;
        margin-left:30px;
    }
</style>
    <div class="container-fluid">
        <div class="prev_page span6">&lt;</div>
        <div id="shelf">
            
        </div>
        <div class="next_page span6" >&gt;</div>
    </div>
<%@include file="../template/public/footer.jsp" %>
