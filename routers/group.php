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
            $codeGroupe = $requestData->body->codeGroupe;
            $yearOfEntry = $requestData->body->yearOfEntry;
            $yearOfIssue = $requestData->body->yearOfIssue;
            
            if (executeQuery($connect, "SELECT group_code FROM groups WHERE group_code = ?", "s", $codeGroupe)->num_rows > 0) {
                sendJsonResponse(409, 
                ['error' => 'A groupe with this codeGroupe already exists']);
            }
            
            $insertionResult = executeQuery($connect,
            "INSERT INTO groups(group_code, year_of_entry, year_of_issue) VALUES (?, ?, ?)",
            "sss", $codeGroupe, $yearOfEntry, $yearOfIssue);

            if ($insertionResult) {
                sendJsonResponse(201, ['status' => 'success']);
            }else{
                sendJsonResponse(500, ['error' => 'Could not insert user', 'db_error' => $connect->error]);
            }
         break;

        case 'GET':
            $groupsData = executeQuery($connect, "SELECT * FROM groups");

            $groups = [];
            while ($row = $groupsData->fetch_assoc()) {
                $groups[] = [
                    'groupCode' => $row['group_code'],
                    'yearOfEntry' => $row['year_of_entry'],
                    'yearOfIssue' => $row['year_of_issue'],
                ];
            }

            sendJsonResponse(200, $groups);
        break;

        default:
            sendJsonResponse(405, ['error' => 'Method Not Allowed']);
        break;
    }
}