<%-- 
    Document   : editpass
    Created on : 17/06/2013, 11:52:38
    Author     : guilherme
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../template/public/header.jsp" %>
<script language='javascript' type='text/javascript'>
   function checkConfirm(input){
       if (document.getElementById('newPassword').value != input.value) {
           input.setCustomValidity('<fmt:message key="label.front.editpass.password.not.match"/>');
       } else {
           input.setCustomValidity('');
                   }
               }
</script>
<div class="container">
    <h1><fmt:message key="title.user.edit.pass" /></h1>
    
    <c:if test="${mensagem != null}">
        <span class="message">${mensagem}</span>
    </c:if>
        
    <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/account/updatePassword" />" class="form-front-edit-pass">
        <div class="control-group">
                <label class="control-label" for="label.front.editpass.oldpass"><fmt:message key="label.front.editpass.oldpass" /></label>
            <div class="controls">
                <input id="passwordInput" type="password" name="oldpassword" required="required"/><br />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="label.front.editpass.newpass"><fmt:message key="label.front.editpass.newpass" /></label>
            <div class="controls">
                <input id="newPassword" type="password" name="newpass" required="required" oninput="check()"/><br />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="label.front.editpass.confirmnewpass"><fmt:message key="label.front.editpass.confirmnewpass" /></label>
            <div class="controls">
                <input type="password" name="confirmnewpass" required="required" oninput="checkConfirm(this)"/><br />
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
              <input class="btn btn-primary" type="submit" value="<fmt:message key="label.front.editpass"/> " />  
            </div>
        </div>
    </form>    
</div>
<%@include file="../template/public/footer.jsp"%>
