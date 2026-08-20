package com.example;

import java.util.ArrayList;
import java.util.List;

public class UserDB {
    private static final List<User> users = new ArrayList<>();

    public static void save(User user) {
        users.add(user);
        System.out.println("=== USER SAVED TO MEMORY ===");
        System.out.println("Name: " + user.getFirstName() + " " + user.getLastName());
        System.out.println("Email: " + user.getEmail());
    }

    public static List<User> getAllUsers() {
        return new ArrayList<>(users);
    }
}