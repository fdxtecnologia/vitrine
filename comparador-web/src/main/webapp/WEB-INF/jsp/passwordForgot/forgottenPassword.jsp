<%-- 
    Document   : forgottenPassword
    Created on : 14/06/2013, 12:32:52
    Author     : guilherme
--%>

<%@include file="../template/public/header.jsp" %>
<div class="front .login">
    <h1><fmt:message key="title.user.login" /></h1>
    
    <c:if test="${mensagem != null}">
        <span class="message">${mensagem}</span>
    </c:if>
        
    <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/account/password/sendNewPassword" />" class="form-front-forgotten-password">
         <label for="label.front.login.email"><fmt:message key="label.front.login.email" /></label> <input type="text" name="userEmail" required="required"/><br />
         <input type="submit" value="<fmt:message key="label.front.send.email"/> " />
    </form>
</div>
<%@include file="../template/public/footer.jsp"%>