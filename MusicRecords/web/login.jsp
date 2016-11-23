<%@page import="com.mysql.jdbc.exceptions.MySQLSyntaxErrorException"%>
<%@page import="java.sql.*"%>

<jsp:useBean id="Login" scope="session" class="Mpack.Login">
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
            a 
            {
                color: white;
            }
        </style>
        <title>
            Music Corner
        </title>
    </head>
    <body style="background-color: black">
<%
    String afm = "";
    String user = new String();
    String pass = new String();
    String sid[] = new String[5000];
    String sTitle[] = new String[5000];
    String alTitle[] = new String[5000];
    String instName[] = new String[5000];
    String sName[] = new String[5000];
    String media[] = new String[5000];
    int j = 0;
    String username = request.getParameter("user");
    String password = request.getParameter("pass");
    
    if(username == null || username.equals(""))
    {
        username = Login.getUser();
        password = Login.getPass();
    }
    
    String query1 = "select afm, user, pass from musician where user='" + username + "' and pass='" + password + "'";
    
    try
    {
    Login.connectDb();
    ResultSet rs = Login.statementDb(query1);
    
    while(rs.next())
    {
        afm = rs.getString("afm");
        user = rs.getString("user");
        pass = rs.getString("pass");
        j++;
    }
    
    j = 0;
    
    /*if(!(user.equals(username) || pass.equals(password) || afm.equals("")))
    {
        Login.setUser(null);
        response.sendRedirect("login.html");
    }*/
        
    Login.setUser(user);
    Login.setPass(pass);
    
    session.setAttribute("afm", afm);
    
    String query2 = "select song.sid, song.title, album.al_title, instruments.inst_name, "
            + "singer.sname,song.media from song, album, instruments, singer "
            + "where song.al_id =album.al_id " + "and song.inst_id = instruments.inst_id "
            + "and song.singer_id = singer.singer_id and song.afm=" + afm;
    
    ResultSet rs2 = Login.statementDb(query2);
    
    while(rs2.next())
    {
        sid[j] = rs2.getString("sid");
        sTitle[j]=rs2.getString("title");
        alTitle[j]=rs2.getString("al_title");
        //instName[j]=rs2.getString("inst_name");
        sName[j]=rs2.getString("sname");
        media[j]=rs2.getString("media");
        j++;
    }
    
    
    
    String total = new String();
    String qtotal = "select total from total_songs where afm = " + afm;
    
    ResultSet rs3 = Login.statementDb(qtotal);
    while(rs3.next())
    total = rs3.getString("total");
 
%>

<a style="font-size: small">Hello <%= user %> </a>    
<a style="font-size: small" href="logout.jsp">Logout</a> 
<a style="font-size: small"> | </a>
<a style="font-size: small" href="index.html">Home</a>

<div style="text-align: center;">
<h2>Your Songs</h2>
            
<a href='add.jsp'>Add</a> 
<a style='color: black'>_</a>;
<a href='delete.jsp'>Delete</a> 
<a style='color: black'>_</a>
<a href='edit.jsp'>Edit</a> 
<a style='color: black'>_</a>
<a href='stats.jsp'>Stats</a> 
<a style='color: black'>_</a>
<h1> </h1>

<table  align="center"><tr><td>Total Songs: <%= total %></td></tr></table>
<br>
<%   
    for(int i=0; i<j; i++)
    {
        String qInst = "call sel(" + sid[i] + ")";
      
        ResultSet rs4 = Login.statementDb(qInst);
        
        out.print("<table border='1' align='center'>");
        out.print("<tr> <th colspan='2'>Song Details</th> </tr> <tr> <td>Title</td> <td>"
                + sTitle[i] + "</td> <tr> <td>Album</td> <td>" 
                + alTitle[i] + "</td> <tr> <td> Instruments &nbsp;</td> <td>");
                
        if(rs4.next())
            out.print(rs4.getString("inst_name"));
        
        for(int k=0; rs4.next(); k++)
        {
            instName[k] = rs4.getString("inst_name");
            out.print(", " + instName[k]);
        }
                
        out.print("</td> </tr> <tr> <td>Singer</td> <td>" + sName[i] 
                + "</td> </tr> <tr> <td>Video</td> <td>" + media[i] + "</td> </table><br/>");
    }
    Login.closeStatement();
    Login.closeDb();
    }
    catch(MySQLSyntaxErrorException ex)
    {
        response.sendRedirect("login.html");
    }
%>
        </div>
    </body>
</html>