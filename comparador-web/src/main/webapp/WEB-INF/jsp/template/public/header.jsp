<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${not empty param.lingua}">
    <fmt:setLocale value="${param.lingua}" scope="session"/>
</c:if>
<fmt:setBundle basename="messages_pt" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="<c:url value='/js/jquery.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/js/jquery.cookie.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/js/jquery.dynatree.js'/>"></script>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/pepper-grinder/jquery-ui.css" />" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/skin/ui.dynatree.css" />" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/front-style.css" />" />
        <link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet" media="screen">
        <title>Comparador de Produtos - ${titulo} </title>
        <script>
          var loc = window.location.pathname;
          $(document).ready($('.nav').find('a').each(function() {
            $(this).toggleClass('active', $(this).attr('href') == loc);
          }));
        </script>
    </head>
    <body>
        <div class="navbar navbar-inverse navbar-fixed-top">
          <div class="navbar-inner">
           <div class="container">
            <a class="brand" href="/"><fmt:message key="site.title" /></a>
            <ul class="nav">
              <li><a href="<c:url value="/"/>">Home</a></li>
              <li><a href="<c:url value="/cart/list"/>">Cart</a></li>
              <li class="divider"></li>
            </ul>
                 <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/search" />" class="navbar-search pull-left">
                     <input type="text" name="query" class="search-query span3" placeholder="<fmt:message key="label.search"/>" />
                 </form>
                <ul class="nav pull-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <fmt:message key="label.menu.account"/>
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <c:if test="${customer == null}">
                            <form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/account/authenticate" />" class="form-login-nav">
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
                            </c:if>
                            <c:if test="${customer != null}">
                                <li><a href="<c:url value="/myarea"/>"><fmt:message key="label.title.myarea"/></a></li>
                                <li class="divider"></li>
                                <li><a href="<c:url value="/logout"/>"><fmt:message key="label.front.logout"/></a></li>
                            </c:if>
                        </ul>
                    </li>
                </ul>
                                    
          </div>
        </div>
       </div>
 <div id="content">
