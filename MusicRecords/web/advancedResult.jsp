<%@page import="java.sql.*"%>

<jsp:useBean id="Login" scope="page" class="Mpack.Login">
</jsp:useBean>

<html>
    <head>
        <style>
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
                color: white;
            }
        </style>
        <title>
            Search Results
        </title>
    </head>
    <body style="text-align: center; background-color: black">
        <h2> Search Results:</h2>
        
<%
    String albId = request.getParameter("al_id");
    String instId = request.getParameter("inst_id");
    
    if(albId != null)
    {
        String sTitle[] = new String[5000];
        int j = 0;
    
        String query = "select title from song where al_id =" + albId;
    
        Login.connectDb();
        ResultSet rs = Login.statementDb(query);
    
        while(rs.next())
        {
        sTitle[j]=rs.getString("title");
        j++;
        }
        Login.closeStatement();
        Login.closeDb();
    
        out.print("<table border='1' align='center'><tr> <th>Album Songs</th> </tr>");
    
        for(int i=0; i<j; i++)
        {
        
            out.print("<tr> <td>" + sTitle[i] + "</td> </tr>");
        }
        out.print("</table>");
    }
    else if(instId != null)
    {
        String sTitle[] = new String[5000];
        int j = 0;
    
        String query = "call sel_song_from_inst(" + instId + ")";
    
        Login.connectDb();
        ResultSet rs = Login.statementDb(query);
    
        while(rs.next())
        {
        sTitle[j]=rs.getString("title");
        j++;
        }
        
        Login.closeStatement();
        Login.closeDb();
    
        out.print("<table border='1' align='center'><tr> <th>Songs</th> </tr>");
    
        for(int i=0; i<j; i++)
        {
        
            out.print("<tr> <td>" + sTitle[i] + "</td> </tr>");
        }
        out.print("</table>");
    }
    else
        return;
%>
        
    </body>
</html>