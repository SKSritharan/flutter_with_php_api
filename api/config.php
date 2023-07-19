<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";

// Attempt to connect to MySQL server
$conn = new mysqli($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Database name to be created
$dbname = "flutter_auth";

// Create the database if it doesn't exist
$sql = "CREATE DATABASE IF NOT EXISTS $dbname";
if ($conn->query($sql) === FALSE)
{
    echo "Error creating database: " . $conn->error;
}

// Close the connection
$conn->close();

// Attempt to connect to MySQL server
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>

