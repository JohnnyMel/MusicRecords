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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Song</title>
        <style>
            body
            {
                background-color: black;
            }
            h2
            {
                color: red;
            }
            p
            {
                color: white;
            }
            a
            {
                color: white;
            }
            input[type = "submit"]
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
        <h2>Edit Song</h2>
         
<% 
    String sid[] = new String[1000];
    String title[] = new String[1000];
    
    Login.connectDb();
    
    String query = "select sid, title from song where afm = " + session.getAttribute("afm");
    
    ResultSet rs = Login.statementDb(query);
    
    int i = 0;
    
    out.println("<form id='form' method='get' action='edit.jsp'>"
            + "<p> Song: " + "<select name='option1'>" 
            + "<option value=''>Select</option>");
    
    while(rs.next())
    {
        sid[i] = rs.getString("sid");
        title[i] = rs.getString("title");
        out.println("<option value='" + sid[i] + "'>" 
                + title[i] + "</option>");
        i++;
    }
    out.println("</select>");
    Login.closeStatement();
    Login.closeDb();
    
%>
        
        
                Edit: 
                <select name="option2">
                    <option value="">Select</option>
                    <option value="sid" >Song ID</option>
                    <option value="title" >Title</option>
                    <option value="al_id" >Album ID</option>
                    <option value="inst_id" >Instrument ID</option>
                    <option value="afm" >Musician ID</option>
                    <option value="singer_id" >Singer ID</option>
                    <option value="media" >Media</option>
                </select>
                <input type="submit" value="Edit"/>
                </p> 
            </form>
           
<% 
    String opt1 = request.getParameter("option1");
    String opt2 = request.getParameter("option2");
    
    if(opt1 == null || opt2 == null)
        return;
    out.println("<form id='form' method='get' action='edit.jsp'>"
            + "<p>" + opt2 + ": " + "<input type='text' name='" + opt2 + "'>"
            + "<input type='hidden' name='option1' value='" + opt1 + "'>"
            + "<input type='hidden' name='option2' value='" + opt2 + "'>"
            + " <input type='submit' value='Submit'/> </p>");
 
    String opt3 = request.getParameter(opt2);
    
    if(opt3 == null || opt3.equals(""))
        return;
    
    Login.connectDb();
    
    String update;
    if(opt2.equals("title") || opt2.equals("media"))
        update = "update song set " + opt2 + " = '"+ opt3 + "' where sid=" + opt1;
    else
        update = "update song set " + opt2 + " = "+ opt3 + " where sid=" + opt1;
    Login.updateStatementDb(update);
    out.println("<p2 style='color: green'>The Update Was Successfull!");
    
    Login.closeDb();
    }
    catch(Exception ex)
    {
        return;
    }
%>
<br/> <br/>
<a style="font-size: small" href="login.jsp">Go to your Song List</a>

</div>
</body>
</html>
