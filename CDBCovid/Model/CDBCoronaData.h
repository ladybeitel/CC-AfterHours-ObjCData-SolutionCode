//
//  CDBCoronaData.h
//  CDBCovid
//
//  Created by Ciara Beitel on 3/18/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBCoronaData : NSObject //Model is subclassed from NSObject

// Properties
@property (nonatomic, readonly) int confirmed;  // Confirmed Total: Int
@property (nonatomic, readonly) int deaths;     // Deaths Total: Int
@property (nonatomic, readonly) int recovered;  // Recovered Total: Int

// Methods (init)
- (instancetype)initWithConfirmed:(int)confirmed
                            deaths:(int)deaths
                        recovered:(int)recovered;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
                         
@end

NS_ASSUME_NONNULL_END
