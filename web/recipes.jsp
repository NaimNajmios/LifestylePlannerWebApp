<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.logging.Logger" %>
<jsp:include page="header.jsp" />

<%
    Logger logger = Logger.getLogger("recipes.jsp");
    logger.info("Loading recipes page");
%>

<!-- Add CSS link -->
<link rel="stylesheet" href="css/recipes.css">

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
                    <div class="search-title"><i class="fa-solid fa-utensils"></i> Find recipes by name or filter by diet</div>
                    <form action="RecipeSearchServlet" method="post" class="recipe-search-form">
                        <div class="row">
                            <div class="col-md-6 position-relative">
                                <span class="search-input-icon"><i class="fa fa-search"></i></span>
                                <input type="text" name="recipe" class="form-control with-icon" placeholder="e.g. Chicken Caesar Salad, Vegan Pasta, High Protein Breakfast..." required style="padding-left: 44px;">
                            </div>
                            <div class="col-md-4 position-relative">
                                <span class="search-input-icon" style="left: 18px; top: 50%; transform: translateY(-50%); pointer-events: none; color: #f36100; font-size: 1.1rem;"><i class="fa-solid fa-filter"></i></span>
                                <select name="diet" class="form-control with-icon" style="padding-left: 44px;">
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
                                    <i class="fa-solid fa-magnifying-glass"></i> Search
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
                    logger.info("Displaying info message: " + info);
            %>
            <div class="col-lg-12">
                <div class="alert alert-info">
                    <i class="fa-solid fa-circle-info"></i> <%= info%>
                </div>
            </div>
            <% } %>

            <%
                List<Map<String, String>> recipes = (List<Map<String, String>>) request.getAttribute("recipes");
                if (recipes != null && !recipes.isEmpty()) {
                    logger.info("Displaying " + recipes.size() + " recipes");
                    for (Map<String, String> recipe : recipes) {
                        logger.fine("Rendering recipe: " + recipe.get("name"));
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="single-classes-item">
                    <img src="<%= recipe.get("image")%>" alt="<%= recipe.get("name")%>" class="article-image">
                    <div class="classes-text">
                        <div class="recipe-meta">
                            <span><i class="fa-regular fa-clock"></i> Recipe</span>
                            <span><i class="fa-solid fa-utensils"></i> <%= recipe.get("diet") != null ? recipe.get("diet") : "All Diets"%></span>
                        </div>
                        <h4><i class="fa-solid fa-bowl-food"></i> <%= recipe.get("name")%></h4>
                        <p><%= recipe.get("instructions").length() > 150 ? recipe.get("instructions").substring(0, 150) + "..." : recipe.get("instructions")%></p>
                        <div class="recipe-tags">
                            <% if (recipe.get("diet") != null && !recipe.get("diet").isEmpty()) {%>
                            <span class="tag"><%= recipe.get("diet")%></span>
                            <% }%>
                        </div>
                        <a href="#" class="primary-btn" data-bs-toggle="modal" data-bs-target="#recipeModal<%= recipe.get("name").hashCode()%>">Information</a>
                    </div>
                </div>
            </div>

            <!-- Recipe Modal -->
            <div class="modal fade" id="recipeModal<%= recipe.get("name").hashCode()%>" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-bowl-food"></i> <%= recipe.get("name")%></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="recipe-details">
                                <div class="recipe-header">
                                    <img src="<%= recipe.get("image")%>" alt="<%= recipe.get("name")%>" class="recipe-image">
                                    <div class="recipe-info">
                                        <div class="recipe-meta">
                                            <span><i class="fa-regular fa-clock"></i> Recipe</span>
                                            <span><i class="fa-solid fa-utensils"></i> <%= recipe.get("diet") != null ? recipe.get("diet") : "All Diets"%></span>
                                        </div>
                                        <div class="recipe-tags">
                                            <% if (recipe.get("diet") != null && !recipe.get("diet").isEmpty()) {%>
                                            <span class="tag"><%= recipe.get("diet")%></span>
                                            <% } %>
                                        </div>
                                        <div class="recipe-buttons mt-3">
                                        <% if (recipe.get("sourceUrl") != null && !recipe.get("sourceUrl").isEmpty()) {%>
                                            <a href="<%= recipe.get("sourceUrl")%>" class="primary-btn" target="_blank">View Recipe</a>
                                        <% }%>
                                        </div>
                                    </div>
                                </div>
                                <div class="recipe-content">
                                    <div class="instructions">
                                        <h4><i class="fa-solid fa-list-check"></i> Instructions</h4>
                                        <p><%= recipe.get("instructions")%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% }
            } else if (recipes == null) {
                logger.info("No recipes found, showing featured recipes section");
            %>
        </div>
        <% }%>
    </div>
</div>
</section>
<!-- Recipes Section End -->

<jsp:include page="footer.jsp" />

<!-- Initialize Bootstrap Modal -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Initialize all modals
        var modals = document.querySelectorAll('.modal');
        modals.forEach(function (modal) {
            new bootstrap.Modal(modal);
        });

        // Add click event listeners to all "View Recipe" buttons
        var viewButtons = document.querySelectorAll('[data-bs-toggle="modal"]');
        viewButtons.forEach(function (button) {
            button.addEventListener('click', function (e) {
                e.preventDefault();
                var targetModal = document.querySelector(this.getAttribute('data-bs-target'));
                var modal = new bootstrap.Modal(targetModal);
                modal.show();
            });
        });
    });
</script>