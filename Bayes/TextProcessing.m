//
//  TextProcessing.m
//  Bayes
//
//  Created by Pulkit Kathuria on 11/10/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import "TextProcessing.h"
#import "StopWords.h"
@implementation TextProcessing

#pragma mark Features

+ (NSMutableArray *) bigrams: (NSString *) rawText{
    NSArray *listItems = [rawText componentsSeparatedByString:@" "];
    NSMutableArray *bigrams = [[NSMutableArray alloc] init];
    for (int i =1; i < [listItems count]; i++) {
        NSString *bigram = [NSString stringWithFormat:@"%@-%@",[listItems objectAtIndex:(i-1)], [listItems objectAtIndex:i]];
        [bigrams addObject:bigram];
    }
    
    return bigrams;
}

+ (NSMutableArray *) trigrams: (NSString *) rawText{
    NSArray *listItems = [rawText componentsSeparatedByString:@" "];
    NSMutableArray *trigrams = [[NSMutableArray alloc] init];
    for (int i =2; i < [listItems count]; i++) {
        //NSLog(@"%i, %lu", i, [listItems count]);
        NSString *trigram = [NSString stringWithFormat:@"%@-%@-%@",[listItems objectAtIndex:(i-2)], [listItems objectAtIndex:i-1], [listItems objectAtIndex:i]];
        [trigrams addObject:trigram];
    }
    
    return trigrams;
}

+ (NSMutableArray *) posTagger:(NSString *) raw{
    NSMutableArray *tokenTagArrays = [[NSMutableArray alloc] init];
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace  |
    NSLinguisticTaggerOmitPunctuation |
    NSLinguisticTaggerJoinNames;
    NSLinguisticTagger *tagger =
    [[NSLinguisticTagger alloc] initWithTagSchemes:
     [NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:options];
    
    tagger.string = raw;
    [tagger enumerateTagsInRange:NSMakeRange(0, [raw length]) scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass options:options usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        NSString *token = [raw substringWithRange:tokenRange];
        NSArray *subArray = [[NSArray alloc] initWithObjects:token, tag, nil];
        [tokenTagArrays addObject:subArray];
    }];
    return tokenTagArrays;
}

#pragma mark Text Processing

+ (NSString *) removeStopwords:(NSString *) rawText{
    StopWords *stopwords = [[StopWords alloc] init];
    NSArray *listItems = [rawText componentsSeparatedByString:@" "];
    NSString *output = @"";
    for (NSString *word in listItems){
        if ([stopwords.stopwords objectForKey:word] == NULL){
            output = [output stringByAppendingString:word];
            output = [output stringByAppendingString:@" "];
        }
    }
    output = [TextProcessing strip:output];
    return output;
}

+(NSString *)removePunctuations:(NSString *)raw{
    NSArray * splitRaw = [raw componentsSeparatedByString:@" "];
    NSString *output = @"";
    for (NSString *word in splitRaw){
        NSString* removedPunctuation = [[word componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
        output = [output stringByAppendingString:removedPunctuation];
        output = [output stringByAppendingString:@" "];
    }
    output = [TextProcessing strip:output];
    return output;
}
+ (NSString *)strip: (NSString *)raw{
    //Strip output leading and end whitespaces
    NSString *output = [raw stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return output;
}

#pragma mark Sentence Similarity Function

+ (float) getDiceScore: (NSString *) firstString andSecondString: (NSString *) secondString{
    NSArray *first = [firstString componentsSeparatedByString:@" " ];
    NSArray *second = [secondString componentsSeparatedByString:@" " ];
    
    NSMutableSet *intersection = [NSMutableSet setWithArray:first];
    [intersection intersectSet:[NSSet setWithArray:second]];
    
    float diceScore= 2* (float)[[intersection allObjects] count]/ (float)([first count]+[second count]);
    return diceScore;
}


@end
