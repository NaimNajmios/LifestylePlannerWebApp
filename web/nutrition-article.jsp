<%@ page import="java.net.*, java.io.*, org.json.*, java.util.*" %>
<%
    String apiKey = "4817e6901386184b09de09c2ab51e459";
    String apiUrl = "https://gnews.io/api/v4/search?q=nutrition&lang=en&max=12&token=" + apiKey;
    StringBuilder apiResponse = new StringBuilder();

    // Get sortOrder parameter, default to "desc"
    String sortOrder = request.getParameter("sortOrder");
    if (sortOrder == null || (!sortOrder.equals("asc") && !sortOrder.equals("desc"))) {
        sortOrder = "desc";
    }
    final String sort = sortOrder;

    try {
        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            apiResponse.append(inputLine);
        }
        in.close();

        JSONObject json = new JSONObject(apiResponse.toString());
        JSONArray articles = json.getJSONArray("articles");

        // Convert JSONArray to List<JSONObject> for sorting
        List<JSONObject> articleList = new ArrayList<>();
        for (int i = 0; i < articles.length(); i++) {
            articleList.add(articles.getJSONObject(i));
        }

        // Sort articles by publishedAt date
        articleList.sort(new Comparator<JSONObject>() {
            public int compare(JSONObject a, JSONObject b) {
                String dateA = a.optString("publishedAt", "");
                String dateB = b.optString("publishedAt", "");
                if ("asc".equals(sort)) {
                    return dateA.compareTo(dateB);  // oldest first
                } else {
                    return dateB.compareTo(dateA);  // latest first
                }
            }
        });
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Nutrition Articles</title>
        <!-- Bootstrap + FontAwesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f0fdf4;
            }
            .header {
                background-color: #198754;
                color: white;
                padding: 30px 20px;
                border-radius: 10px;
                margin-bottom: 30px;
                text-align: center;
            }
            .header h1 {
                font-size: 2rem;
            }
            .article-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
            }
            .card-article {
                position: relative;
                overflow: hidden;
                border: none;
                border-radius: 10px;
                transition: transform 0.3s, box-shadow 0.3s;
                background-color: #ffffff;
            }
            .card-article:hover {
                transform: scale(1.03);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            }
            .card-article img {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }
            .card-body {
                padding: 15px;
            }
            .card-title {
                font-size: 1.1rem;
                font-weight: bold;
                color: #198754;
                margin-bottom: 0.5rem;
            }
            .card-title a {
                color: inherit;
                text-decoration: none;
            }
            .card-title a:hover {
                text-decoration: underline;
            }
            .card-desc {
                font-size: 0.9rem;
                color: #555;
                opacity: 0;
                max-height: 0;
                overflow: hidden;
                transition: opacity 0.3s, max-height 0.3s;
            }
            .card-article:hover .card-desc {
                opacity: 1;
                max-height: 200px;
            }
            .sort-btn {
                margin-bottom: 25px;
                text-align: center;
            }
        </style>
    </head>
    <body class="container py-4">
        <div class="header">
            <h1><i class="fas fa-newspaper me-2"></i>Nutrition Articles</h1>
            <p class="mb-0">Stay updated with the latest articles on nutrition and healthy living</p>
        </div>

        <div class="sort-btn">
            <form method="get" action="">
                <input type="hidden" name="sortOrder" value="<%= "asc".equals(sort) ? "desc" : "asc"%>">
                <button type="submit" class="btn btn-success d-flex align-items-center justify-content-center gap-2">
                    Publish Date 
                    <% if ("asc".equals(sort)) {%>
                    <i class="fas fa-arrow-up" title="Ascending (Oldest first)"></i>
                    <% } else {%>
                    <i class="fas fa-arrow-down" title="Descending (Latest first)"></i>
                    <% } %>
                </button>
            </form>
        </div>


        <div class="article-grid">
            <% for (JSONObject article : articleList) {
                    String title = article.getString("title");
                    String description = article.optString("description", "No description available.");
                    String urlLink = article.getString("url");
                    String imageUrl = article.optString("image", "https://via.placeholder.com/300x180?text=No+Image");
                    String publishedAt = article.getString("publishedAt");
            %>
            <div class="card-article">
                <img src="<%= imageUrl%>" alt="Article Image">
                <div class="card-body">
                    <div class="card-title">
                        <a href="<%= urlLink%>" target="_blank"><%= title%></a>
                    </div>
                    <div class="card-desc"><%= description%></div>
                    <small class="text-muted d-block mb-1"><i class="fas fa-clock me-1"></i><%= publishedAt.substring(0, 10)%></small>
                </div>
            </div>
            <% } %>
        </div>

    </body>
</html>

<%
    } catch (Exception e) {
        out.println("<div class='alert alert-danger mt-4'>Error fetching articles: " + e.getMessage() + "</div>");
    }
%>
