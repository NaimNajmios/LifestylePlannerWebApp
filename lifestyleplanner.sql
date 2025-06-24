-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jun 24, 2025 at 03:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lifestyleplanner`
--

-- --------------------------------------------------------

--
-- Table structure for table `exercise_log`
--

CREATE TABLE `exercise_log` (
  `id` int(11) NOT NULL,
  `exercise_name` varchar(255) NOT NULL,
  `duration` double DEFAULT NULL,
  `calories` double DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercise_log`
--

INSERT INTO `exercise_log` (`id`, `exercise_name`, `duration`, `calories`, `date`) VALUES
(1, 'swimming', 30, 195, '2025-06-10 21:21:39'),
(2, 'jogging', 15, 146.25, '2025-06-10 21:27:28'),
(3, 'running', 30, 343, '2025-06-14 10:39:59'),
(4, 'running', 30, 343, '2025-06-18 14:36:33'),
(5, 'swimming', 30, 210, '2025-06-18 14:37:46'),
(6, 'swimming', 30, 210, '2025-06-19 11:03:25'),
(7, 'swimming', 30, 210, '2025-06-20 15:01:44'),
(8, 'running', 30, 318.5, '2025-06-20 15:47:53'),
(9, 'running', 30, 318.5, '2025-06-24 21:41:38');

-- --------------------------------------------------------

--
-- Table structure for table `intake`
--

CREATE TABLE `intake` (
  `id` int(11) NOT NULL,
  `foodconsumed` varchar(255) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `calories` decimal(6,2) NOT NULL,
  `protein` decimal(5,2) NOT NULL,
  `carbohydrate` decimal(5,2) NOT NULL,
  `fat` decimal(5,2) NOT NULL,
  `date` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `remark` varchar(255) DEFAULT NULL
) ;

--
-- Dumping data for table `intake`
--

