<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
// Get the current list of products

	if (session.getAttribute("authenticatedUser") != null) {

	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
	
	String id = request.getParameter("id");
	String quantity = request.getParameter("quantity");
	
	int q = 1;
	
	try {
		q = Integer.parseInt(quantity);
	} catch (NumberFormatException e){
		//out.println("error");
	}
	
	ArrayList<Object> product;
	
	// Get product information
	
	if (id == null) {
		productList.remove(null);
	}
	
	if (productList.containsKey(id)) {
		product = (ArrayList<Object>) productList.get(id);
		product.set(3, q);
	}
	
	session.setAttribute("productList", productList);
}
%>
<jsp:forward page="showcart.jsp" />