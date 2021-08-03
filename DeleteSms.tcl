source Ozeki.Libs.Rest.tcl


set configuration [ Configuration new ]
$configuration setUsername "http_user" 
$configuration setPassword "qwe123"
$configuration setApiUrl "http://127.0.0.1:9509/api"

set msg [ Message new ]
$msg setID "fef636bc-b17f-4bb6-911a-087e3dc677fc"

set api [ MessageApi new $configuration ]

set result [ $api delete [ Folder Inbox ] $msg ]

puts $result