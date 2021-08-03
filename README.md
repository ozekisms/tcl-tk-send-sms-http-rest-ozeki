# Tcl/Tk sms library to send sms with http/rest/json

This TCL/TK sms library enables you to **send** and **receive*** from TCL/TK with http requests. The library uses HTTP Post requests and JSON encoded content to send the text messages to the mobile network1. It connects to the HTTP SMS API of [Ozeki SMS gateway](https://ozeki-sms-gateway.com).

## What is Ozeki SMS Gateway 

The Ozeki SMS Gateway is a powerful yet easy to master gateway software. It is very reliable, and it runs in an environment controlled by the user. It means that it offers outstanding safety for your data. It provides an HTTP SMS API, that allows you to connect to it from local or remote programs. The reason why companies use Ozeki SMS Gateway as their first point of access to the mobile network, is because it provides service provider independence and direct access to the mobile network through wireless connections.

Download: [Ozeki SMS Gateway download page](https://ozeki-sms-gateway.com/p_727-download-sms-gateway.html)

Tutorial: [Tcl/Tk send sms sample and tutorial](https://ozeki-sms-gateway.com/p_870-td-tk-send-sms-with-the-http-rest-api-code-sample.html)


## How to send sms from Tcl/Tk:

**To send sms from Tcl/Tk**
1. [Download Ozeki SMS Gateway](https://ozeki-sms-gateway.com/p_727-download-sms-gateway.html)
2. [Connect Ozeki SMS Gateway to the mobile network](https://ozeki-sms-gateway.com/p_70-mobile-network-connections.html)
3. [Create an HTTP SMS API user](https://ozeki-sms-gateway.com/p_2102-create-an-http-sms-api-user-account.html)
4. Checkout the Github send SMS from Tcl/Tk repository
5. Open the Github SMS send example in Visual Studio
6. Compile the Send SMS console project
7. Check the logs in Ozeki SMS Gateway

### How to install Tcllib on Linux

To install the __Tcllib__ which contains many useful Tcl components, firstly we have to install __fossil__ on our system.

```bash
sudo apt-install fossil
```

After you have installed fossil you can clone the __Tcllib__ library with the following code:

```bash
fossil clone http://core.tcl.tk/tcllib tclib.fossil
```

After the cloning proccess we can continue with extracting and installing __Tllib__.

```bash
mkdir tcllib
cd tcllib
fossil open ../tcllib.fossil
sudo tclsh installer.tcl
```

After the installation process you can test if __Tcllib__ is installed by trying to require one of its components. In this example code we will try to require and use the __uuid__ package of the __Tcllib__

```bash
tclsh
package require uuid
puts ::uuid::uuid generate
```

The output should look like this:

```bash

```

After you are done with these steps you can go forward by cloning this repository and try to use the __Ozeki.Libs.Rest library__.

### How to use the Ozeki.Libs.Rest library

In order to use the __Ozeki.Libs.Rest library__ in your own project, you need to place the __Ozeki.Libs.Rest.tcl__ file in your project.
After you've placed the the file there _(what you can download from this github repository, together with 5 example projects)_, you can import it with this line:

```tcl
source Ozeki.Libs.Rest.tcl
```
When you imported the header file, you are ready to use the __Ozeki.Libs.Rest library__, to send, mark, delete and receive SMS messages.

#### Creating a Configuration

To send your SMS message to the built in API of the __Ozeki SMS Gateway__, your client application needs to know the details of your __Gateway__ and the __http_user__.
We can define a __Configuration__ instance with these lines of codes in Tcl/Tk.

```tcl
set configuration [ Configuration new ]
$configuration setUsername "http_user"
$configuration setPassword "qwe123"
$configuration setApiUrl "http://127.0.0.1:9509/api"
```

#### Creating a Message

After you have initialized your configuration object you can continue by creating a Message object.
A message object holds all the needed data for message what you would like to send.
In Tcl/Tk we create a __Message__ instance with the following lines of codes:

```tcl
set msg [ Message new ]
$msg setToAddress "+36201111111"
$msg setText "Hello world!"
```

#### Creating a MessageApi

You can use the __MessageApi__ class of the __Ozeki.Libs.Rest library__ to create a __MessageApi__ object which has the methods to send, delete, mark and receive SMS messages from the Ozeki SMS Gateway.
To create a __MessageApi__, you will need these lines of codes and a __Configuration__ instance.

```tcl
set api [ MessageApi new $configuration ]
```

After everything is ready you can begin with sending the previously created __Message__ object:

```tcl
set result [ $api send $msg ]

puts [ $result toString ]
```

After you have done all the steps, you check the Ozeki SMS Gateway and you will see the message in the _Sent_ folder of the __http_user__.

## Manual / API reference

To get a better understanding of the above **SMS code sample**, it is a good
idea to visit the webpage that explains this code in a more detailed way.
You can find videos, explanations and downloadable content on this URL.

Link: [How to send sms from TCL/Tk](https://ozeki-sms-gateway.com/p_870-td-tk-send-sms-with-the-http-rest-api-code-sample.html)


## How to send sms through your Android mobile phone

If you wish to [send SMS through your Android mobile phone from C#](https://android-sms-gateway.com/), 
you need to [install Ozeki SMS Gateway on your Android](https://ozeki-sms-gateway.com/p_2847-how-to-install-ozeki-sms-gateway-on-android.html) 
mobile phone. It is recommended to use an Android mobile phone with a minimum of 
4GB RAM and a quad core CPU. Most devices today meet these specs. The advantage
of using your mobile, is that it is quick to setup and it often allows you
to [send sms free of charge](https://android-sms-gateway.com/p_246-how-to-send-sms-free-of-charge.html).

[Android SMS Gateway](https://android-sms-gateway.com)


## Get started now

Don't waste any time, download the repository now, and send your first SMS!
