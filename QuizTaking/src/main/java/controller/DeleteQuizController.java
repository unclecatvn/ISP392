/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Model.Question;
import dal.AnswerDAO;
import dal.QuestionDAO;
import dal.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author HoaiNam
 */
public class DeleteQuizController extends HttpServlet {
   
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
            out.println("<title>Servlet DeleteQuizController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteQuizController at " + request.getContextPath () + "</h1>");
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
        String classId = request.getParameter("classId");
        String courseId = request.getParameter("courseId");
        request.getRequestDispatcher("/courseDetail?classId=" + classId + "&courseId" + courseId).forward(request, response);
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
        String courseId = request.getParameter("courseId");
        String classId = request.getParameter("classId");
        String quizId = request.getParameter("quizId");
//        int totalQuestion = Integer.parseInt(request.getParameter("totalQuestion"));
        
        QuizDAO quizDAO = new QuizDAO();
        AnswerDAO answerDAO = new AnswerDAO();
        QuestionDAO questionDAO = new QuestionDAO();
        
        ArrayList<Question> listQuestion = questionDAO.getAllQuestionByQuizId(Integer.parseInt(quizId));
        for (Question question : listQuestion) {
            answerDAO.deleteAllAnswerByQuestionId(question.getQuestionId());
            
        }
        questionDAO.deleteQuestionByQuizId(Integer.parseInt(quizId));              
        quizDAO.deleteQuizByID(Integer.parseInt(classId),Integer.parseInt(courseId),Integer.parseInt(quizId));
        response.sendRedirect("courseDetail?classId=" + Integer.parseInt(classId) + "&courseId=" + Integer.parseInt(courseId) + "&message=Delete+successfully");
        
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
