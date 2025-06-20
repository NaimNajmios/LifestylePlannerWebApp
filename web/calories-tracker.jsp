<%@ page import="java.util.List" %>
<%@ page import="Entities.Intake" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!-- Main Content Section Begin -->
<section class="main-content" style="margin: 50px 0;">
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        String activeTab = request.getParameter("activeTab");
        boolean summaryActive = "summary".equals(activeTab);
    %>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2><i class="fa-solid fa-utensils"></i> Food Nutrition Tracker</h2>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link <%= !summaryActive ? "active" : ""%>" id="input-tab" data-toggle="tab" href="#input" role="tab" aria-controls="input" aria-selected="<%= !summaryActive ? "true" : "false"%>">
                            <i class="fa-solid fa-plus-circle"></i> Input
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= summaryActive ? "active" : ""%>" id="summary-tab" data-toggle="tab" href="#summary" role="tab" aria-controls="summary" aria-selected="<%= summaryActive ? "true" : "false"%>">
                            <i class="fa-solid fa-chart-simple"></i> Summary
                        </a>
                    </li>
                </ul>

                <div class="tab-content mt-3" id="myTabContent">
                    <div class="tab-pane fade <%= !summaryActive ? "show active" : ""%>" id="input" role="tabpanel" aria-labelledby="input-tab">
                        <div class="card">
                            <div class="card-header">
                                <h3><i class="fa-solid fa-plus-circle"></i> Add Food</h3>
                            </div>

                            <div class="card-body">
                                <form action="NutritionServlet" method="post">
                                    <div class="form-group">
                                        <label for="mealType"><i class="fa-regular fa-clock"></i> Meal Type:</label>
                                        <select class="form-control" id="mealType" name="mealType">
                                            <option value="Breakfast"><i class="fa-solid fa-mug-hot"></i> Breakfast</option>
                                            <option value="Lunch"><i class="fa-solid fa-burger"></i> Lunch</option>
                                            <option value="High Tea"><i class="fa-solid fa-mug-saucer"></i> High Tea</option>
                                            <option value="Dinner"><i class="fa-solid fa-utensils"></i> Dinner</option>
                                            <option value="Supper"><i class="fa-solid fa-moon"></i> Supper</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="foodName"><i class="fa-solid fa-apple-whole"></i> Food Name:</label>
                                        <input type="text" class="form-control" id="foodName" name="foodName" placeholder="Enter food item (e.g., Grilled Chicken Breast, Brown Rice)">
                                    </div>
                                    <div class="form-group">
                                        <label for="quantity"><i class="fa-solid fa-scale-balanced"></i> Quantity:</label>
                                        <input type="text" class="form-control" id="quantity" name="quantity" placeholder="Specify amount and unit (e.g., 200g, 1 cup, 2 slices)">
                                    </div>
                                    <div class="form-group">
                                        <label for="otherInfo"><i class="fa-solid fa-circle-info"></i> Additional Notes:</label>
                                        <textarea class="form-control" id="otherInfo" name="otherInfo" rows="3" placeholder="Add cooking method, brand, or special preparation details">No additional notes</textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa-solid fa-plus"></i> Add to Summary
                                    </button>
                                </form>
                            </div>
                        </div>

                        <% if (request.getAttribute("intake") != null) {
                                Intake intake = (Intake) request.getAttribute("intake");
                        %>
                        <div class="card mt-4">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fa-solid fa-circle-info"></i> Nutrition Information for Last Added Item</h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h5 class="mb-3"><i class="fa-solid fa-utensils"></i> Food Details</h5>
                                        <table class="table table-striped">
                                            <tbody>
                                                <tr>
                                                    <td><i class="fa-solid fa-apple-whole"></i> Food:</td>
                                                    <td><%= intake.getFoodQuery()%></td>
                                                </tr>
                                                <tr>
                                                    <td><i class="fa-solid fa-scale-balanced"></i> Quantity:</td>
                                                    <td><%= intake.getQuantity()%></td>
                                                </tr>
                                                <tr>
                                                    <td><i class="fa-regular fa-clock"></i> Meal Type:</td>
                                                    <td><%= intake.getMealType()%></td>
                                                </tr>
                                                <% if (intake.getRemark() != null && !intake.getRemark().isEmpty()) {%>
                                                <tr>
                                                    <td><i class="fa-solid fa-circle-info"></i> Additional Notes:</td>
                                                    <td><%= intake.getRemark()%></td>
                                                </tr>
                                                <% }%>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <h5 class="mb-3"><i class="fa-solid fa-chart-pie"></i> Nutritional Values</h5>
                                        <table class="table table-striped">
                                            <tbody>
                                                <tr>
                                                    <td><i class="fa-solid fa-fire"></i> Calories:</td>
                                                    <td><%= intake.getCalories()%> kcal</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="fa-solid fa-drumstick-bite"></i> Protein:</td>
                                                    <td><%= intake.getProtein()%> g</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="fa-solid fa-bread-slice"></i> Carbs:</td>
                                                    <td><%= intake.getCarbs()%> g</td>
                                                </tr>
                                                <tr>
                                                    <td><i class="fa-solid fa-cheese"></i> Fat:</td>
                                                    <td><%= intake.getFat()%> g</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }%>
                    </div>

                    <div class="tab-pane fade <%= summaryActive ? "show active" : ""%>" id="summary" role="tabpanel" aria-labelledby="summary-tab">
                        <div class="card">
                            <div class="card-header">
                                <h3><i class="fa-solid fa-chart-line"></i> Daily Summary</h3>
                            </div>
                            <div class="card-body">
                                <form action="NutritionSummary" method="post" id="summaryForm">
                                    <div class="form-group">
                                        <label for="summaryDate"><i class="fa-regular fa-calendar"></i> Select Date:</label>
                                        <input type="date" class="form-control w-25 d-inline-block" id="summaryDate" name="summaryDate" required
                                            value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                        <button type="submit" class="btn btn-primary ml-2">
                                            <i class="fa-solid fa-rotate"></i> Load Summary
                                        </button>
                                    </div>
                                </form>

                                <div id="summaryTable">
                                    <% if (request.getAttribute("errorMessage") != null) {%>
                                    <div class="alert alert-danger">
                                        <i class="fa-solid fa-triangle-exclamation"></i> <%= request.getAttribute("errorMessage")%>
                                    </div>
                                    <% } else if (request.getAttribute("intakeList") != null && !((List<Intake>) request.getAttribute("intakeList")).isEmpty()) { %>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th><i class="fa-regular fa-clock"></i> Meal Type</th>
                                                    <th><i class="fa-solid fa-apple-whole"></i> Food Name</th>
                                                    <th><i class="fa-solid fa-scale-balanced"></i> Quantity</th>
                                                    <th><i class="fa-solid fa-fire"></i> Calories</th>
                                                    <th><i class="fa-solid fa-drumstick-bite"></i> Protein (g)</th>
                                                    <th><i class="fa-solid fa-bread-slice"></i> Carbs (g)</th>
                                                    <th><i class="fa-solid fa-cheese"></i> Fat (g)</th>
                                                    <th id="sortDate" onclick="sortTableByDate()">
                                                        <i class="fa-regular fa-calendar"></i> Date ▼
                                                    </th>
                                                    <th><i class="fa-solid fa-circle-info"></i> Additional Notes</th>
                                                </tr>
                                            </thead>
                                            <tbody id="summaryBody">
                                                <%
                                                    List<Intake> intakeList = (List<Intake>) request.getAttribute("intakeList");
                                                    for (Intake intake : intakeList) {
                                                %>
                                                <tr>
                                                    <td><i class="fa-solid fa-utensils"></i> <%= intake.getMealType()%></td>
                                                    <td><i class="fa-solid fa-apple-whole"></i> <%= intake.getFoodQuery()%></td>
                                                    <td><i class="fa-solid fa-scale-balanced"></i> <%= intake.getQuantity()%></td>
                                                    <td class="calories"><i class="fa-solid fa-fire"></i> <%= intake.getCalories()%></td>
                                                    <td class="protein"><i class="fa-solid fa-drumstick-bite"></i> <%= intake.getProtein()%></td>
                                                    <td class="carbs"><i class="fa-solid fa-bread-slice"></i> <%= intake.getCarbs()%></td>
                                                    <td class="fat"><i class="fa-solid fa-cheese"></i> <%= intake.getFat()%></td>
                                                    <td><i class="fa-regular fa-calendar"></i> <%= intake.getDateConsumed()%></td>
                                                    <td><i class="fa-solid fa-circle-info"></i> <%= intake.getRemark() != null ? intake.getRemark() : "No additional notes"%></td>
                                                </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                        <div class="total-section card mt-4">
                                            <div class="card-body">
                                                <h5 class="card-title"><i class="fa-solid fa-calculator"></i> Total for the Day:</h5>
                                                <div class="row">
                                                    <div class="col-md-3">
                                                        <div class="card bg-light">
                                                            <div class="card-body text-center">
                                                                <h6><i class="fa-solid fa-fire"></i> Calories</h6>
                                                                <h4 id="totalCalories">0.0</h4>
                                                                <small>kcal</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="card bg-light">
                                                            <div class="card-body text-center">
                                                                <h6><i class="fa-solid fa-drumstick-bite"></i> Protein</h6>
                                                                <h4 id="totalProtein">0.0</h4>
                                                                <small>g</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="card bg-light">
                                                            <div class="card-body text-center">
                                                                <h6><i class="fa-solid fa-bread-slice"></i> Carbs</h6>
                                                                <h4 id="totalCarbs">0.0</h4>
                                                                <small>g</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="card bg-light">
                                                            <div class="card-body text-center">
                                                                <h6><i class="fa-solid fa-cheese"></i> Fat</h6>
                                                                <h4 id="totalFat">0.0</h4>
                                                                <small>g</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% } else { %>
                                        <div class="alert alert-info mt-4">
                                            <i class="fa-solid fa-circle-info"></i> No food entries found for this date. Please select another date or add new entries in the Input tab.
                                        </div>
                                        <% }%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Main Content Section End -->

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Set today's date as default for the summary date input
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0'); // Months are 0-indexed
        const day = String(today.getDate()).padStart(2, '0');
        const formattedDate = `${year}-${month}-${day}`;

        const summaryDateInput = document.getElementById('summaryDate');
        if (summaryDateInput) {
            summaryDateInput.value = formattedDate;
        }

        // Function to calculate totals (existing logic from calories-tracker.jsp)
        function calculateTotals() {
            var table = document.getElementById("summaryBody");
            if (!table) return;

            let totalCalories = 0, totalProtein = 0, totalCarbs = 0, totalFat = 0;

            for (let row of table.rows) {
                let cal = parseFloat(row.querySelector('.calories')?.textContent.replace(/[^\d.]/g, '') || 0);
                let protein = parseFloat(row.querySelector('.protein')?.textContent.replace(/[^\d.]/g, '') || 0);
                let carbs = parseFloat(row.querySelector('.carbs')?.textContent.replace(/[^\d.]/g, '') || 0);
                let fat = parseFloat(row.querySelector('.fat')?.textContent.replace(/[^\d.]/g, '') || 0);

                totalCalories += cal;
                totalProtein += protein;
                totalCarbs += carbs;
                totalFat += fat;
            }

            document.getElementById("totalCalories").textContent = totalCalories.toFixed(1);
            document.getElementById("totalProtein").textContent = totalProtein.toFixed(1);
            document.getElementById("totalCarbs").textContent = totalCarbs.toFixed(1);
            document.getElementById("totalFat").textContent = totalFat.toFixed(1);
        }

        // Initial calculation on page load for calories-tracker
        calculateTotals();
    });
</script>

<jsp:include page="footer.jsp" />