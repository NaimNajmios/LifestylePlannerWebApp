package model;

import java.sql.Timestamp;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author User
 */
public class Exercise {
    private String name;
    private double duration;
    private double calories;
    private Timestamp date;

    public Exercise(String name, double duration, double calories) {
        this.name = name;
        this.duration = duration;
        this.calories = calories;
    }

    public Exercise(String name, double duration, double calories, Timestamp date) {
        this.name = name;
        this.duration = duration;
        this.calories = calories;
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public double getDuration() {
        return duration;
    }

    public double getCalories() {
        return calories;
    }

    public Timestamp getDate() {
        return date;
    }
}
