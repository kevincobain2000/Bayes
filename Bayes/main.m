//
//  main.m
//  Bayes
//
//  Created by Pulkit Kathuria on 11/8/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bayes.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray *f1 = [[NSArray alloc] initWithObjects:@"Salmon",@"Tuna", @"Chicken", @"Buri",@"Buri",nil];
        NSArray *f2 = [[NSArray alloc] initWithObjects:@"Chicken",@"Chicken", @"Salmon",nil];
        
        Bayes *bayesClasssifier = [[Bayes alloc] init];
        [bayesClasssifier train:f1 forlabel:@"S1"];
        [bayesClasssifier train:f2 forlabel:@"S2"];
        
        [bayesClasssifier test:f2];
        NSLog(@"%@", bayesClasssifier.probabilities);
        
    }
    return 0;
}

