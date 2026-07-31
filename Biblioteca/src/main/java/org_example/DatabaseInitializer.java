package org_example;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.nio.file.*;
import java.io.IOException;
import java.util.List;

public class DatabaseInitializer {

    public static void main(String[] args) {
        System.out.println("Initializing Biblioteca database...");

        try {
            // Read the SQL script
            String sqlScript = Files.readString(Paths.get("init_db.sql"));

            // Split by semicolon to get individual statements
            List<String> sqlCommands = java.util.Arrays.asList(sqlScript.split(";"));

            // Execute each command
            try (Connection conn = Conexao.conectar();
                 Statement stmt = conn.createStatement()) {

                for (String command : sqlCommands) {
                    String trimmed = command.trim();
                    if (!trimmed.isEmpty()) {
                        System.out.println("Executing: " + truncatedSql(trimmed, 100) + "...");
                        stmt.execute(trimmed);
                        System.out.println("✓ Executed successfully");
                    }
                }

                System.out.println("\nDatabase initialization completed successfully!");
                System.out.println("Database: BIBLIOTECA");
                System.out.println("You can now run the Biblioteca application.");
            }

        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace();
            System.err.println("\nPlease make sure MySQL server is running and accessible.");
            System.err.println("Connection details:");
            System.out.println("  URL: jdbc:mysql://localhost:3306/");
            System.out.println("  User: root");
            System.out.println("  Password: 2052");
        } catch (IOException e) {
            System.err.println("Error reading SQL script: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static String truncatedSql(String sql, int length) {
        if (sql.length() <= length) {
            return sql;
        }
        return sql.substring(0, length - 3) + "...";
    }
}