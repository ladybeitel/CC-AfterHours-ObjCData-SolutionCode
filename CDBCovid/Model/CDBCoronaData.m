//
//  CDBCoronaData.m
//  CDBCovid
//
//  Created by Ciara Beitel on 3/18/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import "CDBCoronaData.h"

@implementation CDBCoronaData

- (instancetype)initWithConfirmed:(int)confirmed
                           deaths:(int)deaths
                        recovered:(int)recovered { // delete ; and insert { }
    self = [super init]; // boiler plate code
    if (self) {
        // set instance variables
        _confirmed = confirmed;
        _deaths = deaths;
        _recovered = recovered;
    }
    return self;
}
                // init with dictionary, of type NSDictionary called dictionary
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    // of type NSNumber called confirmed, go to the dictionary, go to key called confirmed, give me the value for that key
    NSNumber *confirmed = [dictionary valueForKeyPath:@"confirmed.value"];
    NSNumber *deaths = [dictionary valueForKeyPath:@"deaths.value"];
    NSNumber *recovered = [dictionary valueForKeyPath:@"recovered.value"];
    
    // set self with our init from above, with the NSNumber values, and make them int values
    self = [self initWithConfirmed:[confirmed intValue] deaths:[deaths intValue] recovered:[recovered intValue]];
    
    return self;
}

@end
