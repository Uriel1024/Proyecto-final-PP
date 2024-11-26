package Conexion;

import java.sql.*;

public class Conexion {
    public static void main(String[] args) {
        Connection conexion;
        String JDBC = "Jdbc:mysql://localhost:3306/bd";
        try {
            conexion = DriverManager.getConnection(JDBC,"urielbd","6453543");
            System.out.println("Conexion exitosa");
        } catch (SQLException sql){
            sql.printStackTrace();
        }
    }
}

