source Ozeki.Libs.Rest.tcl


set configuration [ Configuration new ]
$configuration setUsername "http_user" 
$configuration setPassword "qwe123"
$configuration setApiUrl "http://127.0.0.1:9509/api"

set msg [ Message new ]
$msg setToAddress "+36201111111"
$msg setText "Hello world 1"
$msg setTimeToSend "2021-08-03 12:00:00"

set api [ MessageApi new $configuration ]

set result [ $api send $msg ]

puts [ $result toString ]