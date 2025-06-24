package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/articles")
public class ArticlesServlet extends HttpServlet {
    private static final String API_KEY = "4817e6901386184b09de09c2ab51e459";
    // Multiple keywords related to healthy lifestyle
    private static final String KEYWORDS = "nutrition OR fitness OR wellness OR exercise OR health OR diet OR mindfulness OR workout OR healthy eating OR wellbeing";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, javax.servlet.ServletException {
        List<Map<String, Object>> articleList = new ArrayList<>();
        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null || (!sortOrder.equals("asc") && !sortOrder.equals("desc"))) {
            sortOrder = "desc";
        }

        String apiUrl;
        try {
            apiUrl = "https://gnews.io/api/v4/search?q=" + java.net.URLEncoder.encode(KEYWORDS, "UTF-8") + "&lang=en&max=12&token=" + API_KEY;
        } catch (java.io.UnsupportedEncodingException e) {
            apiUrl = "https://gnews.io/api/v4/search?q=nutrition&lang=en&max=12&token=" + API_KEY;
        }

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder apiResponse = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                apiResponse.append(inputLine);
            }
            in.close();

            JSONObject json = new JSONObject(apiResponse.toString());
            JSONArray articles = json.getJSONArray("articles");

            for (int i = 0; i < articles.length(); i++) {
                JSONObject obj = articles.getJSONObject(i);
                Map<String, Object> map = new HashMap<>();
                for (String key : obj.keySet()) {
                    map.put(key, obj.get(key));
                }
                articleList.add(map);
            }

            // Removed sorting logic

        } catch (Exception e) {
            request.setAttribute("error", "Error fetching articles: " + e.getMessage());
        }

        request.setAttribute("articles", articleList);
        request.setAttribute("sortOrder", sortOrder);
        request.getRequestDispatcher("/articles.jsp").forward(request, response);
    }
} 