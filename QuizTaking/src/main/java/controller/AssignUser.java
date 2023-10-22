/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Model.Enroll;
import Model.User;
import dal.ClassesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.ArrayList;

/**
 *
 * @author Acer
 */
public class AssignUser extends HttpServlet {
   
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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AssignUser</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AssignUser at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        int classId = Integer.parseInt(request.getParameter("classId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        ClassesDAO cdb = new ClassesDAO();
        ArrayList<User> listS = cdb.listAssignStudent();
        ArrayList<User> listT = cdb.listAssignTeacher();
        ArrayList<Enroll> list = cdb.studentInClass(classId, courseId);
        ArrayList<Enroll> listSC = cdb.getStudentIdByCourse(courseId);       
        int teacherId = cdb.getTeacherIdOfClass(classId, courseId);
        User u = cdb.getUserById(teacherId);
        request.setAttribute("teacherInfo", u);
        request.setAttribute("listS", listS);
        request.setAttribute("listT", listT);
        request.setAttribute("classId", classId);
        request.setAttribute("courseId", courseId);
        request.setAttribute("list", list);
        request.setAttribute("listSC", listSC);
        request.getRequestDispatcher("assignUser.jsp").forward(request, response);

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
        
            int userId = Integer.parseInt(request.getParameter("teacher"));
            int classId = Integer.parseInt(request.getParameter("classId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            ClassesDAO cdb = new ClassesDAO();
            cdb.assignTeacher(userId, classId, courseId);
            response.sendRedirect("assignuser?courseId=" + URLEncoder.encode(String.valueOf(courseId), "UTF-8") + "&classId=" + URLEncoder.encode(String.valueOf(classId), "UTF-8"));
        

        

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
