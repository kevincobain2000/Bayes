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

+ (NSString *) removeStopwords:(NSString *) rawText{
    StopWords *stopwords = [[StopWords alloc] init];
    NSArray *listItems = [rawText componentsSeparatedByString:@" "];
    NSString *output = [[NSMutableString alloc] initWithString:@""];
    for (NSString *word in listItems){
        if ([stopwords.stopwords objectForKey:word] == NULL){
            output = [output stringByAppendingString:word];
            output = [output stringByAppendingString:@" "];
        }
    }
    //Strip output
    [output stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return output;
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
@end
