/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Model.Question;
import dal.AnswerDAO;
import dal.QuestionDAO;
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
public class InsertQuestion extends HttpServlet {

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
            out.println("<title>Servlet InsertQuestion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertQuestion at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String answerCount = request.getParameter("answerCount") == null ? "0" : request.getParameter("answerCount");
        String quizId = request.getParameter("quizId");
        String classId = request.getParameter("classId");
        String courseId = request.getParameter("courseId");
        String question = request.getParameter("question");
        String questionType = request.getParameter("questionType") ;
        String checkboxCount = request.getParameter("checkboxCount") == null ? "0" : request.getParameter("checkboxCount");
        System.out.println(checkboxCount);
        QuestionDAO dao = new QuestionDAO();
        dao.updateTotalQuestion(Integer.parseInt(quizId),"+");
        dao.insertQuestion(question, questionType, Integer.parseInt(quizId), Integer.parseInt(checkboxCount));
        Question questionId = dao.getLastQuestionId(Integer.parseInt(quizId));
        int quesId = questionId.getQuestionId();

        AnswerDAO answerDAO = new AnswerDAO();
        if (!(Integer.parseInt(answerCount) == 0 || answerCount.equals("0"))) {
            for (int i = 1; i <= Integer.parseInt(answerCount); i++) {
                String answer = request.getParameter("answer" + Integer.toString(i)).trim();
                String answerCheckBox = request.getParameter("answerCheckBox" + Integer.toString(i)) == null ? "False" : "True";
                String explain = request.getParameter("explain") == null ? "" : request.getParameter("explain").trim();
                answerDAO.insertAnswer(answer, answerCheckBox, explain, quesId);
            }
        }
        response.sendRedirect("editQuiz?classId=" + Integer.parseInt(classId) + "&courseId=" + Integer.parseInt(courseId) + "&quizId=" + quizId + "&in=Insert+successfully");
//        System.out.println(answerCount);
//        System.out.println(quizId);
//        System.out.println(question);
//        System.out.println(questionType);
//        System.out.println("haaa");

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
