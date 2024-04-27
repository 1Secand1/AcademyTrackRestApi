<?php
$connect = mysqli_connect('db', 'root', 'example', 'academytrack');

if (!$connect ) {
  http_response_code(500);
  die('Failed to connect to the database');
}