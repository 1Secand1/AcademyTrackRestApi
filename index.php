<?php
header('Content-Type: application/json');

require 'connect.php';
require 'function.php';

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    header('HTTP/1.1 200 OK');
    exit();
}

$url = isset($_GET['q']) ? rtrim($_GET['q'], '/') : '';
$urlList = explode('/',$url);

$router = $urlList[0];
$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestData = getData($requestMethod);

$routeFilePath = 'routers/' . $router . '.php';
$fullPathToRoutingFile = realpath(dirname(__FILE__)) . '/' . $routeFilePath; 

if (file_exists($fullPathToRoutingFile)) {
    include_once $fullPathToRoutingFile; 
    route($requestMethod, $urlList, $requestData,$connect);
} else {
    echo '404';
}
