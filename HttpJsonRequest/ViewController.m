//
//  ViewController.m
//  HttpJsonRequest
//
//  Created by Kevin Thornton on 8/29/13.
//  Copyright (c) 2013 Kevin Thornton. All rights reserved.
//

#import "ViewController.h"

// ****** START JSON DATA 
// category for adding to the NSArray class
@interface NSArray(JSONCategories)
+(NSArray*)arrayWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;
@end

// extend the NSArray class with this class method
@implementation NSArray(JSONCategories)
// gets an NSString with a web address
// does all the downloading, fetching, parsing and whatnot then returns an instance of an array
+(NSArray*)arrayWithContentsOfJSONURLString: (NSString*)urlAddress {
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

// toJSON which you call on an NSDictionary instance to get JSON data out of it
-(NSData*)toJSON {
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

// to use this, you would
// NSArray *myInfo = [NSDictionary arrayWithContentsOfJSONURLString:@"http://www.SOMEJSONDATA.com"];
// now myInfo is an array
// to go the opposite way and create JSON data from your object
// NSArray *information = [NSArray arrayWithObjects: @"orange",@"apple",@"banana",@"fig",nil];
// NSData* json = [information toJSON];

@end
// ******* end json data


@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
//    this just goes to a page that returns an json string, no values are sent to the page
//    NSURL *dataURL = [NSURL URLWithString:@"http://www.yourwebsite.com/path/to/JSON.php"];
//    NSData *data=[NSData dataWithContentsOfURL:dataURL];
//    NSError *error=nil;
//    NSArray *jsonArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//   OR
//    this works and returns an array using the exteneded arrayWithContentsOfJSONURLString from above
//    NSArray *jsonArray = [NSArray arrayWithContentsOfJSONURLString:@"http://www.yourwebsite.com/path/to/JSON.php"];
//    NSLog(@"jsonArray: %@", jsonArray);
    
    // This is a form POST that will send data long. This could be anything from authentication to values gathered in app
    // Note that the URL is the "action" URL parameter from the form.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yourwebsite.com/path/to/JSON.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // This is can be any string or concatenation of values put together with & just like a URL
    NSString *postString = @"subject=C"; // C, PHP, IOS, Ruby are all values
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    
    // for getting data, use sendSynchronousRequest
    NSData *returnData = [NSURLConnection  sendSynchronousRequest:request returningResponse:nil error:nil];
    // put that data return into an array
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:Nil];
    
    // create labels to put the books into
    float startY = 20;
    for (NSString *bookTitle in jsonArray) {
        UILabel *bookLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, startY, 150, 50)];
        [bookLabel setText:bookTitle];
        [self.view addSubview:bookLabel];
        startY += 50;
    } // for
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
