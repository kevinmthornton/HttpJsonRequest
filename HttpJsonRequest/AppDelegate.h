//
//  AppDelegate.h
//  HttpJsonRequest
/*
 
 1) Connect to a PHP page that will query the database and send back a json string with data.
 2) Send a POST request of the subject of the book subject=PHP and return that values in a json string
 
 ViewController.m
 - can use arrayWithContentsOfJSONURLString NSArray extention 
 - OR -
 - JSONObjectWithData that will return into an array
 
 
 Part 2
 Authentication
 Send out data for request
 - picker list of what to get
 Caching
 
 */


#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
