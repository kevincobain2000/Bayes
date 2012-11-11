//
//  FeaturesVector.h
//  Bayes
//
//  Created by Pulkit Kathuria on 11/11/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeaturesVector : NSObject

@property (strong, nonatomic) NSMutableArray *features;
- (void) appendFeatures: (NSString *) corpus forFeatures: (NSArray *) whatFeatures;
@end
