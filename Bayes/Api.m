//
//  Api.m
//  Bayes
//
//  Created by Pulkit Kathuria on 11/20/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import "Api.h"
#import "SBJson.h"
@implementation Api

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        self.jsonOutputDict = [[NSDictionary alloc] init];
        
    }
    return self;
}
-(void)sentiClassifier: (NSString *) string andClassifier: (NSString *) classifier andDomain: (NSString *) domain{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSMutableString *apiUrlString = [NSMutableString stringWithFormat:@"http://www.jaist.ac.jp/~s1010205/cgi-bin/senti_classifier/api.cgi?"];
    if (!classifier){
        classifier = @"MaxentClassifier";
    }
    if (!domain) {
        domain = @"movies";
    }
    NSString *stringSpaces = [string stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [apiUrlString appendFormat:@"string=%@&classifier=%@&domain=%@",stringSpaces,classifier, domain];
    NSURL *apiUrl = [NSURL URLWithString: apiUrlString];
    NSData *jsonData = [NSData dataWithContentsOfURL:apiUrl];

    self.jsonOutputDict = [parser objectWithData:jsonData];
}

@end
