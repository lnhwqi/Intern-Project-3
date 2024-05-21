<%-- 
    Document   : templateService
    Created on : May 19, 2024, 3:10:51 PM
    Author     : lengo
--%>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<%@ page import="java.util.Arrays" %>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import="JDBC.JDBCConnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>title</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="./assets/images/logo.jpg">
        <link href="./assets/css/reset.css" rel="stylesheet" type="text/css">
        <link href="./assets/css/styles.css" rel="stylesheet" type="text/css">
        
        <style>
            body{
                color: var(--primary-bgc);
                width: 100vw;
                min-height: 100vh;
            }
            textarea {
                resize: none;
                vertical-align: top;
                padding: 4px;
                border-radius: 8px;
            }
            #servicetemplate-title{
                font-size: 32px;
                font-weight: 700;
                line-height: 3.2;
                margin-left: 24px;
                text-transform: uppercase;
            }
            table{
                margin-left: 24px;
            }
            th{
                text-align: left;
                font-weight: 700;
                padding-right: 12px;
            }
            td{
                padding: 4px 0;
            }
            input{
                padding: 8px 12px;
                border-radius: 8px;
            }
            select{
                padding: 8px 12px;
                border-radius: 8px;
            }
            .checkbox{
                width: 16px;
                height: 16px;
                margin: 12px;
                accent-color: var(--primary-bgc);
            }
            label{
                font-size: 16px;
            }
            #blur:hover{
                cursor: pointer
            }
            #close-btn{
                cursor: pointer;
                color: #d4af37;
            }
        </style>
    </head>
    <body>
        
        <%  
            String cusername = request.getParameter("username"); 
            String serviceid = request.getParameter("serviceid"); 
            String servicename = request.getParameter("servicename");
            String register="";
            if((String) request.getAttribute("register") != null){
                register = (String) request.getAttribute("register");
            }
            
        %>
        <div id="announce" style="z-index:3; position: absolute; top: 50%; left: 50%; transform: translateX(-50%) translateY(-50%) ;display: none; padding: 32px; border-radius: 12px; background: var(--primary-bgc); font-weight: 700; color: var(--primary-color)">
            <h1 style="text-align:center; line-height: 1.4">Ooops! That time has been book, Let choose another options, sorry for inconvenience</h1>
            <div id='close-btn' style="position: absolute; top: 0; right: 0; padding: 16px; color: #DD3333; background: var(--primary-color); border-top-right-radius: 12px;border-bottom-left-radius: 12px">x</div>
        </div>
        <a id="backPage" href="#!" style="position:absolute; top: 24px; right: 24px; padding: 8px 12px; background: var(--primary-bgc); color: var(--primary-color); font-weight: 700; border: 1px solid #000; border-radius: 4px">Back</a>
        <div id="blur" style=""></div>
        
        <div id="servicetemplate-title"></div>
       
        <form method="post" action="Process" id="registerform">
            <table>
                <tr>
                    <td><input type="hidden" id="username" name="username" style="width: 360px"></td>
                    <td><input type="hidden" id="serviceid" name="serviceid" style="width: 360px"></td>
                    <td><input type="hidden" id="servicename" name="servicename" style="width: 360px"></td>
                </tr>
                <tr> 
                    <th>Username: </th>
                    <td><p style="padding: 8px 12px"><%= cusername %></p></td>
                    <td></td>
                </tr>
                <tr> 
                    <th>Full Name: </th>
                    <td><input type="text" id="name" name="name" style="width: 360px" required></td>
                    <td></td>
                </tr>
                <tr> 
                    <th>Phone: </th>
                    <td><input type="text" id="phone" name="phone" style="width: 360px" required></td>
                    <td></td>
                </tr>
                <tr> 
                    <th>Address: </th>
                    <td><input type="text" id="address" name="address" style="width: 360px" required></td>
                    <td></td>
                </tr>
                <tr> 
                    <th>Date: </th>
                    <td><input type="date" id="date" name="date" style="width: auto" min="2024-05-17"  required></td>
                    <td></td>
                </tr>
                <tr> 
                    <th>Hour: </th>
                    <td>
                        <select name="hour" id="hour" required>

                        </select>
                    </td>
                    <td></td>
                </tr>
                <tr> 
                    <th>List of Services: </th>
                    <td id="list-of-services">
