package controller;

import dao.ExerciseDAO;
import model.Exercise;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.client.HttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ExerciseServlet")
public class ExerciseServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ExerciseServlet.class.getName());

    private static final String APP_ID = "a276bdcd";
    private static final String API_KEY = "69e0d68f55a77558a6a04cc8e539e54b";
    private static final String API_URL = "https://trackapi.nutritionix.com/v2/natural/exercise";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String activityName = request.getParameter("activityName");
        String activityDuration = request.getParameter("activityDuration");
        String gender = request.getParameter("gender");
        String weight = request.getParameter("weight");
        String height = request.getParameter("height");
        String age = request.getParameter("age");

        // Combine activity name and duration into a single query string
        String exerciseQuery = activityDuration + " minutes " + activityName;

        LOGGER.info("Received request with parameters: query=" + exerciseQuery
                + ", gender=" + gender + ", weight=" + weight
                + ", height=" + height + ", age=" + age);

        try {
            JSONObject payload = new JSONObject();
            payload.put("query", exerciseQuery);
            payload.put("gender", gender);
            payload.put("weight_kg", Double.parseDouble(weight));
            payload.put("height_cm", Double.parseDouble(height));
            payload.put("age", Integer.parseInt(age));

            HttpClient client = HttpClients.createDefault();
            HttpPost post = new HttpPost(API_URL);

            post.setHeader("Content-Type", "application/json");
            post.setHeader("x-app-id", APP_ID);
            post.setHeader("x-app-key", API_KEY);

            post.setEntity(new StringEntity(payload.toString(), "UTF-8"));

            LOGGER.info("Sending POST request to Nutritionix API...");
            HttpResponse apiResponse = client.execute(post);
            HttpEntity entity = apiResponse.getEntity();
            String resultJson = EntityUtils.toString(entity);
            LOGGER.fine("API response: " + resultJson);

            JSONObject jsonResponse = new JSONObject(resultJson);
            JSONArray exercises = jsonResponse.getJSONArray("exercises");

            StringBuilder resultBuilder = new StringBuilder();
            ExerciseDAO dao = new ExerciseDAO();

            if (exercises.isEmpty()) {
                request.setAttribute("errorMessage", "We don't have the exercise info for now. Please enter or try a different exercise.");
            } else {
                for (int i = 0; i < exercises.length(); i++) {
                    JSONObject ex = exercises.getJSONObject(i);

                    String name = ex.getString("name");
                    double duration = ex.getDouble("duration_min");
                    double calories = ex.getDouble("nf_calories");

                    LOGGER.info("Parsed exercise: " + name + ", duration: " + duration + ", calories: " + calories);

                    resultBuilder.append("Exercise: ").append(name).append("<br>")
                            .append("Duration: ").append(duration).append(" minutes<br>")
                            .append("Calories Burned: ").append(calories).append(" kcal<br><br>");

                    // Save to DB
                    Exercise exercise = new Exercise(name, duration, calories);
                    dao.saveExercise(exercise);
                    LOGGER.fine("Saved exercise to DB: " + exercise);
                }
                request.setAttribute("successMessage", "Exercise(s) added and saved successfully!");
                request.setAttribute("exerciseResult", resultBuilder.toString());
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during exercise processing", e);
            request.setAttribute("errorMessage", "Error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("exercise.jsp?activeTab=input").forward(request, response);
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
