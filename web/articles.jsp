<%@ page import="java.net.*, java.io.*, org.json.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!-- Articles Section Begin -->
<section class="classes-section spad" style="margin: 50px 0;">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>Latest Articles</h2>
                </div>
            </div>
        </div>

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

        <div class="sort-btn text-center mb-4">
            <form method="get" action="">
                <input type="hidden" name="sortOrder" value="<%= "asc".equals(sort) ? "desc" : "asc"%>">
                <button type="submit" class="primary-btn">
                    <i class="fa-solid fa-arrow-<%= "asc".equals(sort) ? "up" : "down"%>"></i>
                    Sort by Date <%= "asc".equals(sort) ? "(Oldest First)" : "(Latest First)"%>
                </button>
            </form>
        </div>

        <div id="articles-container">
        <div class="row">
            <% for (JSONObject article : articleList) {
                    String title = article.getString("title");
                    String description = article.optString("description", "No description available.");
                    String urlLink = article.getString("url");
                    String imageUrl = article.optString("image", "https://via.placeholder.com/300x180?text=No+Image");
                    String publishedAt = article.getString("publishedAt");
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="single-classes-item">
                    <a href="<%= urlLink%>" target="_blank">
                        <img src="<%= imageUrl%>" alt="<%= title%>" class="article-image" style="cursor:pointer;">
                    </a>
                    <div class="classes-text">
                        <h4><i class="fa-solid fa-newspaper"></i> <a href="<%= urlLink%>" target="_blank" style="color:inherit; text-decoration:none; cursor:pointer;"> <%= title%></a></h4>
                        <p class="article-desc"><%= description%></p>
                        <div class="article-meta">
                            <span><i class="fa-regular fa-calendar"></i> <%= publishedAt.substring(0, 10)%></span>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        </div>

        <%
        } catch (Exception e) {
        %>
        <div class="alert alert-danger mt-4">
            <i class="fa-solid fa-triangle-exclamation"></i> Error fetching articles: <%= e.getMessage()%>
        </div>
        <% }%>
    </div>
</section>
<!-- Articles Section End -->

<style>
/* Multiline truncation for article description */
.article-desc {
    color: #666;
    margin-bottom: 15px;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    transition: all 0.3s;
    cursor: pointer;
}
.single-classes-item:hover .article-desc {
    -webkit-line-clamp: unset;
    max-height: 500px;
    white-space: normal;
    overflow: visible;
    background: #fff;
    z-index: 2;
    position: relative;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}
</style>

<script>
// Removed AJAX search JavaScript
</script>

<jsp:include page="footer.jsp" />