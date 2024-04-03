<?php

function route($requestMethod, $urlList, $requestData, $connect) {
    if ($requestMethod !== "GET") {
       sendJsonResponse(405, ['error' => 'Method Not Allowed']);
    }
    
    $token = substr(getallheaders()['Authorization'],7);
    $userID = executeQuery($connect, "SELECT user_id FROM tokens WHERE value = ?", "s", $token)->fetch_assoc()['user_id'];
    
    if (is_null($userID)) {
      sendJsonResponse(403, ['error' => 'Forbidden']);
    }

    $result = executeQuery($connect, 
     "SELECT 
        subjects.name AS subjectName, 
        groups.group_code AS groupCode
      FROM 
        teacher_group_subject
      JOIN subjects 
        ON teacher_group_subject.subjects_id = subjects.id
      JOIN groups 
        ON teacher_group_subject.group_id = groups.id
      WHERE 
        teacher_group_subject.teacher_id = ?",
        "i", $userID
    );
        
    $values = [];

    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $values[] = $row;
        }
        echo json_encode($values); 
    } 
}