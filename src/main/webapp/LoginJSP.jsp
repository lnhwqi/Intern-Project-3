<%-- 
    Document   : LoginJSP
    Created on : May 15, 2024, 5:54:31 PM
    Author     : lengo
--%>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="JDBC.JDBCConnection" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            body{
                background: #d4af37;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            table{
            }
            h2{
                font-size: 32px;
                font-weight: 700;
                line-height: 2.0;
                text-align: center;
                color: #18206f
            }
            th, td{
                font-weight: 700;
                color: #18206f;
                text-transform: capitalize;
                text-align: left;
                font-size: 20px;
            }
            td{
                padding: 6px 0;
            }
            input{
                padding: 12px;
                font-weight: 700;
                color: #18206f;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <h2 class="log-in-title">Checking your Username and Password, Again</h2>
        <form method="post" action="LoginJSP.jsp">
            <table>
                <tr> 
                    <th>Username: </th>
                    <td><input type="text" id="username1" name="username1" style="width: 160px" required></td>
                </tr>
                <tr> 
                    <th>Password: </th>
                    <td><input type="text" id="password1" name="password1" style="width: 160px" required></td>
                </tr>
                <tr>              
                    <td colspan="2" ><input type="submit" style="width: 100%" value="Submit" name="submit"></td>
                </tr>
            </table>
        </form>  

        <%

            
            if (request.getParameter("submit") != null)
            {
                String username = request.getParameter("username1");
                String password = request.getParameter("password1");

                boolean checkAuthentication = false;

                Connection conn = JDBCConnection.getJDBCConnection();
                PreparedStatement stmt = null;
                ResultSet rs = null;
                
                if (conn != null) {
                    String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, username);
                    stmt.setString(2, password);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        checkAuthentication = true;
                    }
                    rs.close();
                    stmt.close();
                    conn.close();                
                    
                    if (checkAuthentication == true) {
                        response.sendRedirect("index.html");
    
                    } else {
                        out.println("<p>:)?</p>");
                    }
                }
                

            }
        
            
        %>
    </body>
</html>

