<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lifestyle Planner | Recipe Search</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>

        <header>
            <h1>Search Recipes</h1>
        </header>

        <section class="search-section">
            <div class="search-form-container">
                <form action="RecipeSearchServlet" method="post">
                    <input type="text" name="recipe" placeholder="Enter Healthy Food Recipe" required>
                    <select name="diet">
                        <option value="">-- Select Diet (Optional) --</option>
                        <option value="vegetarian">Vegetarian</option>
                        <option value="vegan">Vegan</option>
                        <option value="paleo">Paleo</option>
                        <option value="ketogenic">Ketogenic</option>
                        <option value="gluten free">Gluten Free</option>
                    </select>
                    <button type="submit">Search</button>
                </form>
            </div>
        </section>

        <section class="results-section">
            <div class="results-container">

                <% String info = (String) request.getAttribute("info"); %>
                <% if (info != null) {%>
                <div class="info-message">
                    <p><%= info%></p>
                </div>
                <% } %>

                <%
                    List<Map<String, String>> recipes = (List<Map<String, String>>) request.getAttribute("recipes");
                    if (recipes != null && !recipes.isEmpty()) {
                        for (int i = 0; i < recipes.size(); i++) {
                            Map<String, String> r = recipes.get(i);
                %>
                <details class="recipe-dropdown">
                    <summary><%= r.get("name")%></summary>
                    <div class="recipe-details">
                        <img src="<%= r.get("image")%>" alt="Recipe Image">
                        <p><%= r.get("instructions")%></p>
                    </div>
                </details>
                <%
                    }
                } else {
                %>
                <section class="no-Result">
                    <div class="no-results">
                        <p>😕 No recipes found. Try another keyword or change the diet option!</p>
                    </div>
                </section>
                <%
                    }
                %>

            </div>
        </section>

        <footer>
            <p>&copy; 2025 Lifestyle Planner</p>
        </footer>

    </body>
</html>