INSERT INTO `intake` (`id`, `foodconsumed`, `quantity`, `calories`, `protein`, `carbohydrate`, `fat`, `date`, `type`, `remark`) VALUES
(17, 'Instant Noodle', '1 Plate', 325.20, 8.36, 44.48, 12.36, '2025-05-22', 'Breakfast', 'No additional remark'),
(18, 'French Toast with Berries', '2 slices', 380.00, 10.00, 50.00, 12.00, '2025-05-06', 'Breakfast', 'With maple syrup'),
(19, 'Chicken Wrap', '1 wrap', 400.00, 22.00, 35.00, 15.00, '2025-05-06', 'Lunch', 'Whole wheat wrap'),
(20, 'Cucumber Sandwiches', '3 pieces', 200.00, 3.00, 25.00, 8.00, '2025-05-06', 'High Tea', 'With cream cheese'),
(21, 'Pork Chops with Mash', '1 plate', 650.00, 35.00, 45.00, 25.00, '2025-05-06', 'Dinner', NULL),
(22, 'Apple Slices with Peanut Butter', '1 apple, 2 tbsp', 250.00, 6.00, 30.00, 12.00, '2025-05-06', 'Supper', 'Late night snack'),
(23, 'Greek Yogurt with Honey', '1 cup', 220.00, 10.00, 30.00, 5.00, '2025-05-07', 'Breakfast', 'With granola'),
(24, 'Tuna Salad', '1 plate', 300.00, 25.00, 10.00, 12.00, '2025-05-07', 'Lunch', 'With olive oil'),
(25, 'Macarons', '3 pieces', 240.00, 3.00, 35.00, 10.00, '2025-05-07', 'High Tea', 'Assorted flavors'),
(26, 'Shrimp Fried Rice', '1 plate', 550.00, 20.00, 70.00, 15.00, '2025-05-07', 'Dinner', NULL),
(27, 'Mixed Nuts', '1 handful', 180.00, 5.00, 8.00, 15.00, '2025-05-07', 'Supper', NULL),
(28, 'Bagel with Cream Cheese', '1 bagel', 350.00, 10.00, 50.00, 10.00, '2025-05-08', 'Breakfast', 'With lox'),
(29, 'Beef Tacos', '2 tacos', 450.00, 25.00, 40.00, 15.00, '2025-05-08', 'Lunch', 'With guacamole'),
(30, 'Lemon Cake', '1 slice', 300.00, 4.00, 40.00, 12.00, '2025-05-08', 'High Tea', 'With tea'),
(31, 'Grilled Chicken with Quinoa', '1 plate', 500.00, 30.00, 40.00, 15.00, '2025-05-08', 'Dinner', NULL),
(32, 'Cottage Cheese', '1 cup', 200.00, 15.00, 6.00, 10.00, '2025-05-08', 'Supper', 'With pineapple'),
(33, 'Vegetable Omelette', '2 eggs', 300.00, 12.00, 10.00, 20.00, '2025-05-09', 'Breakfast', 'With spinach'),
(34, 'Falafel Wrap', '1 wrap', 400.00, 15.00, 50.00, 15.00, '2025-05-09', 'Lunch', 'With tahini'),
(35, 'Cheese Platter', '1 serving', 350.00, 12.00, 5.00, 25.00, '2025-05-09', 'High Tea', 'With crackers'),
(36, 'Beef Lasagna', '1 plate', 700.00, 30.00, 60.00, 25.00, '2025-05-09', 'Dinner', NULL),
(37, 'Mango Slices', '1 cup', 100.00, 1.00, 25.00, 0.50, '2025-05-09', 'Supper', 'Fresh fruit'),
(38, 'Chia Pudding', '1 cup', 250.00, 5.00, 30.00, 10.00, '2025-05-10', 'Breakfast', 'With coconut milk'),
(39, 'Salmon Salad', '1 plate', 400.00, 25.00, 15.00, 20.00, '2025-05-10', 'Lunch', 'With avocado'),
(40, 'Samosas', '2 pieces', 300.00, 5.00, 35.00, 15.00, '2025-05-10', 'High Tea', 'With chutney'),
(41, 'Vegetable Curry with Rice', '1 plate', 550.00, 10.00, 80.00, 15.00, '2025-05-10', 'Dinner', NULL),
(42, 'Popcorn', '2 cups', 100.00, 2.00, 20.00, 1.00, '2025-05-10', 'Supper', 'Light snack'),
(43, 'Waffles with Fruit', '2 waffles', 400.00, 8.00, 60.00, 12.00, '2025-05-11', 'Breakfast', 'With whipped cream'),
(44, 'Chicken Caesar Salad', '1 plate', 350.00, 20.00, 15.00, 15.00, '2025-05-11', 'Lunch', 'With croutons'),
(45, 'Brownies', '2 pieces', 350.00, 4.00, 45.00, 15.00, '2025-05-11', 'High Tea', 'With coffee'),
(46, 'Roast Lamb with Veggies', '1 plate', 600.00, 35.00, 40.00, 20.00, '2025-05-11', 'Dinner', NULL),
(47, 'Yogurt with Berries', '1 cup', 150.00, 8.00, 20.00, 3.00, '2025-05-11', 'Supper', NULL),
(48, 'Eggs Benedict', '2 eggs', 400.00, 15.00, 30.00, 20.00, '2025-05-12', 'Breakfast', 'With hollandaise'),
(49, 'Shrimp Tacos', '2 tacos', 450.00, 20.00, 40.00, 15.00, '2025-05-12', 'Lunch', 'With lime'),
(50, 'Fruit Scones', '2 pieces', 380.00, 5.00, 50.00, 15.00, '2025-05-12', 'High Tea', 'With clotted cream'),
(51, 'Chicken Parmesan', '1 plate', 650.00, 30.00, 50.00, 25.00, '2025-05-12', 'Dinner', NULL),
(52, 'Trail Mix', '1 handful', 200.00, 5.00, 20.00, 12.00, '2025-05-12', 'Supper', 'With raisins'),
(53, 'Smoothie with Spinach', '1 glass', 200.00, 5.00, 35.00, 3.00, '2025-05-13', 'Breakfast', 'With banana'),
(54, 'Pork Fried Rice', '1 plate', 550.00, 20.00, 70.00, 15.00, '2025-05-13', 'Lunch', NULL),
(55, 'Custard Tarts', '2 pieces', 300.00, 6.00, 35.00, 12.00, '2025-05-13', 'High Tea', 'With tea'),
(56, 'Grilled Fish with Couscous', '1 plate', 500.00, 30.00, 40.00, 15.00, '2025-05-13', 'Dinner', NULL),
(57, 'Cheese Sticks', '3 pieces', 150.00, 6.00, 5.00, 10.00, '2025-05-13', 'Supper', 'Quick snack'),
(58, 'Porridge with Nuts', '1 bowl', 300.00, 8.00, 40.00, 10.00, '2025-05-14', 'Breakfast', 'With almonds'),
(59, 'Vegetable Soup with Bread', '1 bowl, 2 slices', 350.00, 10.00, 50.00, 5.00, '2025-05-14', 'Lunch', 'With butter'),
(60, 'Mini Quiches', '3 pieces', 360.00, 12.00, 25.00, 20.00, '2025-05-14', 'High Tea', 'Spinach filling'),
(61, 'Beef Stew with Potatoes', '1 plate', 600.00, 30.00, 50.00, 20.00, '2025-05-14', 'Dinner', NULL),
(62, 'Orange Slices', '1 orange', 60.00, 1.00, 15.00, 0.20, '2025-05-14', 'Supper', 'Fresh fruit'),
(63, 'Croissant with Jam', '1 croissant', 300.00, 6.00, 40.00, 15.00, '2025-05-15', 'Breakfast', 'With butter'),
(64, 'Grilled Veggie Panini', '1 sandwich', 400.00, 10.00, 50.00, 15.00, '2025-05-15', 'Lunch', 'With mozzarella'),
(65, 'Eclairs', '2 pieces', 320.00, 5.00, 35.00, 15.00, '2025-05-15', 'High Tea', 'Chocolate topping'),
(66, 'Salmon with Asparagus', '1 plate', 500.00, 35.00, 20.00, 25.00, '2025-05-15', 'Dinner', NULL),
(67, 'Pretzels', '1 handful', 120.00, 3.00, 25.00, 1.00, '2025-05-15', 'Supper', 'Light snack'),
(68, 'Granola with Milk', '1 bowl', 350.00, 10.00, 50.00, 10.00, '2025-05-16', 'Breakfast', 'With honey'),
(69, 'Chicken Noodle Soup', '1 bowl', 300.00, 15.00, 30.00, 8.00, '2025-05-16', 'Lunch', 'With carrots'),
(70, 'Donuts', '2 pieces', 400.00, 5.00, 50.00, 20.00, '2025-05-16', 'High Tea', 'Glazed'),
(71, 'Pasta Primavera', '1 plate', 550.00, 15.00, 70.00, 15.00, '2025-05-16', 'Dinner', NULL),
(72, 'Grapes', '1 cup', 100.00, 1.00, 25.00, 0.50, '2025-05-16', 'Supper', 'Red grapes'),
(73, 'Boiled Eggs with Toast', '2 eggs, 2 slices', 300.00, 12.00, 30.00, 10.00, '2025-05-17', 'Breakfast', 'With avocado'),
(74, 'Lamb Wrap', '1 wrap', 450.00, 25.00, 40.00, 15.00, '2025-05-17', 'Lunch', 'With tzatziki'),
(75, 'Cookies', '3 pieces', 300.00, 4.00, 40.00, 12.00, '2025-05-17', 'High Tea', 'Chocolate chip'),
(76, 'Duck with Orange Sauce', '1 plate', 650.00, 35.00, 30.00, 30.00, '2025-05-17', 'Dinner', NULL),
(77, 'Rice Cakes', '2 pieces', 80.00, 1.00, 15.00, 0.50, '2025-05-17', 'Supper', 'Light snack'),
(78, 'Fruit Salad', '1 bowl', 200.00, 2.00, 45.00, 1.00, '2025-05-18', 'Breakfast', 'With yogurt dressing'),
(79, 'Sushi Rolls', '6 pieces', 400.00, 15.00, 60.00, 10.00, '2025-05-18', 'Lunch', 'With soy sauce'),
(80, 'Puff Pastries', '2 pieces', 350.00, 5.00, 40.00, 15.00, '2025-05-18', 'High Tea', 'With custard'),
(81, 'Chicken Stir Fry with Noodles', '1 plate', 550.00, 25.00, 60.00, 15.00, '2025-05-18', 'Dinner', NULL),
(82, 'Hummus with Veggies', '1 serving', 150.00, 5.00, 15.00, 8.00, '2025-05-18', 'Supper', 'Carrots and celery'),
(83, 'Pancakes with Chocolate', '3 pieces', 450.00, 8.00, 60.00, 15.00, '2025-05-19', 'Breakfast', 'With chocolate chips'),
(84, 'Turkey Burger', '1 burger', 400.00, 25.00, 35.00, 15.00, '2025-05-19', 'Lunch', 'With lettuce'),
(85, 'Fruit Cake', '1 slice', 350.00, 4.00, 50.00, 10.00, '2025-05-19', 'High Tea', 'With tea'),
(86, 'Beef Ribs with Fries', '1 plate', 700.00, 40.00, 50.00, 30.00, '2025-05-19', 'Dinner', NULL),
(87, 'Olives', '1 handful', 120.00, 1.00, 5.00, 10.00, '2025-05-19', 'Supper', 'Marinated'),
(88, 'Scrambled Eggs with Bacon', '2 eggs, 2 strips', 350.00, 15.00, 5.00, 25.00, '2025-05-20', 'Breakfast', 'With toast'),
(89, 'Vegetable Pizza', '2 slices', 450.00, 15.00, 60.00, 15.00, '2025-05-20', 'Lunch', 'With mushrooms'),
(90, 'Shortbread', '3 pieces', 300.00, 3.00, 40.00, 15.00, '2025-05-20', 'High Tea', 'With coffee'),
(91, 'Grilled Steak with Salad', '1 plate', 600.00, 40.00, 20.00, 30.00, '2025-05-20', 'Dinner', NULL),
(92, 'Kiwi', '2 pieces', 100.00, 1.00, 25.00, 0.50, '2025-05-20', 'Supper', 'Fresh fruit'),
(93, 'Muesli with Milk', '1 bowl', 300.00, 8.00, 45.00, 8.00, '2025-05-21', 'Breakfast', 'With dried fruit'),
(94, 'Chicken Shawarma', '1 wrap', 450.00, 25.00, 40.00, 15.00, '2025-05-21', 'Lunch', 'With garlic sauce'),
(95, 'Tiramisu', '1 serving', 350.00, 6.00, 40.00, 15.00, '2025-05-21', 'High Tea', 'With coffee'),
(96, 'Fish Curry with Rice', '1 plate', 550.00, 25.00, 70.00, 15.00, '2025-05-21', 'Dinner', NULL),
(97, 'Crackers with Cheese', '5 crackers, 2 slices', 200.00, 8.00, 15.00, 10.00, '2025-05-21', 'Supper', 'Light snack'),
(98, 'Avocado Smoothie', '1 glass', 250.00, 3.00, 30.00, 15.00, '2025-05-22', 'Breakfast', 'With almond milk'),
(99, 'Beef Burrito', '1 burrito', 500.00, 25.00, 50.00, 20.00, '2025-05-22', 'Lunch', 'With beans'),
(100, 'Madeleines', '3 pieces', 300.00, 5.00, 35.00, 12.00, '2025-05-22', 'High Tea', 'With tea'),
(101, 'Chicken Casserole', '1 plate', 550.00, 30.00, 50.00, 15.00, '2025-05-22', 'Dinner', NULL),
(102, 'Dark Chocolate', '3 squares', 180.00, 2.00, 15.00, 12.00, '2025-05-22', 'Supper', 'Dessert snack'),
(104, 'Chocolate Milk', '1 Cup', 207.50, 7.93, 25.85, 8.48, '2025-06-28', 'Breakfast', 'No additional remark'),
(105, 'Chicken Soup', '1 Bowl', 168.30, 10.05, 23.87, 3.72, '2025-06-28', 'Lunch', 'No additional remark'),
(107, 'Chicken Rice', '1 Plate', 316.88, 6.17, 54.85, 8.04, '2025-06-28', 'Lunch', 'No additional remark'),
(109, 'Instant Noodle', '1 Cup', 153.66, 3.95, 21.02, 5.84, '2025-06-28', 'High Tea', 'No additional remark'),
(111, 'Chocolate Milk', '2 Cup', 415.00, 15.85, 51.70, 16.95, '2025-05-28', 'Breakfast', 'No additional remark'),
(112, 'Curry Noodle', '1 Big Bowl', 759.29, 24.69, 96.99, 32.31, '2025-05-31', 'High Tea', 'No additional notes'),
(121, 'Curry Noodle', '1 Big Bowl', 759.29, 24.69, 96.99, 32.31, '2025-06-02', 'Breakfast', ''),
(122, 'Chicken Soup', '1 Plate', 168.30, 10.05, 23.87, 3.72, '2025-06-14', 'Breakfast', 'No additional notes'),
(123, 'Curry Noodle', '1 Big Bowl', 759.29, 24.69, 96.99, 32.31, '2025-06-18', 'Lunch', 'No additional notes'),
(124, 'Ice Cream', '1 Stick', 273.24, 4.62, 31.15, 14.52, '2025-06-19', 'Breakfast', 'No additional notes'),
(125, 'Fried Rice', '1 Plate', 238.38, 5.55, 44.92, 4.06, '2025-06-20', 'Breakfast', 'No additional notes'),
(126, 'Grilled Chicken Breast', '200g', 296.00, 59.00, 0.00, 6.78, '2025-06-20', 'Breakfast', 'No additional notes'),
(127, 'Chocolate Milk', '1 Cup', 207.50, 7.93, 25.85, 8.48, '2025-06-20', 'High Tea', 'No additional notes'),
(128, 'Curry Noodle', '1 Plate', 759.29, 24.69, 96.99, 32.31, '2025-06-24', 'Dinner', 'No additional notes');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exercise_log`
--
ALTER TABLE `exercise_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `intake`
--
ALTER TABLE `intake`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exercise_log`
--
ALTER TABLE `exercise_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `intake`
--
ALTER TABLE `intake`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
