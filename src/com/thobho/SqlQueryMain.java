package com.thobho;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class SqlQueryMain {

    private final String dbms = "mysql";
    private final String userName = "thobho";
    private final String serverName = "localhost";
    private final int portNumber = 3306;
    private final String databaseName = "world";

    public static void main(String[] args) throws SQLException {
        SqlQueryMain sqlQueryMain = new SqlQueryMain();


        Connection connection = sqlQueryMain.getConnection();


        List<Country> countries = sqlQueryMain.getCountries(connection);

        countries.stream()
                .filter(country -> country.getName().startsWith("Pol"))
                .forEach(System.out::println);

    }

    private Connection getConnection() throws SQLException {

        Properties connectionProps = new Properties();
        connectionProps.put("user", this.userName);
        connectionProps.put("password", this.password);


        String connectionString = "jdbc:" + this.dbms + "://" +
                this.serverName +
                ":" + this.portNumber + "/";
        System.out.println(connectionString);

        Connection conn = DriverManager.getConnection(
                connectionString,
                connectionProps);


        return conn;
    }

    private List<Country> getCountries(Connection con) throws SQLException {
        Statement stmt = null;

        String query = String.format("SELECT name,population FROM %s.country;", databaseName);
        System.out.println(query);
        List<Country> countries = new ArrayList<>();

        try {
            stmt = con.createStatement();
            ResultSet resultSet = stmt.executeQuery(query);


            while (resultSet.next()) {
                String countryName = resultSet.getString(1);
                int population = resultSet.getInt(2);
                Country country = new Country(population, countryName);
                countries.add(country);
            }

        } catch (SQLException e ) {
            System.out.println(e.getErrorCode());
        } finally {
            if (stmt != null) { stmt.close(); }
        }
        return countries;
    }
















    public void viewTable(Connection con)
            throws SQLException {

        Statement stmt = null;
        String query = "select * " +
                "from " + this.databaseName + ".samochod";
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                String mark = rs.getString("marka");
                String model = rs.getString("model");
                int volume = rs.getInt("pojemnosc");

                System.out.println(String.format("Marka: %s, model: %s, pojemnosc: %d", mark, model, volume));
            }
        } catch (SQLException e ) {
            System.out.println(e.getErrorCode());
        } finally {
            if (stmt != null) { stmt.close(); }
        }
    }




































































    private final String password = "";
}
