<%-- 
    Document   : Infor
    Created on : May 19, 2024, 12:22:45 PM
    Author     : lengo
--%>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import="JDBC.JDBCConnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="shortcut icon" href="./assets/images/logo.jpg">
        <link href="./assets/css/reset.css" rel="stylesheet" type="text/css">
        <link href="./assets/css/styles.css" rel="stylesheet" type="text/css">
        <style>
            body{
                background: var(--primary-bgc);
            }
            #information{
                padding: 24px;
                font-weight: 700;
                font-size: 24px;
                line-height: 1.4;
                color: var(--primary-color);
                border-bottom: 2px solid var(--primary-color);
            }
            #list-registration{
                padding: 24px;
            }
            table{
                width: 100%;
                border-collapse: collapse;
                border: 1px solid;
            }
            th{
                color: var(--primary-color);
                font-weight: 700;
            }
            th,td{
                text-align: left;
                padding: 14px;
                border: 1px solid;
            }
            
        </style>
    </head>
    <body>
        <%
            String username = request.getParameter("username");
            String phone ="";
            String sql =  "SELECT * FROM client WHERE username = ?";
            try (Connection conn = JDBCConnection.getJDBCConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                // Set parameters
                stmt.setString(1, username);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        phone = rs.getString("phone");
                        String sqlservicesList = "SELECT * FROM contract WHERE cusername=? ORDER BY contractdate DESC";
        %>

        <div>
            <div id="information">
                <div id="username">Username: <%= username %></div>
                <div id="phone">Phone: <%= phone %></div>
            </div>
            <div id="action">
                
            </div>
        </div>
        <a id="backPage" href="#!" style="position:absolute; top: 24px; right: 24px; padding: 8px 12px; background: var(--primary-color); color: var(--primary-bgc) ; font-weight: 700; border: 1px solid #000; border-radius: 4px">Back</a>

        <div id="list-registration">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Time</th>
                    <th>Full Name</th>
                    <th>Address</th>
                    <th>Services</th>
                </tr>
                
                <%
                try (PreparedStatement clientServicesListStmt = conn.prepareStatement(sqlservicesList)) {
                            clientServicesListStmt.setString(1, username);
                            
                            try (ResultSet clientServicesListRs = clientServicesListStmt.executeQuery()) {
                                while (clientServicesListRs.next()) {
                                %>
                                <tr>
                                    <th><%= clientServicesListRs.getInt("id")  %></th>
                                    <td><%= clientServicesListRs.getTimestamp("contractdate")%></td>
                                    <td><%= clientServicesListRs.getString("cfullname")%></td>
                                    <td><%= clientServicesListRs.getString("caddress")%></td>
                                    <td><%= clientServicesListRs.getString("cservices")%></td>
                                </tr>   
                                <%}
                            }
                        }
                    }
                    rs.close();
                    conn.close();
                    stmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle SQLException appropriately
            }
            %>
                
            </table>
        </div>
        
        <script>
            let newtitle =" <%= username %>";
            document.title = newtitle;
            
            document.getElementById("backPage").href = "services.html?username=" + "<%= username %>";

        </script>
        
        
    </body>
</html>
