<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

String id = request.getParameter("id");
String quantity = request.getParameter("quantity");

ArrayList<Object> product = (ArrayList<Object>) productList.get(id);

// Get product information

if (productList.containsKey(id))

	product.set(3, Integer.parseInt(quantity));


session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />