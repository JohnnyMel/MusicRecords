package Mpack;

import java.sql.*;

public class Login {
     
    Statement statement;
    Connection conn;
    ResultSet rs;
    
    private String user;
    private String pass;
    
    public void connectDb() throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Music?user=root&password=");
    }

    public ResultSet statementDb(String query) throws SQLException
    {
        statement = conn.createStatement();
        rs = statement.executeQuery(query);
        return rs;
    }
    
    public void closeStatement() throws SQLException
    {
        rs.close();
    }
    
    public void updateStatementDb(String query) throws SQLException
    {
        statement = conn.createStatement();
        statement.executeUpdate(query);
        
    }

    public void closeDb() throws SQLException
    {
        
        statement.close();
        conn.close();
    }
    public String getUser()
    {
        return user;
    }

    public String getPass()
    {  
        return pass;
    }

    public void setUser(String uname) 
    {
        //user = new String();
        user = uname;
    }
    
    public void setPass(String pwd) 
    {
        pass = new String();
        pass = pwd;
    }
}
