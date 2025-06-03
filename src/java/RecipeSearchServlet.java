import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.logging.Logger;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class RecipeSearchServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(RecipeSearchServlet.class.getName());
    private static final String API_KEY = "fba612d6539347c194d796c076183c15";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Processing GET request for recipe search");
        
        String query = request.getParameter("recipe");
        String diet = request.getParameter("diet");
        LOGGER.info("Search parameters - Query: " + query + ", Diet: " + diet);

        if (query == null || query.trim().isEmpty()) {
            query = "chicken";
            LOGGER.info("Empty query, using default: chicken");
        }

        if (diet == null) {
            diet = "";
            LOGGER.info("No diet specified");
        }

        List<Map<String, String>> recipes = fetchRecipes(query, diet);
        LOGGER.info("Found " + recipes.size() + " recipes for initial search");

        if (recipes.isEmpty() && !diet.isEmpty()) {
            LOGGER.info("No exact matches found, trying diet-only search");
            request.setAttribute("info", "No exact matches found. Showing recommended recipes for your diet.");
            recipes = fetchRecipes("", diet);
        }

        if (recipes.isEmpty()) {
            LOGGER.info("No matches found, showing healthy options");
            request.setAttribute("info", "No matching recipes found. Showing some healthy options instead.");
            recipes = fetchRecipes("healthy", "");
        }

        request.setAttribute("recipes", recipes);
        request.getRequestDispatcher("recipes.jsp").forward(request, response);
    }

    private List<Map<String, String>> fetchRecipes(String query, String diet) {
        List<Map<String, String>> recipes = new ArrayList<>();
        try {
            String encodedQuery = URLEncoder.encode(query, "UTF-8");
            String encodedDiet = URLEncoder.encode(diet, "UTF-8");

            String apiUrl = "https://api.spoonacular.com/recipes/complexSearch?query=" + encodedQuery
                    + (diet.isEmpty() ? "" : "&diet=" + encodedDiet)
                    + "&number=10&addRecipeInformation=true&apiKey=" + API_KEY;
            
            LOGGER.info("Making API request to: " + apiUrl);

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            StringBuilder json = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    json.append(line);
                }
            }

            JSONObject obj = new JSONObject(json.toString());
            JSONArray results = obj.getJSONArray("results");
            LOGGER.info("Received " + results.length() + " results from API");

            for (int i = 0; i < results.length(); i++) {
                JSONObject meal = results.getJSONObject(i);
                Map<String, String> recipe = new HashMap<>();
                recipe.put("name", meal.getString("title"));
                recipe.put("image", meal.getString("image"));
                recipe.put("instructions", meal.has("summary")
                        ? meal.getString("summary").replaceAll("<.*?>", "")
                        : "No instructions provided.");
                recipes.add(recipe);
            }

        } catch (IOException | JSONException e) {
            LOGGER.log(Level.SEVERE, "Error fetching recipes", e);
        }
        return recipes;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Processing POST request");
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Recipe search servlet using Spoonacular API with diet filtering and fallback suggestions";
    }
}
