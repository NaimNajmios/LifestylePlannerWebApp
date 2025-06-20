<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,java.io.*" %>
<%
    String gender = "";
    String weight = "";
    String height = "";
    try {
        String filePath = application.getRealPath("/") + "user_profile.xml";
        File xmlFile = new File(filePath);
        if (xmlFile.exists()) {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlFile);
            doc.getDocumentElement().normalize();
            gender = doc.getElementsByTagName("gender").item(0).getTextContent();
            weight = doc.getElementsByTagName("weight").item(0).getTextContent();
            height = doc.getElementsByTagName("height").item(0).getTextContent();
        }
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error reading profile. Please <a href='profile.jsp'>set your profile</a>.</div>");
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!-- Main Content Section Begin -->
<section class="main-content" style="margin: 50px 0;">
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        String activeTab = request.getParameter("activeTab");
        boolean logActive = "log".equals(activeTab);
    %>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2><i class="fa-solid fa-dumbbell"></i> Exercise Tracker</h2>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-md-5 mb-4">
                <div class="card shadow mb-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0"><i class="fa-solid fa-id-card"></i> Your Profile</h3>
                    </div>
                    <div class="card-body p-3">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span><i class="fa-solid fa-venus-mars"></i> Gender</span>
                                <span class="fw-bold"><%= gender %></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span><i class="fa-solid fa-weight-scale"></i> Weight</span>
                                <span class="fw-bold"><%= weight %> kg</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span><i class="fa-solid fa-ruler-vertical"></i> Height</span>
                                <span class="fw-bold"><%= height %> cm</span>
                            </li>
                        </ul>
                        <a href="profile.jsp" class="btn btn-secondary mt-3 w-100">Edit Profile</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-8 col-md-7">
                <div class="card shadow mb-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0"><i class="fa-solid fa-plus-circle"></i> Track Your Exercise</h3>
                    </div>
                    <div class="card-body">
                        <form action="ExerciseServlet" method="post">
                            <div class="form-group mb-3">
                                <label for="activityName"><i class="fa-solid fa-person-running"></i> Activity Name:</label>
                                <input type="text" name="activityName" id="activityName" class="form-control" placeholder="e.g. running, weightlifting, swimming" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="activityDuration"><i class="fa-solid fa-hourglass-half"></i> Duration (minutes):</label>
                                <input type="number" name="activityDuration" id="activityDuration" step="1" class="form-control" placeholder="e.g. 30, 60" required>
                            </div>
                            <input type="hidden" name="gender" value="<%= gender %>" />
                            <input type="hidden" name="weight" value="<%= weight %>" />
                            <input type="hidden" name="height" value="<%= height %>" />
                            <div class="form-group mb-4">
                                <label for="age"><i class="fa-solid fa-user"></i> Age:</label>
                                <input type="number" name="age" id="age" class="form-control" placeholder="e.g. 30" required>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-right-to-bracket"></i> Submit Exercise
                            </button>
                        </form>
                    </div>
                </div>
                <% if (request.getAttribute("exerciseResult") != null) { %>
                <div class="alert alert-info mt-4">
                    <i class="fa-solid fa-circle-info"></i> API Result: <%= request.getAttribute("exerciseResult")%>
                </div>
                <% } %>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="card mt-4">
                    <div class="card-header">
                        <h3><i class="fa-solid fa-clipboard-list"></i> Exercise Log</h3>
                    </div>
                    <div class="card-body">
                        <form action="ExerciseLogServlet" method="post" id="exerciseLogForm">
                            <div class="form-group mb-3">
                                <label for="logDate"><i class="fa-regular fa-calendar"></i> Select Date:</label>
                                <input type="date" class="form-control w-25 d-inline-block" id="logDate" name="logDate" required>
                                <button type="submit" class="btn btn-primary ms-2">
                                    <i class="fa-solid fa-rotate"></i> Load Log
                                </button>
                            </div>
                        </form>
                        <div id="exerciseLogTable">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered log-table">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th><i class="fa-solid fa-person-running"></i> Exercise Name</th>
                                        <th><i class="fa-solid fa-hourglass-half"></i> Duration (min)</th>
                                        <th><i class="fa-solid fa-fire"></i> Calories (kcal)</th>
                                        <th><i class="fa-regular fa-calendar-days"></i> Date Logged</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        List<model.Exercise> exerciseList = (List<model.Exercise>) request.getAttribute("exerciseList");
                                        String errorMessage = (String) request.getAttribute("errorMessage");

                                        if (errorMessage != null) {
                                    %>
                                    <tr>
                                        <td colspan="4" class="text-danger text-center py-4">
                                            <i class="fa-solid fa-triangle-exclamation"></i> <%= errorMessage%>
                                        </td>
                                    </tr>
                                    <%
                                        } else if (exerciseList != null && !exerciseList.isEmpty()) {
                                            for (model.Exercise exercise : exerciseList) {
                                    %>
                                    <tr>
                                        <td><%= exercise.getName()%></td>
                                        <td class="duration"><%= exercise.getDuration()%></td>
                                        <td class="calories"><%= exercise.getCalories()%></td>
                                        <td><%= exercise.getDate()%></td>
                                    </tr>
                                    <%
                                            }
                                        } else { // No entries found or list is null/empty
                                    %>
                                    <tr>
                                        <td colspan="4" class="text-center text-muted py-4">
                                            <i class="fa-solid fa-info-circle"></i> No exercise entries found for this date.
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="total-section card mt-4">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fa-solid fa-calculator"></i> Total for the Day:</h5>
                        <div class="row justify-content-center">
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h6><i class="fa-solid fa-fire"></i> Calories Burned</h6>
                                        <h4 id="totalCaloriesBurned">0.0</h4>
                                        <small>kcal</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h6><i class="fa-regular fa-clock"></i> Total Duration</h6>
                                        <h4 id="totalDuration">0.0</h4>
                                        <small>min</small>
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
        console.log("DOMContentLoaded event fired in exercise.jsp");

        // Set today's date as default for the date input
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0'); // Months are 0-indexed
        const day = String(today.getDate()).padStart(2, '0');
        const formattedDate = `${year}-${month}-${day}`;
        console.log("Formatted date:", formattedDate);

        const logDateInput = document.getElementById('logDate');
        if (logDateInput) {
            console.log("logDateInput element found:", logDateInput);
            logDateInput.value = formattedDate;
            console.log("logDateInput value set to:", logDateInput.value);
        } else {
            console.log("logDateInput element NOT found!");
        }

        // Function to calculate totals
        function calculateTotals() {
            var tableBody = document.querySelector('#log table tbody');
            if (!tableBody) return;

            let totalCalories = 0;
            let totalDuration = 0;

            for (let row of tableBody.rows) {
                let caloriesCell = row.querySelector('.calories');
                let durationCell = row.querySelector('.duration');

                if (caloriesCell) {
                    let cal = parseFloat(caloriesCell.textContent.replace(/[^\d.]/g, '') || 0);
                    totalCalories += cal;
                }
                if (durationCell) {
                    let dur = parseFloat(durationCell.textContent.replace(/[^\d.]/g, '') || 0);
                    totalDuration += dur;
                }
            }

            document.getElementById("totalCaloriesBurned").textContent = totalCalories.toFixed(1);
            document.getElementById("totalDuration").textContent = totalDuration.toFixed(1);
        }

        // Initial calculation on page load
        calculateTotals();

        // Re-calculate totals when the log table content might change (e.g., after loading data)
        // This part needs to be triggered after an AJAX update or form submission if you're not doing full page reloads.
        // For now, assuming full page reload after form submission, so DOMContentLoaded is sufficient.
    });
</script>

<jsp:include page="footer.jsp" /> 