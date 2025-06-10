import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ExerciseData {

    private static final Logger LOGGER = Logger.getLogger(ExerciseData.class.getName());
    private static final String API_KEY = "12LoC/on4mR1LXeRKGeioQ==9qnvvS3427Ws7IcJ";
    private static final String API_URL = "https://api.calorieninjas.com/v1/exercises?name="; // Updated to use 'name'

    private String query;
    private double caloriesBurned;

    public ExerciseData(String query) {
        if (query == null || query.trim().isEmpty()) {
            throw new IllegalArgumentException("Exercise query cannot be null or empty");
        }
        this.query = query.trim();
    }

    public double getCaloriesBurned() {
        if (API_KEY == null || API_KEY.isEmpty()) {
            LOGGER.severe("Calorieninjas API Key is not set.");
            return 0;
        }

        String encodedQuery;
        try {
            encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8.name());
        } catch (java.io.UnsupportedEncodingException e) {
            LOGGER.log(Level.SEVERE, "UTF-8 encoding error for query: {0}", query);
            return 0;
        }

        String url = API_URL + encodedQuery;
        LOGGER.log(Level.INFO, "Fetching calories for query: {0}, URL: {1}", new Object[]{query, url});

        this.caloriesBurned = 0;

        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(url);
            request.setHeader("X-Api-Key", API_KEY);

            try (CloseableHttpResponse response = httpClient.execute(request)) {
                int statusCode = response.getStatusLine().getStatusCode();
                String responseBody = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);
                LOGGER.info("API raw response: " + responseBody);

                if (statusCode != 200) {
                    LOGGER.log(Level.SEVERE, "HTTP Error: Status {0}, Query: {1}, Response: {2}",
                            new Object[]{statusCode, query, responseBody});
                    return 0;
                }

                JSONObject json = new JSONObject(responseBody);
                JSONArray items = json.getJSONArray("items");

                if (items.length() == 0) {
                    LOGGER.warning("No exercise data found for query: " + query);
                    return 0;
                }

                JSONObject exerciseData = items.getJSONObject(0);
                double caloriesPerHour = exerciseData.optDouble("calories_per_hour", 0);
                if (caloriesPerHour > 0) {
                    this.caloriesBurned = (caloriesPerHour / 60.0) * 30.0; // 30 minutes
                    LOGGER.log(Level.INFO, "Calories for 30 min of {0}: {1} kcal", new Object[]{query, this.caloriesBurned});
                } else {
                    LOGGER.warning("No valid calorie data in response for query: " + query);
                }
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "IOException during API call for query: {0}", query);
        } catch (JSONException e) {
            LOGGER.log(Level.SEVERE, "JSONException parsing API response for query: {0}", query);
        }

        return caloriesBurned;
    }

}
