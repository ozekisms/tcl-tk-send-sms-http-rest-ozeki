package require TclOO
package require uuid
package require base64
package require http
package require json 1.3.3

oo::class create Configuration {
    variable Username Password ApiUrl
    
    method getUsername { } {
        return $Username
    }
    
    method getPassword { } {
        return $Password
    }
    
    method getApiUrl { } {
        return $ApiUrl
    }
    
    method setUsername { username } {
        set Username $username
    }
    
    method setPassword { password } {
        set Password $password
    }
    
    method setApiUrl { apiUrl } {
        set ApiUrl $apiUrl
    }
}

oo::class create Message {
    
    variable ID
    variable FromConnection
    variable FromAddress
    variable FromStation
    variable ToConnection
    variable ToAddress
    variable ToStation
    variable Text
    variable CreateDate
    variable ValidUntil
    variable TimeToSend
    variable IsSubmitReportRequested
    variable IsDeliveryReportRequested
    variable IsViewReportRequested
    variable Tags
    
    constructor { } {
        set ID [ uuid::uuid generate ]
        set FromConnection ""
        set FromAddress ""
        set FromStation ""
        set ToConnection ""
        set ToAddress ""
        set ToStation ""
        set Text ""
        set CreateDate [ clock format [ clock seconds ] -format {%Y-%m-%dT%H:%M:%S} ]
        set ValidUntil [ clock format [ expr [ clock seconds ] + 604800  ] -format {%Y-%m-%dT%H:%M:%S} ]
        set TimeToSend [ clock format [ clock seconds ] -format {%Y-%m-%dT%H:%M:%S} ]
        set IsSubmitReportRequested true
        set IsDeliveryReportRequested true
        set IsViewReportRequested true
        set Tags [list]
    }
    
    method setID { id } {
        set ID $id
    }
    
    method setFromConnection { fromConnection } {
        set FromConnection $fromConnection
    }
    
    method setFromAddress { fromAdress } {
        set FromAddress $fromAdress
    }
    
    method setFromStation { fromStation } {
        set FromStation $fromStation
    }
    
    method setToConnection { toConnection } {
        set ToConnection $toConnection
    }
    
    method setToAddress { toAdress } {
        set ToAddress $toAdress
    }
    
    method setToStation { toStation } {
        set ToStation $toStation
    }
    
    method setText { text } {
        set Text $text
    }
    
    method setCreateDate { createDate } {
        set CreateDate $createDate
    }
    
    method setValidUntil { validUntil } {
        set ValidUntil $validUntil
    }
    
    method setTimeToSend { timeToSend } {
        set TimeToSend $timeToSend
    }
    
    method setIsSubmitReportRequested { isSubmitReportRequested } {
        set IsSubmitReportRequested $isSubmitReportRequested
    }
    
    method setIsDeliveryReportRequested { isDeliveryReportRequested } {
        set IsDeliveryReportRequested $isDeliveryReportRequested
    }
    
    method setIsViewReportRequested { isViewReportRequested } {
        set IsViewReportRequested $isViewReportRequested
    }
    
    method getID { } {
        return $ID
    }
    
    method getFromConnection { } {
        return $FromConnection
    }
    
    method getFromAddress { } {
        return $FromAddress
    }
    
    method getFromStation { } {
        return $FromStation
    }
    
    method getToConnection { } {
        return $ToConnection
    }
    
    method getToAddress { } {
        return $ToAddress
    }
    
    method getToStation { } {
        return $ToStation
    }
    
    method getText { } {
        return $Text
    }
    
    method getCreateDate { } {
        return $CreateDate
    }
    
    method getValidUntil { } {
        return $ValidUntil
    }
    
    method getTimeToSend { } {
        return $TimeToSend
    }
    
    method getIsSubmitReportRequested { } {
        return $IsSubmitReportRequested
    }
    
    method getIsDeliveryReportRequested { } {
        return $IsDeliveryReportRequested
    }
    
    method getIsViewReportRequested { } {
        return $IsViewReportRequested
    }

    method addTag { name value } {
        lappend Tags "{\"name\": \"$name\", \"value\": \"$value\"}" 
    }
    
    method getTags { } {
        return $Tags
    }
    
    method toString {} {
        return "$FromAddress->$ToAddress '$Text'"
    }
    
    method getJSON { } {
        set json "\{"
        
        set json "$json\"message_id\":\"$ID\""
        
        if { $FromConnection != "" } {
            set json "$json,\"from_connection\":\"$FromConnection\""
        }
        
        if { $FromAddress != "" } {
            set json "$json,\"from_address\":\"$FromAddress\""
        }
        
        if { $FromStation != "" } {
            set json "$json,\"from_station\":\"$FromStation\""
        }
        
        if { $ToConnection != "" } {
            set json "$json,\"to_connection\":\"$ToConnection\""
        }
        
        if { $ToAddress != "" } {
            set json "$json,\"to_address\":\"$ToAddress\""
        }
        
        if { $ToStation != "" } {
            set json "$json,\"to_station\":\"$ToStation\""
        }
        
        if { $Text != "" } {
            set json "$json,\"text\":\"$Text\""
        }
        
        if { $CreateDate != "" } {
            set json "$json,\"create_date\":\"$CreateDate\""
        }
        
        if { $ValidUntil != "" } {
            set json "$json,\"valid_until\":\"$ValidUntil\""
        }
        
        if { $TimeToSend != "" } {
            set json "$json,\"time_to_send\":\"$TimeToSend\""
        }
        
        if { $IsSubmitReportRequested != "" } {
            set json "$json,\"submit_report_requested\":$IsSubmitReportRequested"
        }
        
        if { $IsDeliveryReportRequested != "" } {
            set json "$json,\"delivery_report_requested\":$IsDeliveryReportRequested"
        }
        
        if { $IsViewReportRequested != "" } {
            set json "$json,\"view_report_requested\":$IsViewReportRequested"
        }
        
        if { [ llength $Tags ] != 0 } {
            set tags_list "\["
            for {set i 0} {$i < [ llength $Tags ]} {incr i} {
                set tag [ lindex $Tags $i ]
                if {$i == 0} {
                    set tags_list "$tags_list$tag"
                } else {
                    set tags_list "$tags_list,$tag"
                }
            }
            set tags_list "$tags_list\]"
            set json "$json,\"tags\":$tags_list"
        }
        
        set json "$json\}"
        
        return $json

    }
}
    
