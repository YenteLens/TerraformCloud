<?php
$bucket = "yentelenspublic";

/* Connect to MySQL */
$mysqli = new mysqli("localhost", "uploaduser", "uploadpass", "uploaddb");
if ($mysqli->connect_error) {
    die("DB connection failed");
}

/* Fetch all uploads */
$result = $mysqli->query(
    "SELECT filename, description FROM uploads ORDER BY uploaded_at DESC"
);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>File List</title>
</head>
<body>

<h2>Uploaded Files</h2>

<table border="1" cellpadding="6" cellspacing="0">
    <tr>
        <th>Filename</th>
        <th>Description</th>
        <th>Download</th>
    </tr>

    <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?php echo htmlspecialchars($row["filename"], ENT_QUOTES, "UTF-8"); ?></td>
            <td><?php echo htmlspecialchars($row["description"], ENT_QUOTES, "UTF-8"); ?></td>
            <td>
                <a
                    href="https://<?php echo $bucket; ?>.s3.amazonaws.com/<?php echo rawurlencode($row["filename"]); ?>"
                    download
                >
                    Download
                </a>
            </td>
        </tr>
    <?php endwhile; ?>

</table>

</body>
</html>
