//
//  Bayes.m
//  Bayes
//
//  Created by Pulkit Kathuria on 11/8/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import "Bayes.h"

@implementation Bayes
@synthesize trainFrequencies;
@synthesize currentLabel;
@synthesize allFrequencies;
@synthesize probabilities;
- (id) init
{
    self = [super init];
    
    if (self != nil)
    {
        self.trainFrequencies = [[NSMutableDictionary alloc] init];
        self.allFrequencies = [[NSCountedSet alloc] init];
        self.probabilities = [[NSMutableDictionary alloc] init];
        self.currentLabel = [[NSString alloc] init];
        
    }
    
    return self;
}
-(void)train:(NSArray *)features forlabel: (NSString *)label{
    NSCountedSet *frequencies = [NSCountedSet setWithArray:features];
    [self.allFrequencies unionSet:frequencies];
    if (![self.trainFrequencies objectForKey:label]){
        [self.trainFrequencies setObject:frequencies forKey:label];
    }
    else{
        NSCountedSet *combined = [[NSCountedSet alloc] init];
        [combined unionSet:[self.trainFrequencies objectForKey:label]];
        [self.trainFrequencies setObject:combined forKey:label];
    }
    
}
-(void)test:(NSArray *)features{
    self.testFrequencies = [[NSCountedSet alloc] initWithArray:features];
    for (NSString *key in [self.trainFrequencies allKeys]){
        self.currentLabel = key;
        
        
        float prob = [self pS] * [self pLSSum];
        NSNumber *probability = [NSNumber numberWithFloat:prob];
        [self.probabilities setObject:probability forKey:key];
    }
}

-(int) oL{
    //Number of features in currentlabel
    int i= 0;
    for (id item in [self.trainFrequencies objectForKey:self.currentLabel]){
        i += [[self.trainFrequencies objectForKey:self.currentLabel] countForObject:item];
    }
    return i;
}
-(int)oFL:(NSString *)feature{
    int i = [[self.trainFrequencies objectForKey:self.currentLabel] countForObject:feature];
    return i;
}
-(float) pLSSum{
    //Sum of probabilities PI P(fi|L)
    int oL = [self oL]+1; //add 1 smoothing
    float pLS=0;
    for (id feature in self.testFrequencies){
        pLS += (float)[self oFL:feature]/(float)oL;
        
    }
    return pLS;
}
-(float)pS{
    int totalFeatures= 0;
    int featuresInThisLabel =1; // add one smoothing
    for (id item in self.allFrequencies){
        totalFeatures += [self.allFrequencies countForObject:item];
    }
    for (id item in [self.trainFrequencies objectForKey:self.currentLabel]){
        featuresInThisLabel += [[self.trainFrequencies objectForKey:self.currentLabel] countForObject:item];
        
    }
    return (float)totalFeatures/(float)featuresInThisLabel;
}

@end
