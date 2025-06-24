<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!-- Add CSS link -->
<link rel="stylesheet" href="css/home.css">

<!-- Main Content Section Begin -->
<section class="main-content">
    <!-- Quick Start Section Begin -->
    <section class="quickstart-section spad">
        <div class="container">
            <div class="row mb-4">
                <div class="col-lg-12 text-center">
                    <h2 class="section-title">Quick Start</h2>
                    <p class="lead">Jump right in to the most popular features of Lifestyle Planner</p>
                </div>
            </div>
            <div class="quickstart-cards">
                <a href="recipes.jsp" class="quickstart-card">
                    <div class="quickstart-icon"><i class="fa-solid fa-utensils"></i></div>
                    <div class="quickstart-title">Recipes</div>
                    <div class="quickstart-desc">Find healthy recipes for every lifestyle.</div>
                </a>
                <a href="/articles" class="quickstart-card">
                    <div class="quickstart-icon"><i class="fa-solid fa-newspaper"></i></div>
                    <div class="quickstart-title">Articles</div>
                    <div class="quickstart-desc">Read the latest in health and wellness.</div>
                </a>
                <a href="calories-tracker.jsp" class="quickstart-card">
                    <div class="quickstart-icon"><i class="fa-solid fa-chart-line"></i></div>
                    <div class="quickstart-title">Calories</div>
                    <div class="quickstart-desc">Track your daily nutrition intake.</div>
                </a>
                <a href="exercise.jsp" class="quickstart-card">
                    <div class="quickstart-icon"><i class="fa-solid fa-dumbbell"></i></div>
                    <div class="quickstart-title">Exercise</div>
                    <div class="quickstart-desc">Access personalized workout plans.</div>
                </a>
            </div>
        </div>
    </section>
    <!-- Quick Start Section End -->

    <!-- Motivational Quote/Testimonial Section Begin -->
    <section class="testimonial-section py-5 bg-light">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center">
                    <blockquote class="blockquote">
                        <p class="mb-4">“The journey of a thousand miles begins with a single step. Start your healthy lifestyle today!”</p>
                        <footer class="blockquote-footer">Lao Tzu</footer>
                    </blockquote>
                </div>
            </div>
        </div>
    </section>
    <!-- Motivational Quote/Testimonial Section End -->

    <!-- Features Section Begin -->
    <section class="features-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Why Choose Us</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fa-solid fa-utensils"></i>
                        </div>
                        <h3>Healthy Recipes</h3>
                        <p>Discover thousands of nutritious recipes tailored to your dietary preferences and goals.</p>
                        <a href="recipes.jsp" class="primary-btn">Explore Recipes</a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fa-solid fa-chart-simple"></i>
                        </div>
                        <h3>Calorie Tracking</h3>
                        <p>Monitor your daily nutrition intake with our easy-to-use calorie tracking system.</p>
                        <a href="calories-tracker.jsp" class="primary-btn">Track Calories</a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fa-solid fa-dumbbell"></i>
                        </div>
                        <h3>Exercise Plans</h3>
                        <p>Access personalized workout routines and track your fitness progress.</p>
                        <a href="exercise.jsp" class="primary-btn">View Plans</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Features Section End -->

    <!-- Stats Section Begin -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">1000+</div>
                        <div class="stat-label">Healthy Recipes</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Exercise Plans</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">10k+</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">24/7</div>
                        <div class="stat-label">Support</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Stats Section End -->
</section>
<!-- Main Content Section End -->

<jsp:include page="footer.jsp" /> 