<?php

function route($requestMethod, $urlList, $requestData, $connect) {
    if ($requestMethod !== 'POST') {
        sendJsonResponse(405, ['error' => 'Method Not Allowed']);
    }

    if ($requestData->body == null) {
        sendJsonResponse(400, ['error' => 'Bad Request']);
    }

    $surname = $requestData->body->surname;
    $name = $requestData->body->name;
    $patronymic = $requestData->body->patronymic;
    $role = $requestData->body->role;
    $login = $requestData->body->login;
    $password = $requestData->body->password;

    
    if (executeQuery($connect, "SELECT login FROM users WHERE login = ?", "s", $login)->num_rows > 0) {
        sendJsonResponse(409, ['error' => 'A user with this login already exists']);
    }

    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    $insertSuccess = executeQuery($connect, 
    "INSERT INTO users (surname, name, patronymic, role, login, password) VALUES (?, ?, ?, ?, ?, ?)",
    "ssssss", $surname, $name, $patronymic, $role, $login, $passwordHash);
    
    if (!$insertSuccess) {
        sendJsonResponse(500, ['error' => 'Could not insert user', 'db_error' => $connect->error]);
    } else {
        sendJsonResponse(201, ['status' => 'success']);
    }
}


