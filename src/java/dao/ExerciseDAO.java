package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import model.Exercise;
import util.DBConnection;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ExerciseDAO {

    public void saveExercise(Exercise exercise) {
        String sql = "INSERT INTO exercise_log (exercise_name, duration, calories,date) VALUES (?, ?, ?,?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, exercise.getName());
            stmt.setDouble(2, exercise.getDuration());
            stmt.setDouble(3, exercise.getCalories());
            
            LocalDateTime now = LocalDateTime.now();
            stmt.setTimestamp(4, Timestamp.valueOf(now));

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Exercise> getExercisesByDate(String date) throws Exception {
        List<Exercise> exercises = new ArrayList<>();
        String sql = "SELECT * FROM exercise_log WHERE DATE(date) = ? ORDER BY date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, date);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String name = rs.getString("exercise_name");
                    double duration = rs.getDouble("duration");
                    double calories = rs.getDouble("calories");
                    Timestamp timestamp = rs.getTimestamp("date");
                    exercises.add(new Exercise(name, duration, calories, timestamp));
                }
            }
        }
        return exercises;
    }

    public List<Exercise> getAllExercises() throws Exception {
        List<Exercise> exercises = new ArrayList<>();
        String sql = "SELECT * FROM exercise_log ORDER BY date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String name = rs.getString("exercise_name");
                double duration = rs.getDouble("duration");
                double calories = rs.getDouble("calories");
                Timestamp timestamp = rs.getTimestamp("date");
                exercises.add(new Exercise(name, duration, calories, timestamp));
            }
        }
        return exercises;
    }
}
