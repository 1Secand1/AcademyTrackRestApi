<?php

function route($requestMethod, $urlList, $requestData, $connect) {
    $token = substr(getallheaders()['Authorization'],7);
    $userID = executeQuery($connect, "SELECT user_id FROM tokens WHERE value = ?", "s", $token)->fetch_assoc()['user_id'];
    
    if (is_null($userID)) {
        sendJsonResponse(403, ['error' => 'Forbidden']);
        return;
    }

    switch ($requestMethod) {
        case 'POST':
            $surname = $requestData->body->surname;
            $name = $requestData->body->name;
            $patronymic = $requestData->body->patronymic;
            $codeGroupe = $requestData->body->codeGroupe;
            
            $userId = executeQuery($connect, "SELECT id FROM users WHERE surname = ? AND name = ? AND patronymic = ?", "sss", $surname, $name, $patronymic)->fetch_assoc()['id'];

            if (!$userId) {
                sendJsonResponse(404, ['error' => 'User not found']);
            }

            $userExistsResult = executeQuery($connect, "SELECT user_id FROM students WHERE user_id = ?", "i", $userId);
            
            if ($userExistsResult && $userExistsResult->num_rows > 0) {
                sendJsonResponse(409, ['error' => 'This user already has a group']);
            }
            
            $groupResult = executeQuery($connect, "SELECT id FROM groups WHERE group_code = ?", "s", $codeGroupe);
            
            if (!$groupResult) {
                sendJsonResponse(500, ['error' => 'An error occurred while fetching the group id']);
            }
            
            $groupData = $groupResult->fetch_assoc();
            if (!$groupData) {
                sendJsonResponse(404, ['error' => 'Group not found']);
            }
            
            $group_id = $groupData['id'];
            
            $insertionResult = executeQuery($connect, "INSERT INTO students(user_id, group_id) VALUES (?, ?)", "ii", $userId, $group_id);
            
            if ($insertionResult) {
                sendJsonResponse(201, ['status' => 'success']);
            } else {
                sendJsonResponse(500, ['error' => 'Could not insert user', 'db_error' => $connect->error]);
            }
        break;

        case 'GET':
            $query = 
                "SELECT 
                    users.id AS userId,
                    users.surname,
                    users.name,
                    users.patronymic,
                    groups.group_code AS groupCode,
                    groups.year_of_entry AS yearOfEntry,
                    groups.year_of_issue AS yearOfIssue
                FROM 
                    students
                JOIN users ON students.user_id = users.id
                JOIN groups ON students.group_id = groups.id";
        
            $filter = $requestData->parameters["filter"] ?? '';
            if (!empty($filter)) {
                $query .= " WHERE groups.group_code = ?";
                $result = executeQuery($connect, $query, 's', $filter);
            } else {
                $result = executeQuery($connect, $query);
            }
        
            $students = [];
            if ($result) {
                while ($row = $result->fetch_assoc()) {
                    $students[] = [
                        'userId' => $row['userId'],
                        'surname' => $row['surname'],
                        'name' => $row['name'],
                        'patronymic' => $row['patronymic'],
                        'groupCode' => $row['groupCode'],
                        'yearOfEntry' => $row['yearOfEntry'],
                        'yearOfIssue' => $row['yearOfIssue'],
                    ];
                }
            }
        
            sendJsonResponse(200, ['students' => $students]);
        break;

        default:
            sendJsonResponse(405, ['error' => 'Method Not Allowed']);
        break;
    }
}
