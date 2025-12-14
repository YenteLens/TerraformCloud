<?php
$bucket = "yentelenspublic";
$uploadDir = "/tmp/";
$fileName = basename($_FILES["file"]["name"]);
$tmpPath = $_FILES["file"]["tmp_name"];

// Safely escape all paths
$tmpPathEscaped = escapeshellarg($tmpPath);
$fileNameEscaped = escapeshellarg($fileName);
$bucketEscaped   = escapeshellarg($bucket);

/* Upload to S3 */
$cmd = "aws s3 cp $tmpPathEscaped s3://$bucketEscaped/$fileNameEscaped 2>&1";
exec($cmd, $output, $result);

if ($result !== 0) {
    echo "S3 upload failed: ";
    print_r($output);
    die();
}

/* Save filename to MySQL */
$mysqli = new mysqli("localhost", "uploaduser", "uploadpass", "uploaddb");
if ($mysqli->connect_error) {
    die("DB connection failed");
}

$stmt = $mysqli->prepare("INSERT INTO uploads (filename) VALUES (?)");
$stmt->bind_param("s", $fileNameEscaped);
$stmt->execute();

echo "File uploaded successfully";
?>