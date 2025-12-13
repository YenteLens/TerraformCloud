<?php
$bucket = "yentelensfinalproject";
$uploadDir = "/tmp/";
$fileName = basename($_FILES["file"]["name"]);
$tmpPath = $_FILES["file"]["tmp_name"];

/* Upload to S3 */
$cmd = "aws s3 cp $tmpPath s3://$bucket/$fileName";
exec($cmd, $output, $result);

if ($result !== 0) {
    die("S3 upload failed");
}

/* Save filename to MySQL */
$mysqli = new mysqli("localhost", "uploaduser", "uploadpass", "uploaddb");
if ($mysqli->connect_error) {
    die("DB connection failed");
}

$stmt = $mysqli->prepare("INSERT INTO uploads (filename) VALUES (?)");
$stmt->bind_param("s", $fileName);
$stmt->execute();

echo "File uploaded successfully";
?>
