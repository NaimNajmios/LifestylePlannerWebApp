<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="LifestylePlanner Template">
    <meta name="keywords" content="LifestylePlanner, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Lifestyle Planner - Your Health & Wellness Companion</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=PT+Sans:400,700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Oswald:400,500,600,700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/flaticon.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="css/articles.css" type="text/css">
</head>
<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="container-fluid">
            <div class="inner-header">
                <div class="row">
                    <div class="col-lg-2 col-md-2">
                        <div class="logo">
                            <!-- Logo link to home page -->
                            <!-- <a href="./index.jsp"><img src="img/logo.png" alt="Lifestyle Planner Logo" class="logo-img"></a> -->
                        </div>
                    </div>
                    <div class="col-lg-10 col-md-10">
                        <nav class="main-menu mobile-menu">
                            <ul>
                                <%
                                    String currentPage = request.getRequestURI();
                                    String homeClass = currentPage.endsWith("index.jsp") ? "active" : "";
                                    String articlesClass = currentPage.endsWith("articles.jsp") ? "active" : "";
                                    String recipesClass = currentPage.endsWith("recipes.jsp") ? "active" : "";
                                    String caloriesClass = currentPage.endsWith("calories-tracker.jsp") ? "active" : "";
                                    String exerciseClass = currentPage.endsWith("exercise.jsp") ? "active" : "";
                                    String netCaloriesClass = currentPage.endsWith("net-calories.jsp") ? "active" : "";
                                %>
                                <li><a class="<%= homeClass %>" href="./index.jsp"><i class="fa-solid fa-house"></i> Home</a></li>
                                <li><a class="<%= articlesClass %>" href="./articles.jsp"><i class="fa-solid fa-newspaper"></i> Articles</a></li>
                                <li><a class="<%= recipesClass %>" href="./recipes.jsp"><i class="fa-solid fa-utensils"></i> Recipes</a></li>
                                <li><a class="<%= caloriesClass %>" href="./calories-tracker.jsp"><i class="fa-solid fa-chart-line"></i> Calories Tracker</a></li>
                                <li><a class="<%= exerciseClass %>" href="./exercise.jsp"><i class="fa-solid fa-dumbbell"></i> Exercise</a></li>
                                <li><a class="<%= netCaloriesClass %>" href="./net-calories.jsp"><i class="fa-solid fa-calculator"></i> Net Calories</a></li>
                            </ul>
                        </nav>
                        <div id="mobile-menu-wrap"></div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header End --> 
</body>
</html> 