$(document).ready(function() {
    //Action Links (edit, create) and form buttons (submit)
    $("a.button, input[type=submit], button").button();
    //Inputs

    //Dialog de Mensagem
    $("#message-dialog").dialog({
        autoOpen: false,
        resizeable: false,
        movable: false,
        closeable: false,
        buttons: {
            "OK": function() {
                $("#message-dialog").dialog("close");
            }
        }
    });
});

function showMessageDialog(msg) {
    $("span#msg").html(msg);
    $("#message-dialog").dialog("open");
}

function checkCep(cep) {
    $.ajax({
        url: 'http://correiosapi.apphb.com/cep/'+cep,
        dataType: 'jsonp',
        crossDomain: true,
        contentType: "application/json",
        statusCode: {
            200: function(data) {
                console.log(data);
            } // Ok
            , 400: function(msg) {
                console.log(msg);
            } // Bad Request
            , 404: function(msg) {
                console.log("CEP não encontrado!!");
            } // Not Found
        }
    });
}