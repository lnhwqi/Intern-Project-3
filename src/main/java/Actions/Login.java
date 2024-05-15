/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Actions;

import JDBC.JDBCConnection;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.sql.*;

/**
 *
 * @author lengo
 */
@WebServlet(name="Login", urlPatterns={"/Login"})
public class Login extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SignUp</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SignUp at " + request.getContextPath () + "</h1>");
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
//        processRequest(request, response);
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
        String username = request.getParameter("username1");
        String password = request.getParameter("password1");

        boolean isAuthenticated = checkAuthentcation(username, password);

        try (PrintWriter out = response.getWriter()) {
            if (isAuthenticated) {
                response.sendRedirect("index.html");
            } else {
                response.sendRedirect("LoginJSP.jsp");
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
    
    
    private static boolean checkAuthentcation(String username, String password){
        boolean valid = false;
        String sql = "Select * from users where username='" + username +
                                "' and password='" + password + "'";
        
        try (Connection conn = JDBCConnection.getJDBCConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
//                    if (rs.getString("username").equals(username) && rs.getString("password").equals(password))
//                    {
                    valid = true;
//                    }
                    
                }
                rs.close();
                    stmt.close();
                    conn.close();
            }
        } catch (SQLException e) {
//            e.printStackTrace();
        }
        return valid;
    }
}
