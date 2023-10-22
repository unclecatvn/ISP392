/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Model.Answer;
import Model.AttemptQuiz;
import Model.Enroll;
import Model.Question;
import Model.Quiz;
import Model.User;
import dal.AnswerDAO;
import dal.AttemptQuizDAO;
import dal.EnrollDAO;
import dal.QuestionDAO;
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
public class DoQuiz extends HttpServlet {

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
            out.println("<title>Servlet DoQuiz</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoQuiz at " + request.getContextPath() + "</h1>");
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

        HttpSession sessionQuiz = request.getSession();
//        Integer attemptId = (Integer) sessionQuiz.getAttribute("attemptId");
        if (sessionQuiz.getAttribute("attemptId") == null) {
            response.sendRedirect("home");
            System.out.println("Nothing");
        } else {
            QuestionDAO questionDAO = new QuestionDAO();
            AnswerDAO answerDAO = new AnswerDAO();
            QuizDAO quizDAO = new QuizDAO();
            int quizId = Integer.parseInt(request.getParameter("quizId"));
            int classId = Integer.parseInt(request.getParameter("classId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            ArrayList<Question> listQuestion = questionDAO.getAllQuestionByQuizId(quizId);
            ArrayList<Answer> listAnswer = answerDAO.getAllAnswerByQuizId(quizId);
            Quiz quiz = quizDAO.getQuizById(classId, courseId, quizId);
            request.setAttribute("quiz", quiz);
            request.setAttribute("listQuestion", listQuestion);
            request.setAttribute("listAnswer", listAnswer);
            request.getRequestDispatcher("doQuiz.jsp").forward(request, response);
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
//        processRequest(request, response);
        doGet(request, response);

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
