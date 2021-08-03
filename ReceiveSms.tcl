source Ozeki.Libs.Rest.tcl


set configuration [ Configuration new ]
$configuration setUsername "http_user" 
$configuration setPassword "qwe123"
$configuration setApiUrl "http://127.0.0.1:9509/api"

set api [ MessageApi new $configuration ]

set result [ $api downloadIncoming ]

puts [ $result toString ]

for { set i 0 } { $i < [ llength [ $result getMessages ] ] } { incr i } {
    puts [ [ lindex [ $result getMessages ] $i ] toString ]
}