<!--                        <input class="checkbox" type="checkbox" name="service" id="overnightcare" value="Overnight Care"  ><label for="overnightcare">Overnight Care</label><br>
                        <input class="checkbox" type="checkbox" name="service" id="pettaxi" value="Pet Taxi"><label for="pettaxi">Pet Taxi</label><br>
                        <input class="checkbox" type="checkbox" name="service" id="petmedical" value="Pet Medical"><label for="petmedical">Pet Medical</label><br>-->
                    </td>
                    <td>
                        <table>
                            <tr> 
                                <th>Comments: </th>
                                <td><textarea id="comment" name="comment" style="width: 420px; height: 120px"></textarea></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <tr>              
                    <td colspan="2" ><input  type="submit" value="Register" name="Register" style="width: 100%; background-color: var(--primary-bgc); color: var(--primary-color); font-weight: 700"></td>
                    <td></td>
                </tr>
                
                <%
                
        %>
                
                
            </table>
        </form>
        
        
        <script>
            let urlParams = new URLSearchParams(window.location.search);
            let newtitle = urlParams.get('servicename');
            if(newtitle === null){
                newtitle = '<%= servicename %>';
            };
            document.title = newtitle;
            let mainserviceid =  urlParams.get('serviceid');
            
            if(mainserviceid === null){
                mainserviceid =  '<%= serviceid %>';
            };
            document.getElementById("username").value = "<%= cusername %>";
            document.getElementById("servicename").value = "<%= servicename %>";
            document.getElementById("serviceid").value = "<%= serviceid %>";
            
            document.getElementById("servicetemplate-title").innerHTML = newtitle;
            
            document.getElementById("backPage").href = "services.html?username=" + "<%= cusername %>";
            
            let isRegister = "<%= register %>";
            console.log(document.getElementById("username").value);
            
            if(isRegister === "fail"){
                document.getElementById("blur").style.display = "block";
                document.getElementById("announce").style.display = "block";
            }
            let closeAnnoucement = function(){
                document.getElementById("blur").style.display = "none";
                document.getElementById("announce").style.display = "none";
            };
            document.getElementById("blur").addEventListener('click', closeAnnoucement );
            document.getElementById("close-btn").addEventListener('click', closeAnnoucement);
            
            function fetchData() {
                fetch('data.json')
                    .then(response => response.json())
                    .then(data => {
                        displayData(data);
                        const timeopeninglist = document.getElementById('hour');
                        timeopeninglist.innerHTML = '';
                        const date = new Date(document.getElementById("date").value);
                        const isSunday = (date.getUTCDay() === 0);
                        if(isSunday){
                            data.sundaytimeopenning.forEach(day => {
                                const item = document.createElement('option');
                                item.innerHTML = day.hour;
                                item.value = day.id;
                                timeopeninglist.appendChild(item);
                            });                 
                        }
                        else{
                            data.timeopenning.forEach(day => {
                                const item = document.createElement('option');
                                item.innerHTML = day.hour;
                                item.value = day.id;
                                timeopeninglist.appendChild(item);
                            });      
                        }                   
                        document.getElementById("date").addEventListener("change",function(){
                            date = new Date(document.getElementById("date").value);
                            isSunday = (date.getUTCDay() === 0);
                            if(isSunday){
                                data.sundaytimeopenning.forEach(day => {
                                    const item = document.createElement('option');
                                    item.innerHTML = day.hour;
                                    item.value = day.id;
                                    timeopeninglist.appendChild(item);
                                });                 
                            }
                            else{
                                data.timeopenning.forEach(day => {
                                    const item = document.createElement('option');
                                    item.innerHTML = day.hour;
                                    item.value = day.id;
                                    timeopeninglist.appendChild(item);
                                });      
                            }                   
                        });
                    })
                    .catch(error => console.error('Error fetching data:', error));
            }
                console.log(mainserviceid);

        
            function displayData(data) {
                const serviceList = document.getElementById('list-of-services');
                serviceList.innerHTML = '';

                data[mainserviceid].forEach(service => {
                    const item = document.createElement('input');
                    item.classList.add("checkbox");
                    item.type = "checkbox";
                    item.name = "service";
                    item.id = "service";
                    item.value = service.name;
                    
                    const label = document.createElement('label');
                    label.for = service.id;
                    label.innerHTML = service.name;
                    
                    const br = document.createElement('br');      
                    
                    serviceList.appendChild(item);
                    serviceList.appendChild(label);
                    serviceList.appendChild(br);
                    
                });

                    
            }
            window.onload = fetchData;  

            
            let currentDate = new Date().toISOString().split('T')[0];
            console.log(currentDate);
            document.getElementById("date").setAttribute("min", currentDate);
            document.getElementById("date").setAttribute("value", currentDate);
            document.getElementById('registerform').addEventListener('submit', function(event){
                const checkboxes = document.querySelectorAll('input[type="checkbox"][name="service"]');
                let oneChecked = false;
                for (const checkbox of checkboxes) {
                    if (checkbox.checked) {
                        oneChecked = true;
                        break;
                    }
                }

                if (!oneChecked) {
                    event.preventDefault();  // Prevent form submission
                    alert('Please select at least one service.');
                }
            });


        </script>
    </body>
</html>
