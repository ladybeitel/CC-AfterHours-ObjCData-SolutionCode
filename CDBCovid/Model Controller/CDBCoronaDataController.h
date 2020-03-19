//
//  CDBCoronaDataController.h
//  CDBCovid
//
//  Created by Ciara Beitel on 3/19/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import <Foundation/Foundation.h>

// Class Forward Declaration
@class CDBCoronaData; // This allows other files to be aware of our model

NS_ASSUME_NONNULL_BEGIN

@interface CDBCoronaDataController : NSObject // subclass from NSObject

// create property for our model
@property (nonatomic, readonly) CDBCoronaData *coronaData;

// create methods
- (void)getWorldData:(void(^)(CDBCoronaData *))completion;

- (void)getCountryData:(NSString *)countryName completion:(void(^)(CDBCoronaData *))completion;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
