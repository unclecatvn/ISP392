/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Model.Enroll;
import Model.User;
import com.google.gson.Gson;
import dal.ClassesDAO;
import dal.CourseDAO;
import dal.EnrollDAO;
import dal.UserDAO;
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
 * @author HoaiNam
 */
public class HomeController extends HttpServlet {

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
            out.println("<title>Servlet HomeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeController at " + request.getContextPath() + "</h1>");
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
        //login thanh cong-->chuyen den home.jsp
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        EnrollDAO enroll = new EnrollDAO();
        CourseDAO course = new CourseDAO();
        UserDAO udao = new UserDAO();
        ClassesDAO classes = new ClassesDAO();
        if (user == null) {
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        int userId = user.getUserId();
        int roleId = user.getRoleId();
        if (roleId == 3) {
            request.setAttribute("list", enroll.getAllCourseByUser(userId));
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else if (roleId == 2) {
            request.setAttribute("list", enroll.getAllCourseByTeacher(userId));
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else if (roleId == 1) {
            request.setAttribute("list", course.getAllCourse());
            request.setAttribute("totalStudent", udao.countUserByRoleId(3));
            request.setAttribute("totalTeacher", udao.countUserByRoleId(2));
            request.setAttribute("totalCourse", course.countCourse());
            request.setAttribute("totalClass", classes.countClass());
            request.setAttribute("listClass", enroll.getAllCourse());
            request.getRequestDispatcher("home.jsp").forward(request, response);
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
        String courseId = request.getParameter("courseId");
        EnrollDAO dao = new EnrollDAO();
        ArrayList<Enroll> classList = dao.getAllClassByCourseId(Integer.parseInt(courseId));
        Gson gson = new Gson();
        String json = gson.toJson(classList);
        response.setContentType("application/json");
        response.getWriter().write(json);
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
