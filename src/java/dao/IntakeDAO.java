package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
} 