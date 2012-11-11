//
//  FeaturesVector.m
//  Bayes
//
//  Created by Pulkit Kathuria on 11/11/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import "FeaturesVector.h"
#import "TextProcessing.h"

@implementation FeaturesVector

@synthesize features;

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        self.features = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void) appendFeatures: (NSString *) corpus forFeatures: (NSArray *) whatFeatures{
    self.features = [[NSMutableArray alloc] init];
    //Convert Here for the lower case 
    for (NSString * feat in whatFeatures){
        if ([feat isEqualToString:@"bigrams"]){
            [self.features addObjectsFromArray:[TextProcessing bigrams:corpus]];
        }
        if ([feat isEqualToString:@"trigrams"]){
            [self.features addObjectsFromArray:[TextProcessing trigrams:corpus]];
        }
        if ([feat isEqualToString:@"tokens"]){
            NSString *removedStopWords = [TextProcessing removeStopwords:corpus];
            NSString *removedPunctuation = [TextProcessing removePunctuations:removedStopWords];
            NSArray *tokens = [removedPunctuation componentsSeparatedByString: @" "];
            [self.features addObjectsFromArray:tokens];
        }
        if ([feat isEqualToString:@"pos"]){
            
            NSArray *tokensWithPos = [TextProcessing posTagger:corpus];

            for (NSArray *array in tokensWithPos){
                NSString *xs = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
                [self.features addObject:xs];
            }
        }
    }
}

@end
