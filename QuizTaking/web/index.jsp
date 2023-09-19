<%-- 
    Document   : index
    Created on : Sep 18, 2023, 10:36:57 AM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Index</h1>
        <%
          String id = request.getAttribute("id").toString();
//          String name = request.getAttribute("name").toString();
          String email = request.getAttribute("email").toString();
          out.print("Id: " + id);
//          out.print("<br/>Name: " + name);
          out.print("<br/>Email: " + email);
        %>
    </body>
</html>
