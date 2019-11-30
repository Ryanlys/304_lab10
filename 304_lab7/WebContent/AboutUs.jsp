<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us</title>
</head>
<body>

<h2>Mission Statement</h2>
<blockquote>
Don’t Leaf Me is a seasonal store that sells assorted preserved leaves that capture the most beautiful moment of their lives, which is the moment right after they fall of the tree and right before they touch the ground.
</blockquote>

<h2>Executive Summary</h2>
<blockquote>
With the current fall season, there are so many beautiful leaves that are just lying cold on the ground helplessly as people step on them and smear dirt on their beautiful autumn colours. 
Don’t Leaf Me aims to collect all the leaves right after they fall off the tree and preserve them by laminating the leaves to create beautiful bookmarks, stickers, and decorations. 
The leaves will be collected from many different trees in Canada and thus will come in many difference shapes and colours. 
Don’t Leaf Me promotes a deeper appreciation to nature so that when someone sees a leaf on the ground, they would stop and acknowledge its beautiful appearance at that moment in fall.
</blockquote>

<h5>P.S. They're all $2.70!!!</h5>

<%
	if(session.getAttribute("authenticatedUser") != null && (int)session.getAttribute("admin") == 1)
		out.println("<h2><a href=\"adminIndex.jsp\">Back To Main</a></h2>");
	else 
		out.println("<h2><a href=\"index.jsp\">Back To Main</a></h2>");
%>


</body>
</html>
