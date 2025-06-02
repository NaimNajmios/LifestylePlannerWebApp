<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!-- Main Content Section Begin -->
<section class="main-content" style="margin: 50px 0;">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h1>Calories Tracker</h1>
                <p>Track your daily calorie intake and maintain a healthy lifestyle.</p>
            </div>
        </div>
        
        <!-- Daily Summary Section -->
        <div class="row mt-4">
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body text-center">
                        <h3>Daily Goal</h3>
                        <h2 class="text-primary">2000</h2>
                        <p>calories</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body text-center">
                        <h3>Consumed</h3>
                        <h2 class="text-success">1450</h2>
                        <p>calories</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body text-center">
                        <h3>Remaining</h3>
                        <h2 class="text-warning">550</h2>
                        <p>calories</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Food Entry Section -->
        <div class="row mt-4">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <h3>Add Food Entry</h3>
                        <form class="mt-3">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Food Name">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <input type="number" class="form-control" placeholder="Calories">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <select class="form-control">
                                            <option>Breakfast</option>
                                            <option>Lunch</option>
                                            <option>Dinner</option>
                                            <option>Snack</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary btn-block">Add</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Food Entries List -->
        <div class="row mt-4">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <h3>Today's Food Entries</h3>
                        <div class="table-responsive mt-3">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Time</th>
                                        <th>Food</th>
                                        <th>Meal Type</th>
                                        <th>Calories</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>08:00 AM</td>
                                        <td>Oatmeal with Fruits</td>
                                        <td>Breakfast</td>
                                        <td>350</td>
                                        <td><button class="btn btn-sm btn-danger">Delete</button></td>
                                    </tr>
                                    <tr>
                                        <td>12:30 PM</td>
                                        <td>Grilled Chicken Salad</td>
                                        <td>Lunch</td>
                                        <td>450</td>
                                        <td><button class="btn btn-sm btn-danger">Delete</button></td>
                                    </tr>
                                    <tr>
                                        <td>03:00 PM</td>
                                        <td>Protein Shake</td>
                                        <td>Snack</td>
                                        <td>200</td>
                                        <td><button class="btn btn-sm btn-danger">Delete</button></td>
                                    </tr>
                                    <tr>
                                        <td>07:00 PM</td>
                                        <td>Salmon with Vegetables</td>
                                        <td>Dinner</td>
                                        <td>450</td>
                                        <td><button class="btn btn-sm btn-danger">Delete</button></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Main Content Section End -->

<jsp:include page="footer.jsp" />