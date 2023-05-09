<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="/show.css">
    <title>Query Results</title>
</head>

<body>
    <h1>Query Results</h1>
    <form method="post">
        <label for="query">Select a query:</label>
        <select name="query" id="query">
            <option value="">-- Select a query --</option>
            <option value="1">Researchers belonging to a specific laboratory</option>
            <option value="2">Articles written by a specific researcher</option>
            <option value="3">Researchers belonging to a specific department</option>
            <option value="4">Articles published in a specific journal</option>
        </select>
        <br><br>
        <label for="name">enter the Name of what you are looking for:</label>
        <input type="text" name="name" id="name">
        <br><br>
        <input type="submit" value="Submit">
    </form>
    <?php
    // Check if the form has been submitted
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Get the selected query
        $query = $_POST['query'];

        include 'connect.php';

        // Execute the selected query and display the results in a table
        switch ($query) {
            case '1':
                $lab_name = $_POST['name'];
                $sql = "SELECT r.id, r.name 
						FROM researcher r,researcher_team rt,team t,laboratory l
						WHERE  r.id=rt.researcher_id
						AND rt.team_id = t.id
						AND t.lab_id=l.id
						AND l.name = '$lab_name'";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) { ?>
                    <table>
                        <tr>
                            <th>Name</th>

                        </tr>
                        <?php while ($row = $result->fetch_assoc()) { ?>
                            <tr>
                                <td><?php echo $row["name"]; ?></td>
                                <!-- <td>
                                    <form method="post">
                                        <input type="hidden" name="researcher_id" value="<?php echo $row["id"]; ?>">
                                        <input type="submit" name="delete" value="Delete">
                                    </form>
                                </td> -->
                            </tr>
                        <?php } ?>
                    </table>
                <?php
                } else {
                    echo "0 results";
                }
                break;
            case '2':
                $researcher_name = $_POST['name'];
                $sql = "SELECT a.id, a.title , a.publication_date
						FROM article a, article_researcher ar, researcher r
						WHERE a.id = ar.article_id
						AND ar.researcher_id = r.id
						AND r.name = '$researcher_name'";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) { ?>
                    <table>
                        <tr>
                            <th>Title</th>
                            <th>Publication Date</th>

                        </tr>
                        <?php while ($row = $result->fetch_assoc()) { ?>
                            <tr>
                                <td><?php echo $row["title"]; ?></td>
                                <td><?php echo $row["publication_date"]; ?></td>
                                <!-- <td>
                                    <form method="post">
                                        <input type="hidden" name="article_id" value="<?php echo $row["id"]; ?>">
                                        <input type="submit" name="delete" value="Delete">
                                    </form>
                                </td> -->
                            </tr>
                        <?php } ?>
                    </table>
                <?php
                } else {
                    echo "0 results";
                }
                break;
            case '3':
                $dept_name = $_POST['name'];
                $sql = "SELECT r.id, r.name 
						FROM researcher r, department d
						WHERE r.department_id = d.id
						AND d.name = '$dept_name'
						ORDER BY r.name";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                ?>
                    <table>
                        <tr>
                            <th>Name</th>

                        </tr>
                        <?php while ($row = $result->fetch_assoc()) { ?>
                            <tr>
                                <td><?php echo $row["name"]; ?></td>
                                <!-- <td>
                                    <form method="post">
                                        <input type="hidden" name="researcher_id" value="<?php echo $row["id"]; ?>">
                                        <input type="submit" name="delete" value="Delete">
                                    </form>
                                </td> -->
                            </tr>
                        <?php } ?>
                    </table>
                <?php
                } else {
                    echo "0 results";
                }
                break;
            case '4':
                $journal_name = $_POST['name'];
                $sql = "SELECT title , publication_date
						FROM article
						WHERE journal_id = (SELECT id FROM journal WHERE name = '$journal_name')
						ORDER BY publication_date";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                ?>
                    <table>
                        <tr>
                            <th>Title</th>
                            <th>Publication Date</th>

                        </tr>
                        <?php while ($row = $result->fetch_assoc()) { ?>
                            <tr>
                                <td><?php echo $row["title"]; ?></td>
                                <td><?php echo $row["publication_date"]; ?></td>
                                <!-- <td>
                                    <form method="post">
                                        <input type="hidden" name="article_id" value="<?php echo $row["id"]; ?>">
                                        <input type="submit" name="delete" value="Delete">
                                    </form>
                                </td> -->
                            </tr>
                        <?php } ?>
                    </table><?php
                        } else {
                            echo "0 results";
                        }
                        break;
                    default:
                        break;
                }
                // if (isset($_POST['delete'])) {
                //     if (isset($_POST['researcher_id'])) {
                //         $id = $_POST['researcher_id'];
                //         $table = 'researcher';
                //     } elseif (isset($_POST['article_id'])) {
                //         $id = $_POST['article_id'];
                //         $table = 'article';
                //     }
                //     $sql = "DELETE FROM $table WHERE id = $id";
                //     if (mysqli_query($conn, $sql)) {
                //         echo "Record deleted successfully";
                //     } else {
                //         echo "Error deleting record: " . mysqli_connect_error();
                //     }
                // }
                mysqli_close($conn);
            } ?>
</body>

</html>