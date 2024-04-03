<?php
function getPosts($connect,$id = null){
    $query = $id 
      ? "SELECT * FROM `student` WHERE 'id' = '$id'" 
      : "SELECT * FROM `student`";
    
    $postsResult = mysqli_query($connect,$query);
    $posts = [];
    
    while ($post = mysqli_fetch_assoc($postsResult)) {
      $posts[] = $post;
    }
    
    return $posts;
}

function getData($method){
    $data = new stdClass();

    if ($method === 'POST') {
        $json = file_get_contents('php://input');
        $data->body = json_decode($json);

        if (json_last_error() !== JSON_ERROR_NONE) {
            sendJsonResponse(400, ['error' => 'Bad Request: JSON parsing error']);
        }
    }

    $data->parameters = array_filter($_GET, function ($key) {
        return $key !== 'q';
    }, ARRAY_FILTER_USE_KEY);

    return $data;
}

function executeQuery($connect, $query, $types = '', ...$params) {
    if (!$connect) {
        sendJsonResponse(500, ['error' => 'Database connection error']);
        return;
    }
  
    $stmt = $conтов nect->prepare($query);
    if (!$stmt) {
        sendJsonResponse(500, ['error' => 'Failed to prepare statement', 'db_error' => $connect->error]);
        return;
    }
    
    if ($types) {
        $stmt->bind_param($types, ...$params);
    }
    
    if (!$stmt->execute()) {
        sendJsonResponse(500, ['error' => 'Failed to execute statement', 'db_error' => $stmt->error]);
        return;
    }
  
    if (strtoupper(substr($query, 0, 6)) === 'SELECT') {
        return $stmt->get_result();
    } else {
        return $stmt->affected_rows > 0;
    }
}

function sendJsonResponse($status, $message) {
  http_response_code($status);
  echo json_encode($message);
  exit;
}