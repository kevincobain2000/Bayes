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
@synthesize fScores;
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

#pragma mark Robinson
-(void)guessRobinson:(NSArray *)features{
    self.testFrequencies = [[NSCountedSet alloc] initWithArray:features];
    for (NSString *key in [self.trainFrequencies allKeys]){
        self.currentLabel = key;
        self.fScores = [[NSMutableArray alloc] init];
        [self getFScores];
        
        float prob = [self robinson];

        NSNumber *probability = [NSNumber numberWithFloat:prob];
        [self.probabilities setObject:probability forKey:key];
    }
}
-(void) getFScores{
    /*
     Note These counts are modified and may not represent the same ways
     the Maximum Likelihood is calculated.
     */
    long poolCount = [[self.trainFrequencies objectForKey:self.currentLabel] count];
    int totalCount = [self getTotalCount];
    

    long otherCount;
    int thisCount;
    int themCount;
    
    for (NSString *feature in self.testFrequencies){
        otherCount = 0;
        thisCount=1;
        themCount=1;
        for (NSString *key in self.trainFrequencies){
            if ([key isNotEqualTo:self.currentLabel]){
                themCount += [[self.trainFrequencies objectForKey:key] countForObject:feature];
            }
            else{
                thisCount += [[self.trainFrequencies objectForKey:self.currentLabel] countForObject:feature];
            }
        }
        otherCount = (float)totalCount/thisCount;
        float goodMetric = (float)otherCount/(float)poolCount;
        float badMetric = (float)thisCount/(float)themCount;
        float f = (float)badMetric/((float)goodMetric +(float)badMetric);

        NSNumber *FScore = [NSNumber numberWithFloat:f];
        [self.fScores addObject:FScore];
    }
}

-(int) getTotalCount{
    long total = 0;
    for (NSString *key in self.trainFrequencies){
        total += [[self.trainFrequencies objectForKey:key] count];
    }
    return (int)total;
}

-(float) robinson{
    int n = (int)[self.fScores count];
    float P = 1;
    float Q = 1;
    float S = 0.0;
    for (id p in self.fScores){
        P *= (1-[p floatValue]);
        Q *= [p floatValue];
    }
    P = 1-pow(P, n);
    Q = 1 - pow(Q, (float)1/n);
    S = (P-Q)/(P+Q);
    //S = (1+(P-Q)/(P+Q))/2;
    return S;
}

#pragma mark Naive Bayes
-(void)guessNaiveBayes:(NSArray *)features{
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
-(long)oFL:(NSString *)feature{
    long i = [[self.trainFrequencies objectForKey:self.currentLabel] countForObject:feature];
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
