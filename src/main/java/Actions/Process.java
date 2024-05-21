/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Actions;

import JDBC.JDBCConnection;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

/**
 *
 * @author lengo
 */
@WebServlet(name="Process", urlPatterns={"/Process"})
public class Process extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet Process</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet Process at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
                String cusername = request.getParameter("username");
                String cfullname = request.getParameter("name");
                String cphone = request.getParameter("phone");
                String caddress = request.getParameter("address");
                String[] cservicesList = request.getParameterValues("service");
                String note = request.getParameter("comment");
                String contractdate = request.getParameter("date") + " " + request.getParameter("hour");
                
                String cservices = Arrays.toString(cservicesList);
//                for(int i = 0; i < cservicesList.length ; i++){
//                    cservices += cservicesList[i] +"<br";
//                }
                
            if(request.getParameter("Register") != null){
//                RequestDispatcher dispatcher = request.getRequestDispatcher("PersonInfor.jsp");
//                dispatcher.forward(request, response);
//                
                int id = 0;
                String sqlMaxId = "SELECT MAX(id) AS max_id FROM contract";
                
                try (Connection conn = JDBCConnection.getJDBCConnection();
                     PreparedStatement stmt = conn.prepareStatement(sqlMaxId);
                     ResultSet rs = stmt.executeQuery()) {

                    if (rs.next()) {
                        id = rs.getInt("max_id") + 1;
                    }

                    String sqlCheckContractDate = "SELECT contractdate FROM contract WHERE contractdate = ?";
                    try (PreparedStatement contractdatestmt = conn.prepareStatement(sqlCheckContractDate)) {
                        contractdatestmt.setString(1, contractdate);
                        try (ResultSet contractRs = contractdatestmt.executeQuery()) {
                            if (contractRs.next()) {
                                request.setAttribute("register","fail");
                                request.setAttribute("username", cusername);
                                RequestDispatcher dispatcher = request.getRequestDispatcher("template.jsp");
                                dispatcher.forward(request, response);
                            } else {
                                String sql = "INSERT INTO contract(id, contractdate, cusername, cfullname, cphone, caddress, note, cservices) " +
                                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                                try (PreparedStatement addContractStmt = conn.prepareStatement(sql)) {
                                    addContractStmt.setInt(1, id);
                                    addContractStmt.setString(2, contractdate);
                                    addContractStmt.setString(3, cusername);
                                    addContractStmt.setString(4, cfullname);
                                    addContractStmt.setString(5, cphone);
                                    addContractStmt.setString(6, caddress);
                                    addContractStmt.setString(7, note);
                                    addContractStmt.setString(8, cservices);

                                    if (addContractStmt.executeUpdate() > 0) {
                                        request.setAttribute("username", request.getParameter("username"));
                                        request.setAttribute("serviceid", request.getParameter("serviceid"));
                                        request.setAttribute("servicename", request.getParameter("servicename"));
                                        RequestDispatcher dispatcher = request.getRequestDispatcher("PersonInfor.jsp");
                                        dispatcher.forward(request, response);
                                    }
                                }
                            }
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle SQLException appropriately
                }

                
            } 
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
