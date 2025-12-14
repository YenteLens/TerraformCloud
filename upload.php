<?php
$bucket = "yentelenspublic";
$fileName = basename($_FILES["file"]["name"]);
$tmpPath = $_FILES["file"]["tmp_name"];

/* NEW: get description */
$description = $_POST["description"] ?? "";

// Escape shell arguments (S3 upload only)
$tmpPathEscaped = escapeshellarg($tmpPath);
$fileNameEscapedShell = escapeshellarg($fileName);
$bucketEscaped = escapeshellarg($bucket);

/* Upload to S3 */
$cmd = "aws s3 cp $tmpPathEscaped s3://$bucketEscaped/$fileNameEscapedShell 2>&1";
exec($cmd, $output, $result);

if ($result !== 0) {
    echo "S3 upload failed: ";
    print_r($output);
    die();
}

/* Save filename + description to MySQL */
$mysqli = new mysqli("localhost", "uploaduser", "uploadpass", "uploaddb");
if ($mysqli->connect_error) {
    die("DB connection failed");
}

$stmt = $mysqli->prepare(
    "INSERT INTO uploads (filename, description) VALUES (?, ?)"
);
$stmt->bind_param("ss", $fileName, $description);
$stmt->execute();

echo "File uploaded successfully";
?>
