<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Exercise" %>
<%@ page import="Entities.Intake" %>
<jsp:include page="header.jsp" />

<!-- Main Content Section Begin -->
<section class="main-content" style="margin: 50px 0;">
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2><i class="fa-solid fa-calculator"></i> Net Calories Balance</h2>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fa-regular fa-calendar"></i> Select Date for Balance</h3>
                    </div>
                    <div class="card-body">
                        <form action="NetCaloriesServlet" method="post" id="netCaloriesForm">
                            <div class="form-group d-flex align-items-center">
                                <label for="balanceDate" class="me-2"><i class="fa-regular fa-calendar"></i> Date:</label>
                                <input type="date" class="form-control w-auto me-2" id="balanceDate" name="balanceDate" required>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fa-solid fa-rotate"></i> Load Balance
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="card mt-4">
                    <div class="card-header">
                        <h3><i class="fa-solid fa-chart-bar"></i> Daily Calorie Balance</h3>
                    </div>
                    <div class="card-body">
                        <%
                            Double totalIntakeCalories = (Double) request.getAttribute("totalIntakeCalories");
                            Double totalExerciseCalories = (Double) request.getAttribute("totalExerciseCalories");
                            String errorMessage = (String) request.getAttribute("errorMessage");

                            if (errorMessage != null) {
                        %>
                        <div class="alert alert-danger">
                            <i class="fa-solid fa-triangle-exclamation"></i> <%= errorMessage%>
                        </div>
                        <%
                            } else if (totalIntakeCalories != null || totalExerciseCalories != null) {
                                double netCalories = (totalIntakeCalories != null ? totalIntakeCalories : 0.0) - (totalExerciseCalories != null ? totalExerciseCalories : 0.0);
                        %>
                        <div class="row text-center">
                            <div class="col-md-4 mb-3">
                                <div class="card bg-success text-white">
                                    <div class="card-body">
                                        <h6><i class="fa-solid fa-arrow-down"></i> Calories Intake</h6>
                                        <h4 id="intakeCalories"><%= String.format("%.1f", totalIntakeCalories != null ? totalIntakeCalories : 0.0) %></h4>
                                        <small>kcal</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card bg-danger text-white">
                                    <div class="card-body">
                                        <h6><i class="fa-solid fa-arrow-up"></i> Calories Outtake</h6>
                                        <h4 id="outtakeCalories"><%= String.format("%.1f", totalExerciseCalories != null ? totalExerciseCalories : 0.0) %></h4>
                                        <small>kcal</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card <%= netCalories >= 0 ? "bg-warning" : "bg-info" %> text-white">
                                    <div class="card-body">
                                        <h6><i class="fa-solid fa-balance-scale"></i> Net Calories</h6>
                                        <h4 id="netCalories"><%= String.format("%.1f", netCalories) %></h4>
                                        <small>kcal</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            } else {
                        %>
                        <div class="alert alert-info mt-4">
                            <i class="fa-solid fa-circle-info"></i> Select a date above to view your calorie balance.
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Main Content Section End -->

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Only auto-submit if no data or error message is already present from a servlet forward
        const hasData = document.getElementById('intakeCalories') || document.getElementById('outtakeCalories');
        const hasErrorMessage = document.querySelector('.alert-danger');

        if (!hasData && !hasErrorMessage) {
            // Set today's date as default for the balance date input
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0'); // Months are 0-indexed
            const day = String(today.getDate()).padStart(2, '0');
            const formattedDate = `${year}-${month}-${day}`;

            const balanceDateInput = document.getElementById('balanceDate');
            if (balanceDateInput) {
                balanceDateInput.value = formattedDate;
                // Submit the form automatically to load data for today's date
                document.getElementById('netCaloriesForm').submit();
            }
        }
    });
</script>

<jsp:include page="footer.jsp" /> 