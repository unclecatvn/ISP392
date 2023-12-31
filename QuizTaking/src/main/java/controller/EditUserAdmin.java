/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Model.User;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 *
 * @author Acer
 */
public class EditUserAdmin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditUserAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditUserAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String successMess = request.getParameter("successMessage");
        UserDAO dao = new UserDAO();
        User u = dao.getUserById(id);
        int roleId = u.getRoleId();
        String role = "";
        switch (roleId) {
            case 1:
                role = "Admin";
                break;
            case 2:
                role = "Teacher";
                break;
            case 3:
                role = "Student";
                break;
        }
        request.setAttribute("role", role);
        request.setAttribute("u", u);
        if (successMess != null) {
            request.setAttribute("successMessage", successMess);
        }
        request.getRequestDispatcher("edituser.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("user_id"));
        String name = request.getParameter("user_name").trim();
        String email = request.getParameter("email").trim();
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String password = request.getParameter("password").trim();
        String phone = request.getParameter("phone").trim();
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        //int role = Integer.parseInt(request.getParameter("role").trim());
        String role = request.getParameter("role").trim();
        String rollNumber = request.getParameter("rollNumber").trim();

        int roleId = 0;
        switch (role) {
            case "Teacher":
                roleId = 2;
                break;
            case "Student":
                roleId = 3;
                break;
        }

        UserDAO udb = new UserDAO();
        udb.updateUserAdmin(id, name, email, gender, password, phone, status, roleId, rollNumber);

        request.setAttribute("successMessage", "Update successful!");
        response.sendRedirect("edituseradmin?id=" + URLEncoder.encode(String.valueOf(id), "UTF-8") + "&successMessage=" + URLEncoder.encode("Update successful!", "UTF-8"));
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
