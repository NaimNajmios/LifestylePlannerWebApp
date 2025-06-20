package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Entities.Intake;
import util.DBConnection;

public class IntakeDAO {

    public double getTotalCaloriesByDate(String date) throws Exception {
        double totalCalories = 0.0;
        String sql = "SELECT SUM(calories) AS totalCalories FROM intake WHERE DATE(date) = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, date);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalCalories = rs.getDouble("totalCalories");
                }
            }
        }
        return totalCalories;
    }

    public List<Intake> getDailyIntakes(String date) throws Exception {
        List<Intake> intakes = new ArrayList<>();
        String sql = "SELECT * FROM intake WHERE DATE(date) = ? ORDER BY date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, date);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Intake intake = new Intake();
                    intake.setId(rs.getString("id"));
                    intake.setFoodQuery(rs.getString("foodconsumed"));
                    intake.setQuantity(rs.getString("quantity"));
                    intake.setCalories(rs.getDouble("calories"));
                    intake.setProtein(rs.getDouble("protein"));
                    intake.setCarbs(rs.getDouble("carbohydrate"));
                    intake.setFat(rs.getDouble("fat"));
                    intake.setDateConsumed(rs.getDate("date"));
                    intake.setMealType(rs.getString("type"));
                    intake.setRemark(rs.getString("remark"));
                    intakes.add(intake);
                }
            }
        }
        return intakes;
    }
} 