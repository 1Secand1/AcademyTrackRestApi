<?php

function route($requestMethod, $urlList, $requestData, $connect) {
    if ($requestMethod !== 'POST') {
        sendJsonResponse(405, ['error' => 'Method Not Allowed']);
        return; 
    }

    $login = $requestData->body->login;
    $password = $requestData->body->password;

    $stmt = $connect->prepare("SELECT id, password FROM users WHERE login = ?");
    $stmt->bind_param("s", $login);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if ($user && password_verify($password, $user['password'])) {
        
        $userId = $user['id'];
        $token = bin2hex(random_bytes(100)); // Генерируем безопасный токен

        $stmt = $connect->prepare("INSERT INTO tokens (user_id, value) VALUES (?, ?)");
        $stmt->bind_param("is", $userId, $token);

        if ($stmt->execute()) {
            sendJsonResponse(200, ['token' => $token]);
        } else {
            sendJsonResponse(500, ['error' => 'Internal Server Error']);
        }
    } else {
        sendJsonResponse(400, ['error' => 'Invalid login or password']);
    }
}
