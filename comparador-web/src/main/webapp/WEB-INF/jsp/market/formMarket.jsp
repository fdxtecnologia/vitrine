<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form method="post" enctype="application/x-www-form-urlencoded" action="<c:url value="/admin/market/saveMarket" />">
      <input type="hidden" name="market.id" value="${market.id}" />
    <label for="label.market.name"><fmt:message key="label.market.name" /></label> <input type="text" name="market.name" value="${market.name}" /><br />
    <label for="label.market.address"><fmt:message key="label.market.address" /></label> <input type="text" name="market.address" value="${market.address}" /><br />
    <label for="map">Área de Entrega</label>
    <div id="map_canvas"></div>
    
    <input type="submit" value="<fmt:message key="label.market.save"/> " />
</form>
