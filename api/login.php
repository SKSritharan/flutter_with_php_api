<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'config.php'; // Include the database connection

// Create the "users" table if it doesn't exist
$sql_create_table = "CREATE TABLE IF NOT EXISTS users (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    address TEXT,
    phone_no VARCHAR(20),
    latitude FLOAT(10, 6),
    longitude FLOAT(10, 6),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)";

if ($conn->query($sql_create_table) === false) {
    $response = array("success" => false, "message" => "Error creating table: " . $conn->error);
    http_response_code(500); // Set HTTP status code to 500 Internal Server Error
    header('Content-Type: application/json');
    echo json_encode($response);
    exit(); // Stop execution if there was an error creating the table
}

// Get the raw POST data
$input = file_get_contents('php://input');
$data = json_decode($input, true);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $data['email'];
    $password = $data['password'];

    // Check if user exists and password is correct
    $sql = "SELECT * FROM users WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows === 1) {
        $row = $result->fetch_assoc();
        $hashedPassword = $row['password'];

        // Verify the hashed password against the provided plain password
        if (password_verify($password, $hashedPassword)) {
            // Passwords match, login successful
            $response = array("success" => true, "message" => "Login successful", "user" => $row);
            http_response_code(200); // Set HTTP status code to 200 OK
        } else {
            // Passwords do not match, login failed
            $response = array("success" => false, "message" => "Invalid credentials");
            http_response_code(401); // Set HTTP status code to 401 Unauthorized
        }
    } else {
        // User not found, login failed
        $response = array("success" => false, "message" => "Invalid credentials");
        http_response_code(401); // Set HTTP status code to 401 Unauthorized
    }

    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close the database connection
$conn->close();

?>
