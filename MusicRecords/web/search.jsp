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
    String sid[] = new String[5000];
    String sTitle[] = new String[5000];
    String alTitle[] = new String[5000];
    String instName[] = new String[5000];
    String sName[] = new String[5000];
    String media[] = new String[5000];
    int j = 0;
    
    String query = "select song.sid, song.title, album.al_title, instruments.inst_name, "
            + "singer.sname,song.media from song, album, instruments, singer "
            + "where song.title like '%" + request.getParameter("search") 
            + "%' and song.al_id =album.al_id " + "and song.inst_id = instruments.inst_id "
            + "and song.singer_id = singer.singer_id";
    
    Login.connectDb();
    ResultSet rs = Login.statementDb(query);
    
    while(rs.next())
    {
        sid[j] = rs.getString("sid");
        sTitle[j]=rs.getString("title");
        alTitle[j]=rs.getString("al_title");
        sName[j]=rs.getString("sname");
        media[j]=rs.getString("media");
        j++;
    }
    
    for(int i=0; i<j; i++)
    {
        String qInst = "call sel(" + sid[i] + ")";
      
        ResultSet rs2 = Login.statementDb(qInst);
            
        out.print("<table border='1' align='center'>");
        out.print("<tr> <th colspan='2'>Song Details</th> </tr> <tr> <td>Title</td> <td>"
                + sTitle[i] + "</td> <tr> <td>Album</td> <td>" 
                + alTitle[i] + "</td> <tr> <td> Instruments &nbsp</td> <td>"); 
        if(rs2.next())
            out.print(rs2.getString("inst_name"));
        
        for(int k=0; rs2.next(); k++)
        {
            instName[k] = rs2.getString("inst_name");
            out.print(", " + instName[k]);
        }
        
        out.print("</td> </tr> <tr> <td>Singer</td> <td>" + sName[i] 
                + "</td> </tr> <tr> <td>Video</td> <td>" + media[i] + "</td> </table><br/>");
    }
    
    Login.closeStatement();
    Login.closeDb();
    
%>
        
    </body>
</html>