<?php

function route($requestMethod, $urlList, $requestData, $connect) {
    if ($requestMethod !== 'POST') {
        sendJsonResponse(405, ['error' => 'Method Not Allowed']);
    }

    if ($requestData->body == null) {
        sendJsonResponse(400, ['error' => 'Bad Request']);
    }

    $personId = $requestData->body->personId;
    $role = $requestData->body->role;
    $login = $requestData->body->login;
    $password = $requestData->body->password;

    if (executeQuery($connect, "SELECT id FROM person WHERE id = ?", "i", $personId)->num_rows === 0) {
        sendJsonResponse(404, ['error' => 'Person ID does not exist']);
    }

    if (executeQuery($connect, "SELECT person_id FROM users WHERE person_id = ?", "i", $personId)->num_rows > 0) {
        sendJsonResponse(409, ['error' => 'This person is already in the system']);
    }
    
    if (executeQuery($connect, "SELECT person_id FROM users WHERE login = ?", "s", $login)->num_rows > 0) {
        sendJsonResponse(409, ['error' => 'A user with this login already exists']);
    }

    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    $insertSuccess = executeQuery($connect, "INSERT INTO users (person_id, role, login, password) VALUES (?, ?, ?, ?)", "isss", $personId, $role, $login, $passwordHash);
    
    if (!$insertSuccess) {
        sendJsonResponse(500, ['error' => 'Could not insert user', 'db_error' => $connect->error]);
    } else {
        sendJsonResponse(201, ['status' => 'success']);
    }
}


