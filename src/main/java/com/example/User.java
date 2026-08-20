package com.example;

import java.util.ArrayList;
import java.util.List;

public class UserDB {
    
    private static final List<User> users = new ArrayList<>();
    
    public static void save(User user) {
        users.add(user);
        
        System.out.println("=== USER SAVED ===");
        System.out.println("First Name: " + user.getFirstName());
        System.out.println("Last Name: " + user.getLastName());
        System.out.println("Email: " + user.getEmail());
        System.out.println("Total users in memory: " + users.size());
        System.out.println("==================");
    }
    
    public static List<User> getAllUsers() {
        return new ArrayList<>(users);
    }
}
