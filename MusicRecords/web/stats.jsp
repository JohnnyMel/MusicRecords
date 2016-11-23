<%@page import="java.sql.*"%>

<jsp:useBean id="Login" scope="session" class="Mpack.Login">
</jsp:useBean>

<%
if(Login.getUser() == null || Login.getUser().equals(""))
    response.sendRedirect("login.html");    
%>

<html>
    <head>
        <style>
            body
            {
                background-color: black;
                
            }
            div
            {
                text-align: center;
            }
            h2
            {
                color: red;
            }
            th
            {
                color: red;
            }
            td
            {
                border: none;
                color: white;
            }
            a 
            {
                color: white;
            }
        </style>
        <title>
            General Stats
        </title>
    </head>
    <body>
        
<%
    String tSongs;
    String tAlbums;
    String tMusicians;
    String call = "call counter()";
    
    Login.connectDb();
    ResultSet rs = Login.statementDb(call);
    
    rs.next();
    tSongs = rs.getString("i");
    tAlbums = rs.getString("j");
    tMusicians = rs.getString("k");
    
    Login.closeStatement();
    Login.closeDb();
%>
        <a style="font-size: small" href="logout.jsp">Logout</a> 
        <a style="font-size: small"> | </a>
        <a style="font-size: small" href="index.html">Home</a>
        <div>
            <h2>General Stats</h2>
            <table border="1" align="center">
                <th colspan="2">Statistics</th>
                <tr>
                    <td>
                        Total Songs:
                    </td>
                    <td>
                        <%= tSongs %>
                    </td>
                </tr>
                <tr>
                    <td>
                        Total Albums:
                    </td>
                    <td>
                        <%= tAlbums %>
                    </td>
                </tr>
                <tr>
                    <td>
                        Total Musicians:
                    </td>
                    <td>
                        <%= tMusicians %>
                    </td>
                        
                </tr>
            </table>
        </div>
     </body>
</html>
