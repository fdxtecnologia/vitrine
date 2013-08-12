<%-- 
    Document   : teste
    Created on : 05/08/2013, 14:03:22
    Author     : Andre
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://localhost:8080/comparador-web/js/jquery.js"></script>
        <script type="text/javascript">
            function teste() {
                var params = {"customer": {"firstName": "Andre", "lastName": "Luis"}};
                console.log(JSON.stringify(params));
                $.ajax({
                    url: "http://localhost:8080/vitrine-services/customers/loginFB",
                    data: JSON.stringify(params),
                    type: "POST",
                    contentType: 'application/json',
                    success: function() {
                        console.log("sucesso");
                    }
                });
            }

        </script>
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Teste</h1>
    </body>
</html>
