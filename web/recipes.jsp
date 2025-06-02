<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<jsp:include page="header.jsp" />

<!-- Recipes Section Begin -->
<section class="classes-section spad" style="margin: 50px 0;">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>Healthy Recipes</h2>
                </div>
            </div>
        </div>

        <!-- Recipe Search Form -->
        <div class="row mb-5">
            <div class="col-lg-12">
                <div class="search-form-container">
                    <form action="RecipeSearchServlet" method="post" class="recipe-search-form">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" name="recipe" class="form-control" placeholder="Enter Healthy Food Recipe" required>
                            </div>
                            <div class="col-md-4">
                                <select name="diet" class="form-control">
                                    <option value="">-- Select Diet (Optional) --</option>
                                    <option value="vegetarian">Vegetarian</option>
                                    <option value="vegan">Vegan</option>
                                    <option value="paleo">Paleo</option>
                                    <option value="ketogenic">Ketogenic</option>
                                    <option value="gluten free">Gluten Free</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="primary-btn w-100">
                                    <i class="fa-solid fa-search"></i> Search
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Search Results or Featured Recipes -->
        <div class="row">
            <%
                String info = (String) request.getAttribute("info");
                if (info != null) {
            %>
            <div class="col-lg-12">
                <div class="alert alert-info">
                    <i class="fa-solid fa-circle-info"></i> <%= info %>
                </div>
            </div>
            <% } %>

            <%
                List<Map<String, String>> recipes = (List<Map<String, String>>) request.getAttribute("recipes");
                if (recipes != null && !recipes.isEmpty()) {
                    for (Map<String, String> recipe : recipes) {
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="single-classes-item">
                    <img src="<%= recipe.get("image") %>" alt="<%= recipe.get("name") %>" class="article-image">
                    <div class="classes-text">
                        <div class="recipe-meta">
                            <span><i class="fa-regular fa-clock"></i> Recipe</span>
                            <span><i class="fa-solid fa-utensils"></i> <%= recipe.get("diet") != null ? recipe.get("diet") : "All Diets" %></span>
                        </div>
                        <h4><i class="fa-solid fa-bowl-food"></i> <%= recipe.get("name") %></h4>
                        <p><%= recipe.get("instructions").length() > 150 ? recipe.get("instructions").substring(0, 150) + "..." : recipe.get("instructions") %></p>
                        <div class="recipe-tags">
                            <% if (recipe.get("diet") != null && !recipe.get("diet").isEmpty()) { %>
                            <span class="tag"><%= recipe.get("diet") %></span>
                            <% } %>
                        </div>
                        <a href="#" class="primary-btn" data-bs-toggle="modal" data-bs-target="#recipeModal<%= recipe.get("name").hashCode() %>">View Recipe</a>
                    </div>
                </div>
            </div>

            <!-- Recipe Modal -->
            <div class="modal fade" id="recipeModal<%= recipe.get("name").hashCode() %>" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><%= recipe.get("name") %></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="recipe-details">
                                <div class="recipe-header">
                                    <img src="<%= recipe.get("image") %>" alt="<%= recipe.get("name") %>" class="recipe-image">
                                    <div class="recipe-info">
                                        <div class="recipe-meta">
                                            <span><i class="fa-solid fa-utensils"></i> Diet: <%= recipe.get("diet") != null ? recipe.get("diet") : "All Diets" %></span>
                                        </div>
                                        <div class="recipe-tags">
                                            <% if (recipe.get("diet") != null && !recipe.get("diet").isEmpty()) { %>
                                            <span class="tag"><%= recipe.get("diet") %></span>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                                <div class="recipe-content">
                                    <div class="instructions">
                                        <h4>Instructions</h4>
                                        <p><%= recipe.get("instructions") %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% }
            } else if (recipes == null) { // Show featured recipes when no search is performed
            %>
            </div>
            <% } %>
        </div>
    </div>
</section>
<!-- Recipes Section End -->

<style>
.recipe-meta {
    display: flex;
    gap: 15px;
    margin-bottom: 10px;
    color: #666;
    font-size: 0.9em;
}

.recipe-tags {
    margin: 10px 0;
}

.tag {
    display: inline-block;
    padding: 4px 10px;
    background: #f8f9fa;
    border-radius: 15px;
    font-size: 0.8em;
    color: #666;
    margin-right: 5px;
}

.recipe-details {
    padding: 20px;
}

.recipe-header {
    margin-bottom: 30px;
}

.recipe-image {
    width: 100%;
    height: 300px;
    object-fit: cover;
    border-radius: 10px;
    margin-bottom: 20px;
}

.recipe-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.recipe-content {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 30px;
}

.ingredients ul {
    list-style: none;
    padding: 0;
}

.ingredients li {
    padding: 8px 0;
    border-bottom: 1px solid #eee;
}

.instructions ol {
    padding-left: 20px;
}

.instructions li {
    margin-bottom: 15px;
    line-height: 1.6;
}

.recipe-search-form {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 30px;
}

.recipe-search-form .form-control {
    height: 45px;
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 10px 15px;
}

.recipe-search-form .form-control:focus {
    border-color: #f36100;
    box-shadow: none;
}

.alert {
    border-radius: 10px;
    padding: 15px 20px;
    margin-bottom: 20px;
    border: none;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.alert-info {
    background-color: #e8f4f8;
    color: #0c5460;
}

.alert-info i {
    margin-right: 8px;
}

@media (max-width: 768px) {
    .recipe-content {
        grid-template-columns: 1fr;
    }
    
    .recipe-info {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .recipe-search-form .row {
        gap: 15px;
    }
}
</style>

<jsp:include page="footer.jsp" /> 