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
            $name = $requestData->body->name;
            $surname = $requestData->body->surname;
            $patronymic = $requestData->body->patronymic;
            $codeGroupe = $requestData->body->codeGroupe;
            
            $userId = executeQuery($connect, 
            "SELECT user_id FROM students WHERE surname = ? AND name = ? AND patronymic = ?", "sss", 
            $surname, $name, $patronymic)->fetch_assoc()['user_id'];

            if (is_null(!$userId)) {
                sendJsonResponse(404, ['error' => 'User not found']);
            }

            
            $groupIdResult = executeQuery($connect, "SELECT id FROM groups WHERE group_code = ?", "s", $codeGroupe);
            
            if (!$groupIdResult) {
                sendJsonResponse(500, ['error' => 'An error occurred while fetching the group id']);
            }
            
            $groupId = $groupIdResult->fetch_assoc()['id'];
            if (!$groupId) {
                sendJsonResponse(404, ['error' => 'Group not found']);
            }
            
            $insertionResult = executeQuery($connect, 
            "INSERT INTO students(name, surname, patronymic, group_id) 
            VALUES (?, ?, ?, ?)", "sssi", 
            $name, $surname, $patronymic, $groupId);
            
            if ($insertionResult) {
                sendJsonResponse(201, ['status' => 'success']);
            } else {
                sendJsonResponse(500, ['error' => 'Could not insert user', 'db_error' => $connect->error]);
            }
        break;

        case 'GET':
            $query = 
                "SELECT 
                    students.surname,
                    students.name,
                    students.patronymic,
                    groups.group_code AS groupCode,
                    groups.year_of_entry AS yearOfEntry,
                    groups.year_of_issue AS yearOfIssue
                FROM 
                    students
                JOIN groups ON students.group_id = groups.id";
        
            $filter = $requestData->parameters["groupCode"] ?? '';
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
                        'surname' => $row['surname'],
                        'name' => $row['name'],
                        'patronymic' => $row['patronymic'],
                        'groupCode' => $row['groupCode'],
                        'yearOfEntry' => $row['yearOfEntry'],
                        'yearOfIssue' => $row['yearOfIssue'],
                    ];
                }
            }
        
            sendJsonResponse(200, $students);
        break;

        default:
            sendJsonResponse(405, ['error' => 'Method Not Allowed']);
        break;
    }
}
