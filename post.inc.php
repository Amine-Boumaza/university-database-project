<?php
$table_columns = [];

if (isset($_POST["table_name"])) {
    $table_name = $_POST["table_name"];

    $sql = "SHOW COLUMNS FROM $table_name";
    $result = $conn->query($sql);


    while ($row = $result->fetch_assoc()) {
        $table_columns[] = $row["Field"];
    }
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $table_name = $_POST["table_name"];
    $action = $_POST["action"];

    
    if ($action == "insert") {
        $values = $_POST["values"];

        // Build the SQL query for inserting values into the selected table
        $sql = "INSERT INTO $table_name (";
        $sql .= implode(", ", array_keys($values));
        $sql .= ") VALUES (";
        $sql .= implode(", ", array_fill(0, count($values), "?"));
        $sql .= ")";

        // Prepare the SQL statement and bind the values
        $stmt = $conn->prepare($sql);
        $types = str_repeat("s", count($values));
        $params = array_values($values);
        $refs = array();
        foreach ($params as $key => $value) {
            $refs[$key] = &$params[$key];
        }
        array_unshift($refs, $types);
        $method = new ReflectionMethod('mysqli_stmt', 'bind_param');
        $method->invokeArgs($stmt, $refs);
        $stmt->execute();
    }
}
