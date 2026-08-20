package com.example;

import java.util.ArrayList;
import java.util.List;

public class UserDB {

    // Lưu trữ tạm trong bộ nhớ (phù hợp để deploy lên Render free tier)
    private static final List<User> users = new ArrayList<>();

    public static void save(User user) {
        // Thêm user vào danh sách
        users.add(user);

        // In ra console để bạn có thể theo dõi trên Render Logs
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