//
//  CDBCoronaDataController.m
//  CDBCovid
//
//  Created by Ciara Beitel on 3/19/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import "CDBCoronaDataController.h"
#import "CDBCoronaData.h" //import our model

@implementation CDBCoronaDataController

- (void)getWorldData:(void (^)(CDBCoronaData *))completion {
    // Base URL
    NSURL *baseURL = [NSURL URLWithString:@"https://covid19.mathdro.id/api"];
    
    // URL Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    
    // Data Task
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // if there is an error, log it, do not complete.
        if (error) {
            NSLog(@"Error fetching world: %@.", error);
            completion(nil);
            return;
        }
        
        // if there is NO data, log it, do not complete.
        if (!data) {
            NSLog(@"No data returned from data task");
            completion(nil);
            return;
        }
        
        // if there was no error, keep going.
        error = nil; //set the error to nil, so you can use it down below in the dictionary
        
        // Create a dictionary of type NSDictionary called dictionary with the NSJSONSerialization with the object from the data task
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        // if there is an error trying to decode the data, then log it, do not complete.
        if (error) {
            NSLog(@"Error decoding JSON from data: %@", error);
            completion(nil);
            return;
        }
        
        // if the object is NOT a dictionary OR is NOT a kind of dictionary class then log it as an error, do not complete.
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: Expected top level dictionary in JSON result: %@", error);
            completion(nil);
            return;
        }
        
        // Log the dictionary
        NSLog(@"Dictionary: %@", dictionary);
        
        // Create a model object of type CDBCoronaData called coronaData, alloc the space and initWithDictionary called dictionary
        CDBCoronaData *coronaData = [[CDBCoronaData alloc] initWithDictionary:dictionary];
        // call completion with our model object (that was created with the data from the dataTask
        completion(coronaData);
    }] resume]; // don't forget to resume the dataTask!
}

- (void)getCountryData:(NSString *)countryName completion:(void (^)(CDBCoronaData *))completion {
    NSURL *baseURL = [NSURL URLWithString:@"https://covid19.mathdro.id/api/countries"]; //this baseURL is different from the world baseURL
    NSURL *requestURL = [baseURL URLByAppendingPathComponent:countryName]; // append the country's name that the user is searching for to the end of this request URL
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching country: %@.", error);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"No data returned from data task");
            completion(nil);
            return;
        }
        
        error = nil;
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (error) {
            NSLog(@"Error decoding JSON from data: %@", error);
            completion(nil);
            return;
        }
        
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: Expected top level dictionary in JSON result: %@", error);
            completion(nil);
            return;
        }
        
        NSLog(@"Dictionary: %@", dictionary);
        
        CDBCoronaData *coronaData = [[CDBCoronaData alloc] initWithDictionary:dictionary];
        completion(coronaData);
    }] resume];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    // Create a model object of type CDBCoronaData called coronaData, alloc the space and initWithDictionary called dictionary
    CDBCoronaData *coronaData = [[CDBCoronaData alloc] initWithDictionary: dictionary];
    self = [super init]; // Boiler plate code
    if (self) {
        _coronaData = coronaData; // set instance variable
    }
    return self;
}

@end
