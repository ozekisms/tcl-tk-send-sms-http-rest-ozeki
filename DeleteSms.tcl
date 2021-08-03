source Ozeki.Libs.Rest.tcl


set configuration [ Configuration new ]
$configuration setUsername "http_user" 
$configuration setPassword "qwe123"
$configuration setApiUrl "http://127.0.0.1:9509/api"

set msg [ Message new ]
$msg setID "e96f3598-b4d2-4a07-95a3-0a49313f6244"

set api [ MessageApi new $configuration ]

set result [ $api delete [ Folder NotSent ] $msg ]

puts [ $result toString ]