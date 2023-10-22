/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class InsertQuiz extends HttpServlet {

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
            out.println("<title>Servlet InsertQuiz</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertQuiz at " + request.getContextPath() + "</h1>");
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
//        String classId = request.getParameter("classId");
//        String courseId = request.getParameter("courseId");
//        request.getRequestDispatcher("/courseDetail?classId=" + classId + "&courseId" + courseId).forward(request, response);
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
//        processRequest(request, response);         
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String attemptTime = request.getParameter("attemptTime");
//        String duration = request.getParameter("duration");
        String durationValue = request.getParameter("durationValue");
        String durationUnit = request.getParameter("durationUnit");
        String status = request.getParameter("status");
        String classId = request.getParameter("classId");
        String courseId = request.getParameter("courseId");

        // Chuyển đổi
        int duration;
        if ("minutes".equals(durationUnit)) {
            duration = Integer.parseInt(durationValue) * 60;
        } else {
            duration = Integer.parseInt(durationValue);
        }

//        System.out.println("durationValue from form: " + durationValue);
//        System.out.println("durationUnit from form: " + durationUnit);
//        System.out.println("Calculated duration: " + duration);

        QuizDAO dao = new QuizDAO();
        dao.insertQuiz(title, description, startDate, endDate,
                Integer.parseInt(attemptTime), duration,
                Integer.parseInt(status), Integer.parseInt(classId),
                Integer.parseInt(courseId));
//        request.getRequestDispatcher("/courseDetail?classId=" + Integer.parseInt(classId) + "&courseId=" + Integer.parseInt(courseId)).forward(request, response);
//        request.setAttribute("message", "Insert successfully");
        response.sendRedirect("courseDetail?classId=" + Integer.parseInt(classId) + "&courseId=" + Integer.parseInt(courseId) + "&message=Insert+successfully");

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
