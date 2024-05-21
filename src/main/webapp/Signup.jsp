<%-- 
    Document   : Signup
    Created on : May 19, 2024, 9:44:33 AM
    Author     : lengo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="./assets/images/logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            *{
                border: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body{
                background: #d4af37;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            table{
                padding: 12px 24px;
                border: 1px solid #000;
                box-shadow: 0 3px 9px #000; 
                border-radius: 4px;
            }
            h2{
                font-size: 32px;
                font-weight: 700;
                line-height: 2.0;
                text-align: center;
                color: #18206f;
            }
            th{
                padding-right: 12px;
            }
            th, td{
                font-weight: 700;
                color: #18206f;
                text-align: left;
                font-size: 20px;
            }
            td{
                padding: 6px 0;
                /*overflow: hidden;*/
                width: 100%;
            }
            input{
                padding: 12px;
                font-weight: 700;
                color: #18206f;
                border: 1px solid #000;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <%  
            String message = "";
            if(((String) request.getAttribute("message")) != null){
                message = (String) request.getAttribute("message");
            }
        %>
        
        <h2 class="log-in-title">Checking your Username and Password, Again</h2>           
        <form method="post" action="Signup">
            <table style="width: 420px">
                <%
                    if(message != null)
                    {    
                    %>
                    <tr><th colspan="2" style="text-align:center; color: #DD3333"><%= message %></th></tr>
                    <%
                        }
                %>
                <tr> 
                    <th>Username: </th>
                    <td><input type="text" id="username" name="username" style="width: 100%" required></td>
                </tr>
                <tr> 
                    <th>Password: </th>
                    <td><input type="text" id="password" name="password" style="width: 100%" required></td>
                </tr>
                <tr> 
                    <th>Password: </th>
                    <td><input type="text" id="password1" name="passwor1" style="width: 100%" required></td>
                </tr>
                <tr> 
                    <th>Phone: </th>
                    <td><input type="text" id="phone" name="phone" style="width: 100%" required></td>
                </tr>
                <tr>              
                    <td colspan="2" ><input type="submit" style="width: 100%" value="Sign Up" name="submit"></td>
                </tr>
            </table>
        </form>  
    </body>
</html>

