//
//  TextProcessing.h
//  Bayes
//
//  Created by Pulkit Kathuria on 11/10/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextProcessing : NSObject

+ (NSMutableArray *) bigrams: (NSString *) rawText;
+ (NSMutableArray *) trigrams: (NSString *) rawText;
+ (NSString *) removeStopwords:(NSString *) rawText;
+ (NSMutableArray *) posTagger:(NSString *) raw;
+(NSString *)removePunctuations:(NSString *)raw;
+ (float) getDiceScore: (NSString *) firstString andSecondString: (NSString *) secondString;
@end
