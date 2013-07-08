<%-- 
    Document   : newPassword
    Created on : 14/06/2013, 14:30:16
    Author     : guilherme
--%>

<%@include file="../template/public/header.jsp" %>
<div class="front .login">
    <h1><fmt:message key="title.user.login" /></h1>
    
    <c:if test="${mensagem != null}">
        <span class="message">${mensagem}</span>
    </c:if>
        
    <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/account/password/reset" />" class="form-front-reset-password">
         <label for="label.front.resetpass.email"><fmt:message key="label.front.resetpass.email" /></label> <input type="text" name="email" required="required"/><br />
         <label for="label.front.resetpass.newpassword"><fmt:message key="label.front.resetpass.newpassword" /></label> <input type="password" name="password" id="passwordInput" required="required"/><br />
         <label for="label.front.resetpass.comfirmnewpassword"><fmt:message key="label.front.resetpass.comfirmnewpassword" /></label> <input type="password" name="comfirmpass" oninput="check(this)" required="required"/><br />
         <script language='javascript' type='text/javascript'>
            function check(input){
                if (input.value != document.getElementById('passwordInput').value) {
                    input.setCustomValidity('<fmt:message key="label.signup.err.confirmpass"/>');
                } else {
                    input.setCustomValidity('');
                }
            }
        </script>
         <input type="submit" value="<fmt:message key="label.front.send.email"/> " />
    </form>
</div>
<%@include file="../template/public/footer.jsp"%>
