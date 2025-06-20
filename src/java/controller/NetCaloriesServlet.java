package controller;

import dao.ExerciseDAO;
import dao.IntakeDAO;
import model.Exercise;
import Entities.Intake;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/NetCaloriesServlet")
public class NetCaloriesServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(NetCaloriesServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String balanceDate = request.getParameter("balanceDate");
        ExerciseDAO exerciseDAO = new ExerciseDAO();
        IntakeDAO intakeDAO = new IntakeDAO();

        Double totalIntakeCalories = 0.0;
        Double totalExerciseCalories = 0.0;
        List<Intake> intakeList = null;
        List<Exercise> exerciseList = null;

        LOGGER.info("Received request for net calories with date: " + balanceDate);

        try {
            if (balanceDate != null && !balanceDate.isEmpty()) {
                totalIntakeCalories = intakeDAO.getTotalCaloriesByDate(balanceDate);
                totalExerciseCalories = exerciseDAO.getTotalCaloriesByDate(balanceDate);
                intakeList = intakeDAO.getDailyIntakes(balanceDate);
                exerciseList = exerciseDAO.getExercisesByDate(balanceDate);
                LOGGER.info(String.format("Fetched for date %s: Intake=%.1f kcal, Exercise=%.1f kcal, IntakeList=%d, ExerciseList=%d",
                        balanceDate, totalIntakeCalories, totalExerciseCalories,
                        intakeList != null ? intakeList.size() : 0,
                        exerciseList != null ? exerciseList.size() : 0));
            } else {
                request.setAttribute("errorMessage", "Please select a date to view the balance.");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching net calories for date: " + balanceDate, e);
            request.setAttribute("errorMessage", "Error loading calorie balance: " + e.getMessage());
        }

        request.setAttribute("totalIntakeCalories", totalIntakeCalories);
        request.setAttribute("totalExerciseCalories", totalExerciseCalories);
        request.setAttribute("intakeList", intakeList);
        request.setAttribute("exerciseList", exerciseList);
        request.getRequestDispatcher("net-calories.jsp").forward(request, response);
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