proc Folder key {
    array set constants {
        Inbox "inbox"
        Outbox "outbox"
        Sent "sent"
        NotSent "notsent"
        Deleted "deleted"
    }
    return $constants($key)
}

proc DeliveryStatus key {
    array set constants {
        Success "Success"
        Failed "Failed"
    }
    return $constants($key)
}

oo::class create MessageSendResult {
    variable Message Status ResponseMessage
    
    constructor { message status responseMessage } {
        set Message $message
        set Status $status
        set ResponseMessage $responseMessage
    }
    
    method setMessage { message } {
        set Message $message
    }
    
    method setStatus { status } {
        set Status $status
    }
    
    method setResponseMessage { responseMessage } {
        set ResponseMessage $responseMessage
    }
    
    method getMessage { } {
        return $Message
    }
    
    method getStatus { } {
        return $Status
    }
    
    method getResponseMessage { } {
        return $ResponseMessage
    }
    
    method toString { } {
        set msg [ $Message toString ]
        return "$Status, $msg"
    } 
}

oo::class create MessageSendResults {
    
    variable Results TotalCount SuccessCount FailedCount
    
    constructor { totalCount successCount failedCount } {
        set Results [list]
        set TotalCount $totalCount
        set SuccessCount $successCount
        set FailedCount $failedCount
    }
    
    method addResult {result} {
        lappend Results $result
    }
    
    method getResults { } {
        return $Results
    }
    
    method getTotalCount { } {
        return $TotalCount
    }
    
    method getSuccessCount { } {
        return $SuccessCount
    }
    
    method getFailedCount { } {
        return $FailedCount
    }
    
    method setTotalCount { totalCount } {
        set TotalCount $totalCount
    }
    
    method setSuccessCount { successCount } {
        set SuccessCount $successCount
    }
    
    method setFailedCount { failedCount } {
        set FailedCount $failedCount
    }
    
    method toString { } {
        return "Total: $TotalCount. Success:  $SuccessCount. Failed: $FailedCount."
    }
    
}

