source Ozeki.Libs.Rest.tcl


set configuration [ Configuration new ]
$configuration setUsername "http_user" 
$configuration setPassword "qwe123"
$configuration setApiUrl "http://127.0.0.1:9509/api"

set msg1 [ Message new ]
$msg1 setToAddress "+36201111111"
$msg1 setText "Hello world 1"

set msg2 [ Message new ]
$msg2 setToAddress "+36202222222"
$msg2 setText "Hello world 2"

set msg3 [ Message new ] 
$msg3 setToAddress "+36203333333"
$msg3 setText "Hello world 3"

set api [ MessageApi new $configuration ]

set messages [list]
lappend messages $msg1
lappend messages $msg2
lappend messages $msg3

set result [ $api send $messages ]

puts [ $result toString ]