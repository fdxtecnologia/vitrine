<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../template/header.jsp" %>
<script type="text/javascript">
    var nodeId, tree;
    $(document).ready(function() {
        tree = $("#tree").dynatree({
            initAjax: {
                url: "<c:url value='/categories/tree' />",
            },
            checkbox: false,
            persist: true,
            selectMode: 1,
            onActivate: function(node) {
                nodeId = node.data.key;
            },
        });

    $("#dialog-category").dialog({
            title: "<fmt:message key='label.category.modal' />",
            autoOpen: false,
            height: 200,
            width: 350,
            resizeable: "false",
            movable: "false",
            modal: true,
            buttons: {
                "<fmt:message key='label.category.save' />": function() {
                    $.ajax({
                        type: 'POST',
                        url: "<c:url value='/categories/saveCategory'/>",
                        data: $("#formCategory").serialize(),
                        success: function(data){
                            $("#dialog-category").dialog("close");
                            tree.dynatree("getTree").reload().reactivate();
                            showMessageDialog("<fmt:message key='message.category.success' />");
                        }
                    });
                }
            }
        });
    });
    
    function openDialogAddCategory() {
        if(tree.dynatree("getActiveNode") !== undefined){
            $("#category-id").val("");
            $("#category-name").val("");
            $("#category-parent").val(tree.dynatree("getActiveNode").data.key);
            $("#dialog-category").dialog("open");
        } else {
            showMessageDialog("<fmt:message key='error.category.parent' />");
        }
    }
    
    function openDialogEditCategory() {
        if(tree.dynatree("getActiveNode") !== undefined){
            $("#category-id").val(tree.dynatree("getActiveNode").data.key);
            $("#category-name").val(tree.dynatree("getActiveNode").data.title);
            $("#category-parent").val(tree.dynatree("getActiveNode").parent.data.key);
            $("#dialog-category").dialog("open");
        } else {
            showMessageDialog("<fmt:message key='error.category.parent' />");
        }
    }
</script>

<div id="tree">

</div>

<a href="#" onclick="openDialogAddCategory(); return false;" class="button"> <fmt:message key="label.category.add" /></a>
<a href="#" onclick="openDialogEditCategory(); return false;" class="button"> <fmt:message key="label.category.edit" /></a>

<div id="dialog-category">
    <form id="formCategory">
        <input type="hidden" name="category.parent.id" id="category-parent" />
        <input type="hidden" name="category.id" id="category-id" />
        <label for="category.name"><fmt:message key="label.category.name" /></label><input type="text" name="category.name" id="category-name" required="required" />
    </form>
</div>
<%@include file="../template/footer.jsp" %>