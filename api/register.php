<?php

include 'config.php'; // Include the database connection

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

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
    $name = $data['name'];
    $email = $data['email'];
    $password = $data['password'];
    $dob = $data['dob'];
    $address = $data['address'];
    $phone_no = $data['phone_no'];
    $location = $data['location'];

    // Extract latitude and longitude from the location object
    $latitude = $location['latitude'];
    $longitude = $location['longitude'];

    // Check if user already exists
    $sql = "SELECT * FROM users WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // User already exists
        $response = array("success" => false, "message" => "User already exists");
        http_response_code(400); // Set HTTP status code to 400 Bad Request
    } else {
        // Hash the password before storing it
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // Insert new user into database
        $sql = "INSERT INTO users (name, email, password, dob, address, phone_no, latitude, longitude) VALUES ('$name', '$email', '$hashedPassword', '$dob', '$address', '$phone_no', $latitude, $longitude)";

        if ($conn->query($sql) === true) {
            $response = array("success" => true, "message" => "Registration successful");
            http_response_code(200); // Set HTTP status code to 200 Created
        } else {
            $response = array("success" => false, "message" => "Registration failed");
            http_response_code(500); // Set HTTP status code to 500 Internal Server Error
        }
    }

    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close the database connection
$conn->close();

?>
