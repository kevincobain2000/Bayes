//
//  main.m
//  Bayes
//
//  Created by Pulkit Kathuria on 11/8/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bayes.h"
#import "TextProcessing.h"
#import "FeaturesVector.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSString *positive = @"What a Great movie must watch it again";
        NSString *negative = @"What a Bad movie must not watch it again";
        
        Bayes *classifier = [[Bayes alloc] init];
        FeaturesVector *featuresVector = [[FeaturesVector alloc] init];
        //NSArray *features = [[NSArray alloc] initWithObjects:@"bigrams", @"trigrams", @"tokens", @"pos", nil];
        NSArray *features = [[NSArray alloc] initWithObjects:@"bigrams", @"tokens",nil];
        
        
        [featuresVector appendFeatures:positive forFeatures:features];
        NSLog(@"Positive features extracted");
        [classifier train:featuresVector.features forlabel:@"positive"];
        NSLog(@"Positive features trained");

        
        [featuresVector appendFeatures:negative forFeatures:features];
        NSLog(@"Negative features extracted");
        [classifier train:featuresVector.features forlabel:@"negative"];
        NSLog(@"Negative features trainied");
        
        NSString *toGuess = @"Great must watch";
        [featuresVector appendFeatures:toGuess forFeatures:features];
        [classifier guessNaiveBayes:featuresVector.features];
        NSLog(@"%@",classifier.probabilities);
        
        [classifier guessRobinson:featuresVector.features];
        NSLog(@"%@",classifier.probabilities);

    }
    return 0;
}

