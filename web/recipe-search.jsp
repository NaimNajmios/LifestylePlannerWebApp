<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lifestyle Planner | Recipe Search</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    </head>
    <body>

        <header>
            <h1>Search Recipes</h1>
        </header>

        <section class="search-section">
            <div class="recipe-search-bar">
                <div class="search-title"><i class="fa-solid fa-utensils"></i> Find recipes by name or filter by diet</div>
                <form action="RecipeSearchServlet" method="post" class="recipe-search-form row g-0 align-items-center">
                    <div class="col-md-5 col-12 mb-2 mb-md-0 position-relative">
                        <span class="search-input-icon"><i class="fa fa-search"></i></span>
                        <input type="text" name="recipe" class="form-control with-icon" placeholder="Search healthy recipes..." required>
                    </div>
                    <div class="col-md-4 col-12 mb-2 mb-md-0 position-relative">
                        <span class="search-input-icon" style="left: 18px; top: 50%; transform: translateY(-50%); pointer-events: none; color: #f36100; font-size: 1.1rem;"><i class="fa-solid fa-filter"></i></span>
                        <select name="diet" class="form-control with-icon" style="padding-left: 44px;">
                            <option value="">All Diets</option>
                            <option value="vegetarian">Vegetarian</option>
                            <option value="vegan">Vegan</option>
                            <option value="paleo">Paleo</option>
                            <option value="ketogenic">Ketogenic</option>
                            <option value="gluten free">Gluten Free</option>
                        </select>
                    </div>
                    <div class="col-md-3 col-12">
                        <button type="submit" class="primary-btn w-100 search-btn">
                            <i class="fa-solid fa-magnifying-glass"></i> Search
                        </button>
                    </div>
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
                    <summary><i class="fa-solid fa-bowl-food"></i> <%= r.get("name")%></summary>
                    <div class="recipe-details">
                        <img src="<%= r.get("image")%>" alt="Recipe Image">
                        <p><i class="fa-solid fa-list-ul"></i> <%= r.get("instructions")%></p>
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
