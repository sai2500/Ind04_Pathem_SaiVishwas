<?php
// Setting header for JSON content
header('Content-Type: application/json');

// Database connection parameters
$host = "mysql.cs.okstate.edu"; // Change this as necessary
$user = "spathem"; // Your database username
$pass = "sw3etEgg71"; // Your database password
$db = "spathem"; // Your database name

// Establishing connection
$conn = new mysqli($host, $user, $pass, $db);

// Checking connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to retrieve data
$query = "SELECT name, nickname FROM states";
$result = $conn->query($query);

// Array to hold state data
$stateData = [];

// Fetching and encoding data
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $stateData[] = $row;
    }
    echo json_encode($stateData);
} else {
    echo json_encode([]);
}

// Closing connection
$conn->close();
?>

