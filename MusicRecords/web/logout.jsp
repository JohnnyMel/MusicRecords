
<%@page import="java.sql.*"%>

<jsp:useBean id="Login" scope="session" class="Mpack.Login">
</jsp:useBean>

<% 
    Login.setUser(null);
    response.sendRedirect("index.html");
%>