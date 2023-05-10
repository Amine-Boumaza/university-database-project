<?php
include 'connect.php';

include 'post.inc.php';

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/insert.css">
    <title>University Research Database</title>
    <script>
        function updateForm() {
            const form = document.getElementById("insert-form");
            form.submit();
        }
    </script>
</head>

<body>
    <a href="/index.php" class="show">go back</a>
    <h1>University Research Database</h1>


    <!-- Form for selecting a table -->
    <form id="insert-form" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
        <input type="hidden" name="action" value="select_table">
        <label for="table_name">Select a table:</label>
        <select name="table_name" id="table_name" onchange="updateForm()">
            <option value="">--Select a table--</option>
            <?php
            // List of table names
            $tables = ["faculty", "laboratory", "team", "department", "researcher", "researcher_team", "focus", "researcher_focus", "article", "keyword", "article_keyword", "Databas", "book", "journal", "conference", "article_researcher", "journal_database", "conference_database", "book_article"];
            // Generate the options for the dropdown list
            foreach ($tables as $table) {
                $selected = $table_name == $table ? "selected" : "";
                echo "<option value=\"$table\" $selected>$table</option>";
            }
            ?>
        </select>
    </form>


    <?php if (!empty($table_columns)) : ?>
        <h2>Insert into <?php echo $table_name; ?></h2>
        <!-- Form for inserting values into the selected table -->
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <input type="hidden" name="action" value="insert">
            <input type="hidden" name="table_name" value="<?php echo $table_name; ?>">
            <?php foreach ($table_columns as $column) : ?>
                <?php if ($column != "id") : ?>
                    <!-- Generate input fields for each column (excluding the primary key) -->
                    <label for="<?php echo $column; ?>"><?php echo ucfirst($column); ?>:</label>
                    <input type="text" name="values[<?php echo $column; ?>]" id="<?php echo $column; ?>" required><br>
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