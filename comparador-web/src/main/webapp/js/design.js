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