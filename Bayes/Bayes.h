//
//  Bayes.h
//  Bayes
//
//  Created by Pulkit Kathuria on 11/8/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bayes : NSObject

/*
trainFrequencies
 Mutual for all classifiers

Key   (Label)
Value (NSCountedSet of frequency of features)
*/

@property (strong, nonatomic) NSMutableDictionary *trainFrequencies;

//All Frequencies stores total frequencies
@property (strong, nonatomic) NSCountedSet *allFrequencies;


//counts the frequency of test features
@property (strong, nonatomic) NSCountedSet *testFrequencies;

/*
 probabilities
 Key   (Label)
 Value (Probability)
 
 */
@property (strong, nonatomic) NSMutableDictionary *probabilities;
@property (strong, nonatomic) NSString *currentLabel;

-(void)train:(NSArray *)features forlabel: (NSString *)label;
-(void)guessNaiveBayes:(NSArray *)features;


-(int) oL;
-(long)oFL:(NSString *)feature;
-(float) pLSSum;
-(float)pS;

-(void)guessRobinson:(NSArray *)features;
-(void) getFScores;
-(int) getTotalCount;
-(float) robinson;
@property (strong, nonatomic) NSMutableArray *fScores;
@end
