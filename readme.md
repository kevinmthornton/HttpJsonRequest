This was used as a demonstration for a meetup.com group where I hosted a presentation on how to connect to a JSON web service.

ASI http request connecting to a PHP page that will query the database and sends back a json string with data you parse and put into labels. The data should be in a dictionary and you get the label information out of the dictionary. This would be proper MVC.

PHP - http://www.yourwebsite.com/path/to/JSON.php
Single PHP page that connects to database and returns either json data or an error code.
	- db hookup and return error if not connected
	- class bookLibrary
	- getBooks: the returned json list of books
		- query tbl_books for titles
		- pull into an array > bookArray
		- json_encode(bookArray);
		- ["PHP Programming", "C Programming", "Ruby Programming"]
		- pass to sendResponse with good code and json data
	- sendResponse: the response code header for messages
	- getStatusCode: the array status code messages

Sending post form from iOS

// Note that the URL is the "action" URL parameter from the form.
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL @"http://www.whereq.com:8079/answer.m"]];
[request setHTTPMethod:@"POST"];
[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
//this is hard coded based on your suggested values, obviously you'd probably need to make this more dynamic based on your application's specific data to send
NSString *postString = @"paperid=6&q77=2&q80=blah";
NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
[request setHTTPBody:data];
[request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
[NSURLConnection connectionWithRequest:request delegate:self];

-------- OR ---------

NSData* postData= [<yourJSON> dataUsingEncoding:NSUTF8StringEncoding];
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
  [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:postData];

  // NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request 
                                                                delegate:self];
  // for getting data back try this:
  NSData *returnData = [NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
  NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

  [connection start];


ViewController.h
NSString *jsonReturnedString;
goGetJsonData
parseJsonStringToLabels
	- take the json data and put it inside the labels
areConnected
	- are we connected to the internet?

ViewController.m
   goGetJsonData
	- go get json data from server and store in jsonReturnedString
	- json data will be returned in an array
   requestFinished
	- jsonReturnedString = [request responstString];
	- [self parseJsonStringToLabels];
ViewDidLoad {
	[self goGetJsonData];	
}


Part 2
Authentication
Send out data for request
	- picker list of what to get
Caching


