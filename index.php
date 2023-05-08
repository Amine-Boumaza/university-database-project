<?php
// Replace with your own connection details
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "univ";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle form submissions
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $table_name = $_POST["table_name"];
    $action = $_POST["action"];

    // Check if the action is "insert"
    if ($action == "insert") {
        $values = $_POST["values"];

        // Build the SQL query for inserting values into the selected table
        $sql = "INSERT INTO $table_name (";
        $sql .= implode(", ", array_slice($table_columns, 1));
        $sql .= ") VALUES (";
        $sql .= implode(", ", array_fill(0, count($values) - 1, "?"));
        $sql .= ")";

        // Prepare the SQL statement and bind the values
        $stmt = $conn->prepare($sql);
        $types = str_repeat("s", count($values) - 1);
        $stmt->bind_param($types, array_slice($values, 1));
        $stmt->execute();
    }
}

// Get table columns
$table_columns = [];
// Check if a table is selected
if (isset($_POST["table_name"])) {
    $table_name = $_POST["table_name"];
    // Fetch the columns of the selected table
    $sql = "SHOW COLUMNS FROM $table_name";
    $result = mysqli_query($conn, $sql);

    // Store the column names in an array
    while ($row = mysqli_fetch_assoc($result)) {
        $table_columns[] = $row["Field"];
    }
}

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University Research Database</title>
    <script>
        // JavaScript function to submit the form when a table is selected
        function updateForm() {
            const form = document.getElementById("insert-form");
            form.submit();
        }
    </script>
</head>

<body>
    <h1>University Research Database</h1>

    <!-- Form for selecting a table -->
    <form id="insert-form" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
        <input type="hidden" name="action" value="select_table">
        <label for="table_name">Select a table:</label>
        <select name="table_name" id="table_name" onchange="updateForm()">
            <option value="">--Select a table--</option>
            <?php
            // List of table names
            $tables = ["faculty", "laboratory", "team", "department", "member", "research_axis", "article", "keyword", "publication", "publication_type", "article_author_keyword"];
            // Generate the options for the dropdown list
            foreach ($tables as $table) {
                $selected = $table_name == $table ? "selected" : "";
                echo "<option value=\"$table\" $selected>$table</option>";
            }
            ?>
        </select>
    </form>

    <!-- Check if a table is selected and columns are fetched -->
    <?php if (!empty($table_columns)) : ?>
        <h2>Insert into <?php echo $table_name; ?></h2>
        <!-- Form for inserting values into the selected table -->
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <input type="hidden" name="action" value="insert">
            <input type="hidden" name="table_name" value="<?php echo $table_name; ?>">
            <?php foreach ($table_columns as $column) : ?>
                <?php if ($column != "id") : ?>
                    <!-- Generate input fields for each column (excluding the primary key) -->
                    <label for="<?php echo $column; ?>"><?php echo ucfirst(str_replace("_", " ", $column)); ?>:</label>
                    <input type="text" name="values[]" id="<?php echo $column; ?>" required><br>
                <?php endif; ?>
            <?php endforeach; ?>
            <input type="submit" value="Insert">
        </form>
    <?php endif; ?>

</body>

</html>
<?php
$conn->close();
?>