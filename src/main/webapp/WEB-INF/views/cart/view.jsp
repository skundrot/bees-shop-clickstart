<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Shopping Cart</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/favicon.png">

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
    <link href="//code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css"/>

    <script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="//code.jquery.com/ui/1.10.1/jquery-ui.js" type="text/javascript"></script>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("input#searchProduct").autocomplete({
                minLength: 2,
                source: "${pageContext.request.contextPath}/product/suggest"
            });
        });
    </script>
</head>
<body>

<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <div class="span9">
                <a class="brand" style="padding: 0; padding-top: 10px; padding-right: 5px"
                   href="${pageContext.request.contextPath}/"> <img alt='cloudbees logo' height='28'
                                                                    src='${pageContext.request.contextPath}/img/logo.png'/>
                    Bees Shop
                </a>
                <ul class="nav">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/product/">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/configuration/"><i class="icon-cog"></i> Configuration</a></li>
                </ul>
                <form class="navbar-search pull-left" action="${pageContext.request.contextPath}/product/">
                    <input id="searchProduct" name="name" type="text" class="search-query input-medium"
                           placeholder="Search by name">
                </form>
            </div>
            <div class="span3 pull-right">
                <p class="nav">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/cart/" title="Shopping Cart">
                        <i class="icon-shopping-cart"></i>
                        ${shoppingCart.itemsCount} items
                        ${shoppingCart.prettyPrice}
                    </a>
                </p>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="page-header">
        <h1>Shopping Cart</h1>
    </div>

    <div class="row">
        <div class="span10">
            <form:form id="form" action="${pageContext.request.contextPath}/cart/buy" method="post">

                <div class="control-group">
                    <table>
                        <thead>
                        <tr>
                            <th class="span1">&nbsp;</th>
                            <th class="span7">Item</th>
                            <th class="span1">Unit Price</th>
                            <th class="span1">Quantity</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${shoppingCart.items}" var="item" varStatus="status">
                            <c:set var="product" value="${item.product}"/>

                            <tr>
                                <td>
                                    &nbsp;
                                    <c:if test="${not empty product.photoUrl}">
                                        <img src="${product.photoUrl}" width="50"/>
                                    </c:if>
                                </td>
                                <td>
                                    <strong>
                                        <a href="${pageContext.request.contextPath}/product/${product.id}">${product.name}</a>
                                    </strong>
                                    <br/>
                                    <blockquote>${product.descriptionAsHtml}</blockquote>
                                </td>
                                <td>${product.prettyPrice}</td>
                                <td>
                                    <div class="controls"><input id="quantity-${status.count}"
                                                                 readonly="true"
                                                                 name="quantity-${status.count}"
                                                                 class="span1" type="text"
                                                                 value="${item.quantity}"/></div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td><strong>Price</strong></td>
                            <td>${shoppingCart.prettyPrice}</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                <button type="submit" class="btn js-btn btn-primary">
                                    <i class="icon-shopping-cart"></i> Buy!
                                </button>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </form:form>
        </div>
    </div>

</div>
</body>
</html>
