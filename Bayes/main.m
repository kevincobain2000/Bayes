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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *raw = @"Extract the bigrams and trigrams";
        //NSLog(@"%@",[TextProcessing bigrams:raw]);
        //NSLog(@"%@",[TextProcessing trigrams:raw]);
        NSLog(@"%@", [TextProcessing removeStopwords:raw]);
        //NSLog(@"%@",[TextProcessing posTagger:raw]);
    }
    return 0;
}