oo::class create MessageDeleteResult {
    variable Folder MessageIdsRemoveSucceeded MessageIdsRemoveFailed TotalCount SuccessCount FailedCount
    
    constructor { folder } {
        set Folder $folder
        set MessageIdsRemoveSucceeded [list]
        set MessageIdsRemoveFailed [list]
        set TotalCount 0
        set SuccessCount 0
        set FailedCount 0
    }
    
    method addIdRemoveSucceeded { id } {
        lappend MessageIdsRemoveSucceeded $id
        set TotalCount [ expr $TotalCount + 1 ]
        set SuccessCount [ expr $SuccessCount + 1 ]
    }
    
    method addIdRemoveFailed { id } {
        lappend MessageIdsRemoveFailed $id
        set TotalCount [ expr $TotalCount + 1 ]
        set FailedCount [ expr $FailedCount + 1 ]
    }
    
    method getMessageIdsRemoveSucceeded {} {
        return $MessageIdsRemoveSucceeded
    }
    
    method getMessageIdsRemoveFailed {} {
        return $MessageIdsRemoveFailed
    }
    
    method getTotalCount {} {
        return $TotalCount
    }
    
    method getSuccessCount {} {
        return $SuccessCount
    }
    
    method getFailedCount {} {
        return $FailedCount
    }
    
    method toString { } {
        return "Total: $TotalCount. Success: $SuccessCount. Failed: $FailedCount."
    } 
}

oo::class create MessageMarkResult {
    variable Folder MessageIdsMarkSucceeded MessageIdsMarkFailed TotalCount SuccessCount FailedCount
    
    constructor { folder } {
        set Folder $folder
        set MessageIdsMarkSucceeded [list]
        set MessageIdsMarkFailed [list]
        set TotalCount 0
        set SuccessCount 0
        set FailedCount 0
    }
    
    method addIdMarkSucceeded { id } {
        lappend MessageIdsMarkSucceeded $id
        set TotalCount [ expr $TotalCount + 1 ]
        set SuccessCount [ expr $SuccessCount + 1 ]
    }
    
    method addIdMarkFailed { id } {
        lappend MessageIdsMarkFailed $id
        set TotalCount [ expr $TotalCount + 1 ]
        set FailedCount [ expr $FailedCount + 1 ]
    }
    
    method getMessageIdsMarkSucceeded {} {
        return $MessageIdsRemoveSucceeded
    }
    
    method getMessageIdsMarkFailed {} {
        return $MessageIdsRemoveFailed
    }
    
    method getTotalCount {} {
        return $TotalCount
    }
    
    method getSuccessCount {} {
        return $SuccessCount
    }
    
    method getFailedCount {} {
        return $FailedCount
    }
    
    method toString { } {
        return "Total: $TotalCount. Success: $SuccessCount. Failed: $FailedCount."
    } 
}

oo::class create MessageReceiveResult {
    variable Messages Folder Limit
    
    constructor {folder limit} {
        set Folder folder
        set Limit limit
        set Messages [list]
    }
    
    method addMessage { message } {
        lappend Messages $message
    }
    
    method getMessages { } {
        return $Messages
    }
    
    method setFolder { folder } {
        set Folder $folder
    }
    
    method setLimit { limit } {
        set Limit $limit
    }
    
    method getFolder { } {
        return $Folder
    }
    
    method getLimit { } {
        return $Limit
    }
    
    method toString { } {
        set count [ llength $Messages ]
        return "Message count : $count."
    }
}

