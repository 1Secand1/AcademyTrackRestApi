<?php
$connect = mysqli_connect('localhost', 'REST_API', 'restapipassword', 'study');
if (!$connect ) {
  http_response_code(500);
  die('Failed to connect to the database');
}