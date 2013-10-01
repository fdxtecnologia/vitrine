<html>
    <head>
        <title>Confirmação de Pedido</title>
    </head>
    <body>
        <div id='conteudo'>
            <h1>Confirmação de Pedido</h1>
            <p>Olá ${order.customer.firstName}! Seu pedido foi processado e enviado para a entrega</p>
            <table>
                <tr>
                    <td>
                        <div>
                            <h3>Dados do Cliente</h3>
                            <ul style="list-style: none;">
                                <li>Nome Completo: ${order.customer.firstName} ${order.customer.lastName}</li>
                            </ul>
                        </div>
                    </td>
                    <td>
                        <div>
                            <h3>Dados da Entrega</h3>
                            <ul style="list-style: none;">
                                <li></li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>