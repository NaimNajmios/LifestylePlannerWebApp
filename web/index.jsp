<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!-- Add CSS link -->
<link rel="stylesheet" href="css/home.css">

<!-- Main Content Section Begin -->
<section class="main-content">
    <!-- CTA Section Begin -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-content">
                <h1>Transform Your Lifestyle</h1>
                <p>Your all-in-one platform for healthy living, featuring meal planning, exercise tracking, and nutrition guidance.</p>
                <div class="cta-buttons">
                    <a href="recipes.jsp" class="cta-button primary">Get Started</a>
                    <a href="articles.jsp" class="cta-button secondary">Learn More</a>
                </div>
            </div>
        </div>
    </section>
    <!-- CTA Section End -->

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