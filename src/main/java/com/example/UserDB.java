package com.example;

import java.io.*;

public class UserDB {

    public static void save(User user) {
        // Get the absolute path to the users.txt file
        String path = "c:\\murach\\java_web\\apps\\javaee\\userDB\\users.txt";

        // Create a File object
        File file = new File(path);

        try {
            // Create parent directories if they don't exist
            file.getParentFile().mkdirs();

            // Create file if it doesn't exist
            if (!file.exists()) {
                file.createNewFile();
            }

            // Write user data to file
            PrintWriter out = new PrintWriter(
                    new FileWriter(file, true));

            out.println(user.getFirstName() + "\t" +
                    user.getLastName() + "\t" +
                    user.getEmail());
            out.close();

        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }
}