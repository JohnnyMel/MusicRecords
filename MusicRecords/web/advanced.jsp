<%@page import="java.sql.*"%>
<jsp:useBean id="Login" scope="page" class="Mpack.Login">
</jsp:useBean>

<html>
    <head>
        <title>Advanced Search</title>
    </head> 
    <style>
        input[type = "submit"]
            {
                background-color: darkorange;
                color: white;
                border-color: darkorange;
                
            }
    </style>
    <body style="background-color: darkblue;">
        <h2 style="color: red">Music Corner</h2>
        <form id="form" method="get" action="advanced.jsp">
        <table bgcolor="grey" align="center">
            <tr>
                <td style="color: white; font-size: small">
                    Search:
                </td>
                <td>
                    <select name="option">
                            <!--<option value="">Select</option> -->
                            <option value="1" >Albums</option>
                            <option value="2" >Instruments</option>
                    </select>
                    <input type="submit" value="Find Now"/>
                </td>
        </tr>
        </table>
        </form>
        <div style="background-color: white;">
            
<%  
    String option = request.getParameter("option");
    if((option == null) || option.equals(""))
        return;
                   
    Login.connectDb();
    
    if(option.equals("1"))
    {
        int albId[] = new int[5000];
        String alTitle[] = new String[5000];
        String image[] = new String[5000]; 
        int j = 0;
        String query = "select al_id, al_title, image from album;";
        
        ResultSet rs = Login.statementDb(query);
    
        while(rs.next())
        {
            albId[j] = rs.getInt("al_id");
            alTitle[j] = rs.getString("al_title");
            image[j] = rs.getString("image");
            j++;
        }
    
    
    
        for(int i=0; i<j; i++)
        {
            out.print("<table><tr><td><img src='" + image[i] 
                + "' width='100' height='93'/></td><td>" 
                + "<a href='advancedResult.jsp?al_id="
                +  albId[i] + "'>" + alTitle[i] + "</a> </td></tr></table> ");
        }
    }
    else
    {
        int instId[] = new int[5000];
        String instName[] = new String[5000];
        String image[] = new String[5000]; 
        int j = 0;
        String query = "select inst_id, inst_name, image from instruments";
        
        ResultSet rs = Login.statementDb(query);
    
        while(rs.next())
        {
            instId[j] = rs.getInt("inst_id");
            instName[j] = rs.getString("inst_name");
            image[j] = rs.getString("image");
            j++;
        }
    
        for(int i=0; i<j; i++)
        {
            out.print("<table><tr><td><img src='" + image[i] 
                + "' width='100' height='93'/></td><td>" 
                + "<a href='advancedResult.jsp?inst_id="
                +  instId[i] + "'>" + instName[i] + "</a> </td></tr></table>");
        }
    }
    Login.closeStatement();
    Login.closeDb();
%>
            
        
        
        </div>
    </body>
</html>