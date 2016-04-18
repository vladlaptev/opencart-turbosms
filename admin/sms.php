<?php

/** 
* Данный пример предоставляет возможность отправлять СМС сообщения 
* с подменой номера, просматривать остаток кредитов пользователя, 
* просматривать статус отправленных сообщений. 
* ----------------------------------------------------------------- 
* Для работы данного примера необходимо подключить SOAP-расширение. 
* 
*/ 

// Все данные возвращаются в кодировке UTF-8 
header ('Content-type: text/html; charset=utf-8'); 

// Подключаемся к серверу 
$client = new SoapClient ('http://turbosms.in.ua/api/wsdl.html'); 

// Можно просмотреть список доступных функций сервера 
 

// Данные авторизации 
$auth = Array ( 
'login' => 'login', 
'password' => 'password' 
); 

// Авторизируемся на сервере 
$result = $client->Auth ($auth); 

// Результат авторизации 
//echo $result->AuthResult; 

// Получаем количество доступных кредитов 
$result = $client->GetCreditBalance (); 
echo $result->GetCreditBalanceResult; 



/*
// Текст сообщения ОБЯЗАТЕЛЬНО отправлять в кодировке UTF-8 
$text = iconv ('windows-1251', 'utf-8', 'Это сообщение будет доставлено на указанный номер'); 

// Данные для отправки 
$sms = Array ( 
'sender' => 'Rassilka', 
'destination' => '+380955258006', 
'text' => $text 
); 

// Отправляем сообщение на один номер. 
// Подпись отправителя может содержать английские буквы и цифры. Максимальная длина - 11 символов. 
// Номер указывается в полном формате, включая плюс и код страны 
$result = $client->SendSMS ($sms); 

echo $result;

*/
/*
// Текст сообщения ОБЯЗАТЕЛЬНО отправлять в кодировке UTF-8 
$text = iconv ('windows-1251', 'utf-8', 'Это сообщение будет доставлено на указанный номер'); 

// Данные для отправки 
$sms = Array ( 
'sender' => 'Rassilka', 
'destination' => '+380XXXXXXXXX', 
'text' => $text 
); 

// Отправляем сообщение на один номер. 
// Подпись отправителя может содержать английские буквы и цифры. Максимальная длина - 11 символов. 
// Номер указывается в полном формате, включая плюс и код страны 
$result = $client->SendSMS ($sms); 

// Отправляем сообщение на несколько номеров. 
// Номера разделены запятыми без пробелов. 
$sms = Array ( 
'sender' => 'Rassilka', 
'destination' => '+380XXXXXXXX1,+380XXXXXXXX2,+380XXXXXXXX3', 
'text' => $text 
); 
$result = $client->SendSMS ($sms); 

// Выводим результат отправки. 
echo $result->SendSMSResult->ResultArray[0] . '
'; 

// ID первого сообщения 
echo $result->SendSMSResult->ResultArray[1] . '
'; 

// ID второго сообщения 
echo $result->SendSMSResult->ResultArray[2] . '
'; 

// Отправляем сообщение с WAPPush ссылкой 
// Ссылка должна включать http:// 
$sms = Array ( 
'sender' => 'Rassilka', 
'destination' => '+380XXXXXXXXX', 
'text' => $text, 
'wappush' => 'http://super-site.com' 
); 

$result = $client->SendSMS ($sms); 

// Запрашиваем статус конкретного сообщения по ID 
$sms = Array ('MessageId' => 'c9482a41-27d1-44f8-bd5c-d34104ca5ba9'); 
$status = $client->GetMessageStatus ($sms); 
echo $status->GetMessageStatusResult . '
'; 

// Запрашиваем массив ID сообщений, у которых неизвестен статус отправки 
$result = $client->GetNewMessages (); 

// Есть сообщения 
if (!empty ($result->GetNewMessagesResult->ResultArray)) { 
echo '
';

    print_r ($result->GetNewMessagesResult->ResultArray);

    echo '
'; 

// Запрашиваем статус каждого сообщения по ID 
foreach ($result->GetNewMessagesResult->ResultArray as $msg_id) { 
$sms = Array ('MessageId' => $msg_id); 
$status = $client->GetMessageStatus ($sms); 
echo '' . $msg_id . ' - ' . $status->GetMessageStatusResult . '
'; 
} 
} 

*/

?>