/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Model.Quiz;
import dal.AnswerDAO;
import dal.QuestionDAO;
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
public class EditQuiz extends HttpServlet {
   
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
            out.println("<title>Servlet EditQuiz</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditQuiz at " + request.getContextPath () + "</h1>");
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
        String courseId = request.getParameter("courseId");
        String quizId = request.getParameter("quizId");
        String mess = request.getParameter("mess") == null ? "":request.getParameter("mess"); 
        String in = request.getParameter("in") == null ? "":request.getParameter("in");
        
        
        QuizDAO dao = new QuizDAO();
        QuestionDAO questionDAO = new QuestionDAO();
        AnswerDAO answerDAO = new AnswerDAO();
        
        Quiz quiz = dao.getQuizById(classId, Integer.parseInt(courseId), Integer.parseInt(quizId));
        
        int totalQuestion = quiz.getTotalQuestion();
        request.setAttribute("totalQuestion", totalQuestion);
        request.setAttribute("mess", mess);
        request.setAttribute("in", in);
        request.setAttribute("q", quiz);
        request.setAttribute("questionList", questionDAO.getAllQuestionByQuizId(Integer.parseInt(quizId)));
        request.setAttribute("answerList", answerDAO.getAllAnswerByQuizId(Integer.parseInt(quizId)));
        request.getRequestDispatcher("editQuiz.jsp").forward(request, response);
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
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        int attemptTime = Integer.parseInt(request.getParameter("attemptTime"));
//        int duration = Integer.parseInt(request.getParameter("duration"));
        String durationValue = request.getParameter("durationValue");
        String durationUnit = request.getParameter("durationUnit");
        int status = Integer.parseInt(request.getParameter("status"));
        String classId = request.getParameter("classId");
        String courseId = request.getParameter("courseId");
        
        // Chuyển đổi
        int duration;
        if ("minutes".equals(durationUnit)) {
            duration = Integer.parseInt(durationValue) * 60;
        } else {
            duration = Integer.parseInt(durationValue);
        }

        QuizDAO dao = new QuizDAO();
        dao.updateQuiz(quizId, title, description, startDate, endDate, attemptTime, duration, status);
        response.sendRedirect("editQuiz?classId=" + Integer.parseInt(classId) + "&courseId=" + Integer.parseInt(courseId) + "&quizId=" + quizId + "&mess=Update+successfully");
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