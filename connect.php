<?php
$connect = mysqli_connect('localhost', 'root', 'root', 'AcademyTrack');
if (!$connect ) {
  http_response_code(500);
  die('Failed to connect to the database');
}