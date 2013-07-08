<%-- 
    Document   : login
    Created on : 12/06/2013, 10:26:55
    Author     : guilherme
--%>

<%@include file="../template/public/header.jsp" %>
<div class="container">   
    <c:if test="${mensagem != null}">
        <span class="message">${mensagem}</span>
    </c:if>
        
    <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/account/authenticate" />" class="form-login">
        <h2><fmt:message key="title.user.login" /></h2>
        <div class="control-group">
            <div class="controls">
                <input type="text" name="user" required="required" class="input_medium" placeholder="<fmt:message key="label.front.login.name" />"/><br>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <input type="password" name="password" required="required" class="input_medium" placeholder="<fmt:message key="label.front.login.password"/>"/><br>
            </div>
        </div>
        <div class="control-group">
        <a href="<c:url value="/account/forgottenpass"/>">  <fmt:message key="label.front.login.forget"/>  </a><br><br>
            <div class="controls">
                <button type="submit" class="btn btn-large btn-primary" ><fmt:message key="label.user.login"/></button>
                <a href="<c:url value="/account/signup"/>" class="btn btn-large">  <fmt:message key="label.front.login.signup"/>  </a>
            </div>
        </div>
    </form>
</div>
<%@include file="../template/public/footer.jsp"%>
