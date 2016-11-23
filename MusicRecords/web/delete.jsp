<%@page import="com.mysql.jdbc.exceptions.MySQLSyntaxErrorException"%>
<%@page import="java.sql.*"%>

<jsp:useBean id="Login" scope="session" class="Mpack.Login">
</jsp:useBean>

<%
    try 
    {
if(Login.getUser() == null || Login.getUser().equals(""))
    response.sendRedirect("login.html");    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Delete a Song</title>
        <style>
            body
            {
                background-color: black;
            }
            h2
            {
                color: red;
            }
            td
            {
                color: white;
            }
            a
            {
                color: white;
            }
            button
            {
                background-color: darkorange;
                color: white;
                border-color: darkorange;
                
            }
        </style>
    </head>
    <body>
        <a style="font-size: small" href="logout.jsp">Logout</a> 
        <a style="font-size: small"> | </a>
        <a style="font-size: small" href="index.html">Home</a>
        <div style="text-align: center">
          <h2>Delete a Song</h2>
<% 
    String alTitle[] = new String[1000];
    String sTitle[] = new String[1000];
    String afm = "";
    afm = (String) session.getAttribute("afm");
    
    Login.connectDb();
    
    String query = "select album.al_title, song.title from album, song where song.al_id = album.al_id and song.afm=" + afm;
    ResultSet rs = Login.statementDb(query);
    
    int i = 0;
    out.print("<table border='1' align='center' bgcolor='darkblue'>");
    while(rs.next())
    {
        alTitle[i] = rs.getString("al_title");
        sTitle[i] = rs.getString("title");
        out.print("<tr> <td>" + alTitle[i] + " - " + sTitle[i] + "</td>");
        out.print("<td><button onclick=" + '"' + "window.location.href='delete.jsp?del=" 
                + sTitle[i] + "'" + '"' + ">Delete</button></td><tr>");
        i++;
    }
    out.print("</table>");
    
    
    String del = request.getParameter("del");
    if(del == null || del.equals(""))
        return;
    
    String query2 = "delete from song where title='" + del + "'";
    
    Login.updateStatementDb(query2);
    Login.closeStatement();
    Login.closeDb();
    
    response.sendRedirect("delete.jsp");
    }
    catch(Exception e)
    {
        return;
    }
%>
        </div>
    </body>
</html>
