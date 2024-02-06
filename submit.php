<?php
// query.php

// By Zackary Paulson with the help of chat
//
// This PHP file was nessesary in order to bring the actions made on the HTML page then that is transfered to the js which 
// effects the PHP page. The PHP page then talks to the SQL database. 

// This PHP file basically talks to the SQLite database, grabs details about trips for a particular driver
// (you tell it which one through a GET request), and shoots back the info in a friendly JSON format.
$databasePath = '/Users/zackpaulson/DatabaseProjects/A2Proj/database.SQL';  

try {
    $db = new PDO("sqlite:$databasePath");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $driverName = $_GET['driver'];

    $query = "SELECT Trips.TripID, Trips.Date, Trips.Destination, Drivers.FullName AS DriverName, Passengers.FullName AS PassengerName
              FROM Trips
              JOIN Drivers ON Trips.DriverID = Drivers.DriverID
              JOIN Passengers ON Trips.TripID = Passengers.TripID
              WHERE Drivers.FullName = :driver";

    $statement = $db->prepare($query);
    $statement->bindParam(':driver', $driver, PDO::PARAM_STR);
    $statement->execute();

    $result = $statement->fetchAll(PDO::FETCH_ASSOC);

    header('Content-Type: application/json');
    echo json_encode($result);
} else {
    http_response_code(405);
    echo json_encode(array("error" => "Invalid request method"));
}

$db = null;
?>
