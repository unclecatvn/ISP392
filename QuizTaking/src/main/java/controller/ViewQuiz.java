/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Model.AttemptQuiz;
import Model.Enroll;
import Model.Quiz;
import Model.User;
import dal.AttemptQuizDAO;
import dal.EnrollDAO;
import dal.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class ViewQuiz extends HttpServlet {

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
            out.println("<title>Servlet ViewQuiz</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewQuiz at " + request.getContextPath() + "</h1>");
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
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int classId = Integer.parseInt(request.getParameter("classId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String mess = request.getParameter("mess") == null ? "" : request.getParameter("mess");

        EnrollDAO enrollDAO = new EnrollDAO();
        AttemptQuizDAO attemptQuizDAO = new AttemptQuizDAO();
        QuizDAO quizDAO = new QuizDAO();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
//            response.sendRedirect("home");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        int userId = user.getUserId();
        Enroll enroll = enrollDAO.getEnrollId(userId, classId, courseId);
        if (enroll == null) {
            response.sendRedirect("home");
        } else {
            Quiz quiz = quizDAO.getQuizById(classId, courseId, quizId);
            int enrollId = enroll.getEnrollId();
            ArrayList<AttemptQuiz> listAllAttempt = attemptQuizDAO.getAllAttempt(enrollId, quizId);
            request.setAttribute("enrollId", enrollId);
            request.setAttribute("quizId", quizId);
            request.setAttribute("classId", classId);
            request.setAttribute("courseId", courseId);
            request.setAttribute("quiz", quiz);
            request.setAttribute("listAttempt", listAllAttempt);
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("viewQuiz.jsp").forward(request, response);
        }

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
        int classId = Integer.parseInt(request.getParameter("classId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int enrollId = Integer.parseInt(request.getParameter("enrollId"));
        QuizDAO quizDAO = new QuizDAO();
        AttemptQuizDAO attemptQuizDAO = new AttemptQuizDAO();
        int attemptTime = attemptQuizDAO.getAttemptTime(enrollId, quizId);
        Quiz quiz = quizDAO.getQuizById(classId, courseId, quizId);
        if (attemptTime < 0 || attemptTime >= quiz.getAttemptTime()) {
            response.sendRedirect("viewQuiz?classId=" + classId + "&courseId=" + courseId + "&quizId=" + quizId + "&mess=Max attempt");
        } else {
            attemptQuizDAO.insertAttemptQuiz(enrollId, quizId);
            AttemptQuiz attemptQuiz = attemptQuizDAO.getLastAttempt(enrollId, quizId);
            int attemptId = attemptQuiz.getAttemptId();
            HttpSession sessionQuiz = request.getSession();
            sessionQuiz.setAttribute("attemptId", attemptId);
            response.sendRedirect("doQuiz?classId=" + classId + "&courseId=" + courseId + "&quizId=" + quizId);           
        }
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
