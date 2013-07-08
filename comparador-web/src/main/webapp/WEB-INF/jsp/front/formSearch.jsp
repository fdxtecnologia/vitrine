<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form action="<c:url value="/search" />" method="POST" class="form-search">
    <label for="query"><h3><fmt:message key="label.search" /></h3></label>  <input type="text" name="query" class="input-xlarge search-query" /><input type="submit" class="btn btn-large btn-primary" />
</form>
