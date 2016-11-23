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
                background-color:  black;
            }
            h2
            {
                color: red;
            }
            td
            {
                color: white;
                border:none;
            }
            a
            {
                color: white;
            }
            select
            {
                width: 142px;
            }
            input[type = "submit"]
            {
                background-color: darkorange;
                color: white;
                border-color: darkorange;
                
            }
            
        </style>
        <title>Add Song</title>
    </head>
    
    <body>   
        
<%
  String aID[] = new String[1000],
         alName[] = new String[1000],
         sID[] = new String[1000],
         singerName[] = new String[1000],
         instID[] = new String[100],
         instName[] = new String[100];
  
  String qShowAl = "select al_id, al_title from album";
  
  Login.connectDb();
  ResultSet rs0 = Login.statementDb(qShowAl);
  int j = 0;
  while(rs0.next())
  {
      aID[j] = rs0.getString("al_id");
      alName[j] = rs0.getString("al_title");
      j++;
  }
  
  String qShowSinger = "select singer_id, sname from singer";
  rs0 = Login.statementDb(qShowSinger);
  
  int k = 0;
  while(rs0.next())
  {
      sID[k] = rs0.getString("singer_id");
      singerName[k] = rs0.getString("sname");
      k++;
      
  }
  
  String qShowInst = "select inst_id, inst_name from instruments";
  
  rs0 = Login.statementDb(qShowInst);
  int l = 0;
  
  while(rs0.next())
  {
      instID[l] = rs0.getString("inst_id");
      instName[l] = rs0.getString("inst_name");
      l++;
  }
%>
        
        <a style="font-size: small" href="logout.jsp">Logout</a> 
        <a style="font-size: small"> | </a>
        <a style="font-size: small" href="index.html">Home</a>
        <div style="text-align: center">
            <h2>Add a Song</h2>
            <form action="add.jsp" method="get">
            <table border="1" bgcolor="darkblue" align="center">
                <tr >
                    <td>
                        Song Title:
                    </td>
                    <td>
                        <input type="text" name="sname">
                    </td>
                </tr>
                <tr>
                    <td>
                        Album Title:
                    </td>
                    <td>
                        <select name='altitle'>
                            <option value=''>Select</option>
                            <% for(int i = 0; i<j; i++)
                                out.println("<option value='" + aID[i] + "'>" + alName[i] + "</option>");
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        Singer's Name:
                    </td>
                    <td>
                        <select name='singerid'>
                            <option value=''>Select</option>
                            <% for(int i = 0; i<k; i++)
                                out.println("<option value='" + sID[i] + "'>" + singerName[i] + "</option>");
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        Video Clip:
                    </td>
                    <td>
                        <input type="text" name="media">
                    </td>
                </tr> 
                <tr>
                    <td>
                        Instruments:
                    </td>
                    <td>
                        <p style="font-size: small">
                        <% for(int i=0; i<l; i++)
                        {
                              if(i == 2)
                                out.println("<input type='checkbox' name='instid' value='" 
                                    + instID[i] + "'>" + instName[i] + "&nbsp");
                              else
                                out.println("<input type='checkbox' name='instid' value='" 
                                    + instID[i] + "'>" + instName[i] + " ");
                              if((i+1) % 2 == 0)
                                  out.print("<br>");
                        }
                        %>
                        </p>
                    </td>
                </tr>
                
                <tr>
                    <td colspan="2">
                        <p style="text-align: center"> <input type="submit" value="Submit"> </p>
                    </td>    
                </tr>
            </table>
            </form> 
        
     <%
         String  sid = request.getParameter("sid"),
                 sname = request.getParameter("sname"), 
                 alid = request.getParameter("altitle"),
                 instid[] = request.getParameterValues("instid"),
                 afm = "",
                 singerid = request.getParameter("singerid"),
                 media = request.getParameter("media");
         
         
         if(sname == null || alid == null || instid == null  
                 || singerid == null || media == null)
             return;
         
         if(sname.equals("") || alid.equals("") || instid[0].equals("")  
                 || singerid.equals("") || media.equals(""))
         {
             out.print("<p style='color: red'> Error some of the fields are empty!</p>");
             return;
         }
         
         //Login.connectDb();
         
         afm = (String) session.getAttribute("afm");
         
         String query = "insert into song values(null"
                 + ",'" + sname + "'," + alid + "," 
                 + instid[0] + "," + afm + "," + singerid + ",'" + media + "')";
         
         Login.updateStatementDb(query);
         
         query = "SELECT sid FROM song where title = '" + sname + "'";
         ResultSet rs = Login.statementDb(query);
         
         if(rs.next())
             sid = rs.getString("sid");
         
         for(int i=1; i<instid.length; i++)
         {
             query = "insert into inst_song values(" 
                 + instid[i] + "," + alid + "," + sid + ")";
             Login.updateStatementDb(query);
         }
         
         out.print("<p style='color: green'>The Song has been added successfully</p>");
         Login.closeDb();
         
     %> 
     
<br/> <br/>
<a style="font-size: small" href="login.jsp">Go to your Song List</a>

    </div>
    </body>
</html>
