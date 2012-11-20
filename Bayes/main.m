//
//  main.m
//  Bayes
//
//  Created by Pulkit Kathuria on 11/8/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Api.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Api *myApi = [[Api alloc] init];
        
        //Classifiers
        
        //MaxentClassifier

        [myApi sentiClassifier:@"This was one of the bad movies. Will Never watch it again" andClassifier:@"MaxentClassifier" andDomain:@"movies"];
        NSLog(@"Maxent Classifier %@",myApi.jsonOutputDict);
        
        //NaiveBayes
        [myApi sentiClassifier:@"This was one of the best movies. Will surely watch it again" andClassifier:@"NaiveBayes" andDomain:@"tweets"];
        NSLog(@"Naive Bayes %@",myApi.jsonOutputDict);
        
        //NaiveBayes
        [myApi sentiClassifier:@"This was one of the best movies. Will surely watch it again" andClassifier:@"WSD-SentiWordNet" andDomain:@"movies"];
        NSLog(@"WSD %@",myApi.jsonOutputDict);
        
        //Domains
        //movies, tweets, amazon


        
    }
    return 0;
}


