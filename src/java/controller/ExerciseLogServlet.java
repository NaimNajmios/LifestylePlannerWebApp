package controller;

import dao.ExerciseDAO;
import model.Exercise;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ExerciseLogServlet")
public class ExerciseLogServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ExerciseLogServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String logDate = request.getParameter("logDate");
        ExerciseDAO exerciseDAO = new ExerciseDAO();
        List<Exercise> exerciseList = null;

        LOGGER.info("Received request for exercise log with date: " + logDate);

        try {
            if (logDate != null && !logDate.isEmpty()) {
                exerciseList = exerciseDAO.getExercisesByDate(logDate);
                LOGGER.info("Fetched " + (exerciseList != null ? exerciseList.size() : 0) + " exercises for date: " + logDate);
            } else {
                // Optionally, if no date is selected, you might want to show all or recent exercises
                // For now, if no date is provided, it will show an empty list (or handle in JSP).
                LOGGER.info("No date provided for exercise log, will fetch all exercises.");
                exerciseList = exerciseDAO.getAllExercises(); // Assuming you have such a method
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching exercise log for date: " + logDate, e);
            request.setAttribute("errorMessage", "Error loading exercise log: " + e.getMessage());
        }

        request.setAttribute("exerciseList", exerciseList);
        request.getRequestDispatcher("exercise.jsp?activeTab=log").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
} 