//
//  Api.h
//  Bayes
//
//  Created by Pulkit Kathuria on 11/20/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Api : NSObject

@property (strong, nonatomic) NSDictionary *jsonOutputDict;
-(void)sentiClassifier: (NSString *) string andClassifier: (NSString *) classifier andDomain: (NSString *) domain;
@end