oo::class create MessageApi {
    variable _configuration
    
    constructor { configuration } {
        set _configuration $configuration
    }
    
    method createUriToSendSms { url } {
        set baseUrl [ lindex [ split $url "?" ] 0 ]
        return "$baseUrl?action=sendmsg"
    }
    
    method createUriToDeleteSms { url } {
        set baseUrl [ lindex [ split $url "?" ] 0 ]
        return "$baseUrl?action=deletemsg"
    }
    
    method createUriToMarkSms { url } {
        set baseUrl [ lindex [ split $url "?" ] 0 ]
        return "$baseUrl?action=markmsg"
    }
    
    method createUriToReceiveSms { url folder } {
        set baseUrl [ lindex [ split $url "?" ] 0 ]
        return "$baseUrl?action=receivemsg&folder=$folder"
    }
    
    method createAuthorizationHeader { username password } {
        set usernamePassword "$username:$password"
        set usernamePasswordEncoded [ binary encode base64 $usernamePassword ]
        return "Basic $usernamePasswordEncoded"
    }
    
    method createRequestBody { messages } {
        set json "\{\"messages\":\["
        
        for {set i 0} {$i < [ llength $messages ]} {incr i} {
            set msg [ [ lindex $messages $i ] getJSON ]
            if {$i == 0} {
                set json "$json$msg"
            } else {
                set json "$json,$msg"
            }
        }
        
        set json "$json\]\}"
        
        return $json
    }
    
    method createRequestBodyToManipulate { folder messages } {
        set json "\{\"folder\":\"$folder\",\"message_ids\":\["
        
        for {set i 0} {$i < [ llength $messages ]} {incr i} {
            set id [ [ lindex $messages $i ] getID ]
            if {$i == 0} {
                set json "$json\"$id\""
            } else {
                set json "$json,\"$id\""
            }
        }
        
        set json "$json\]\}"
        
        return $json
    }
    
    method send { messages } {
        set authorizationHeader [ my createAuthorizationHeader [ $_configuration getUsername ] [ $_configuration getPassword ] ]
        set requestBody [ my createRequestBody $messages ]
        return [ my getResponseSend [ my doRequestPost [ my createUriToSendSms [ $_configuration getApiUrl ] ] $authorizationHeader $requestBody ] ] 
    }
    
    method delete { folder  messages } {
        set authorizationHeader [ my createAuthorizationHeader [ $_configuration getUsername ] [ $_configuration getPassword ] ]
        set requestBody [ my createRequestBodyToManipulate $folder $messages ]
        return [ my getResponseManipulate [ my doRequestPost [ my createUriToDeleteSms [ $_configuration getApiUrl ] ] $authorizationHeader $requestBody ] "delete" $messages ]
    }
    
    method mark { folder  messages } {
        set authorizationHeader [ my createAuthorizationHeader [ $_configuration getUsername ] [ $_configuration getPassword ] ]
        set requestBody [ my createRequestBodyToManipulate $folder $messages ]
        return [ my getResponseManipulate [ my doRequestPost [ my createUriToMarkSms [ $_configuration getApiUrl ] ] $authorizationHeader $requestBody ] "mark" $messages ]
    }
    
    method downloadIncoming { } {
        set authorizationHeader [ my createAuthorizationHeader [ $_configuration getUsername ] [ $_configuration getPassword ] ]
        set result [ my getResponseReceive [ my doRequestGet [ my createUriToReceiveSms [ $_configuration getApiUrl ] [ Folder Inbox ] ] $authorizationHeader ] ]
        set deleteResult [ my delete [ Folder Inbox ]  [ $result getMessages ] ]
        return $result
    }
    
    method doRequestPost { url authorizationHeader requestBody } {
        set headers [ list Authorization $authorizationHeader ]
        set response [ http::geturl $url  -headers $headers -query $requestBody -type "application/json" ]
        return [ http::data $response ]
    }
    
    method doRequestGet { url authorizationHeader } {
        set headers [ list Authorization $authorizationHeader ]
        set response [ http::geturl $url  -headers $headers ]
        return [ http::data $response ]
    }
    
    method getResponseSend { response } {
        set json [ ::json::json2dict $response ];
        
        set data [ dict get $json data ]
        
        set totalCount [ dict get $data total_count ]
        set successCount [ dict get $data success_count ]
        set failedCount [ dict get $data failed_count ]
        
        set messages [ dict get $data messages ]
        
        set results [ MessageSendResults new $totalCount $successCount $failedCount ]
        
        for {set i 0} {$i < [ llength $messages ]} {incr i} {
           
           set message [ lindex $messages $i ]
            
            set msg [ Message new ]
            
            if { [ dict exists $message message_id ] } { 
                $msg setID [dict get $message message_id ]
            }
           
            if { [ dict exists $message from_connection ] } {
                $msg setFromConnection [ dict get $message from_connection ]
            }

            if { [ dict exists $message from_address ] } {  
                $msg  setFromAddress [ dict get $message from_address ]
            }
            
            if { [ dict exists $message from_station ] } { 
                $msg setFromStation [dict get $message from_station ]
            }
            
            if { [ dict exists $message to_connection ] } { 
                $msg setToConnection [dict get $message to_connection ]
            }
            
            if { [ dict exists $message to_address ] } { 
                $msg setToAddress [dict get $message to_address ]
            }
        
            if { [ dict exists $message to_station ] } { 
                $msg setToStation [dict get $message to_station ]
            }
            
            if { [ dict exists $message text ] } { 
                $msg setText [dict get $message text ]
            }
            
            if { [ dict exists $message create_date ] } { 
                $msg setCreateDate [dict get $message create_date ]
            }
            
            if { [ dict exists $message valid_until ] } { 
                $msg setValidUntil [dict get $message valid_until ]
            }
            
            if { [ dict exists $message time_to_send ] } { 
                $msg setTimeToSend [dict get $message time_to_send ]
            }
            
            if { [ dict exists $message submit_report_requested ] } { 
                $msg setIsSubmitReportRequested [dict get $message submit_report_requested ]
            }
            
            if { [ dict exists $message delivery_report_requested ] } { 
                $msg setIsDeliveryReportRequested [dict get $message delivery_report_requested ]
            }
            
            if { [ dict exists $message view_report_requested ] } { 
                $msg setIsViewReportRequested [dict get $message view_report_requested ]
            }
            
            if  { [ dict exists $message tags ] } {
                set tags [ dict get $message tags ]
                
                if { [ llength $tags ] > 0 } {
                    for {set d 0} {$d < [ llength $tags ] } {incr d} {
                        set tag [ lindex $tags $d ]
                        if { [ dict exists $tag name ] } {
                            if { [ dict exists $tag value ] } {
                                $msg addTag [ dict get $tag name ] [ dict get $tag value ]
                            }
                        }
                    }
                }
            }
            
            if { [ dict exists $message status ] } {
                if { [dict get $message status ] == "SUCCESS" } {
                    set status [ DeliveryStatus Success ]
                    set responseMessage ""
                } else {
                    set status [ DeliveryStatus Failed ]
                    set responseMessage [ dict get $message status ]
                }
            }
            
            
            
            set result [ MessageSendResult new $msg $status $responseMessage ]
            
            $results addResult $result
        }
        
        return $results
    }
    
    method getResponseManipulate { response action messages } {
        set json [ ::json::json2dict $response ];
        
        set data [ dict get $json data ]
        
        set folder [ dict get $data folder ]
        
        set message_ids [ dict get $data message_ids ]
        
        if { $action == "mark" } {
            set result [ MessageMarkResult new $folder ] 
            
            for { set i 0 } { $i < [ llength $messages ] } { incr i } {
                set success false
                for { set j 0 } { $j < [ llength $message_ids ] } { incr j } {
                    if { [ [ lindex $messages $i ] getID ] == [ lindex $message_ids $j ] } {
                        set success true
                    }
                }
                if { $success == true } {
                    $result addIdMarkSucceeded [ [ lindex $messages $i ] getID ]
                } else {
                    $result addIdMarkFailed [ [ lindex $messages $i ] getID ]
                }
            }
            
            return $result
        
        } else {
            set result [ MessageDeleteResult new $folder ]
            
            for { set i 0 } { $i < [ llength $messages ] } { incr i } {
                set success false
                for { set j 0 } { $j < [ llength $message_ids ] } { incr j } {
                    if { [ [ lindex $messages $i ] getID ] == [ lindex $message_ids $j ] } {
                        set success true
                    }
                }
                if { $success == true } {
                    $result addIdRemoveSucceeded [ [ lindex $messages $i ] getID ]
                } else {
                    $result addIdRemoveFailed [ [ lindex $messages $i ] getID ]
                }
            }
            
            return $result
        }   
    }
    
    method getResponseReceive { response } {
        set json [ ::json::json2dict $response ];
        
        set data [ dict get $json data ]
        
        set folder [ dict get $data folder ]
        set limit [ dict get $data limit ]
        
        set messages [ dict get $data data ]
        
        set result [ MessageReceiveResult new $folder $limit ]
        
        for {set i 0} {$i < [ llength $messages ]} {incr i} {
           
           set message [ lindex $messages $i ]
            
            set msg [ Message new ]
            
            if { [ dict exists $message message_id ] } { 
                $msg setID [dict get $message message_id ]
            }
           
            if { [ dict exists $message from_connection ] } {
                $msg setFromConnection [ dict get $message from_connection ]
            }

            if { [ dict exists $message from_address ] } {  
                $msg  setFromAddress [ dict get $message from_address ]
            }
            
            if { [ dict exists $message from_station ] } { 
                $msg setFromStation [dict get $message from_station ]
            }
            
            if { [ dict exists $message to_connection ] } { 
                $msg setToConnection [dict get $message to_connection ]
            }
            
            if { [ dict exists $message to_address ] } { 
                $msg setToAddress [dict get $message to_address ]
            }
        
            if { [ dict exists $message to_station ] } { 
                $msg setToStation [dict get $message to_station ]
            }
            
            if { [ dict exists $message text ] } { 
                $msg setText [dict get $message text ]
            }
            
            if { [ dict exists $message create_date ] } { 
                $msg setCreateDate [dict get $message create_date ]
            }
            
            if { [ dict exists $message valid_until ] } { 
                $msg setValidUntil [dict get $message valid_until ]
            }
            
            if { [ dict exists $message time_to_send ] } { 
                $msg setTimeToSend [dict get $message time_to_send ]
            }
            
            if { [ dict exists $message submit_report_requested ] } { 
                $msg setIsSubmitReportRequested [dict get $message submit_report_requested ]
            }
            
            if { [ dict exists $message delivery_report_requested ] } { 
                $msg setIsDeliveryReportRequested [dict get $message delivery_report_requested ]
            }
            
            if { [ dict exists $message view_report_requested ] } { 
                $msg setIsViewReportRequested [dict get $message view_report_requested ]
            }
            
            if  { [ dict exists $message tags ] } {
                set tags [ dict get $message tags ]
                
                if { [ llength $tags ] > 0 } {
                    for {set d 0} {$d < [ llength $tags ] } {incr d} {
                        set tag [ lindex $tags $d ]
                        if { [ dict exists $tag name ] } {
                            if { [ dict exists $tag value ] } {
                                $msg addTag [ dict get $tag name ] [ dict get $tag value ]
                            }
                        }
                    }
                }
            }
            
            if { [ dict exists $message status ] } {
                if { [dict get $message status ] == "SUCCESS" } {
                    set status [ DeliveryStatus Success ]
                    set responseMessage ""
                } else {
                    set status [ DeliveryStatus Failed ]
                    set responseMessage [ dict get $message status ]
                }
            }
            
            $result addMessage $msg
        }
        
        return $result
    }
}