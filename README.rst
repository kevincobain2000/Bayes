Bayes
=====

Bayesian Classification in Objective-C

::

  #import <Foundation/Foundation.h>
  #import "Bayes.h"
  int main(int argc, const char * argv[])
  {

     @autoreleasepool {
        NSArray *f1 = [[NSArray alloc] initWithObjects:@"Salmon",@"Tuna", @"Chicken", @"Buri",@"Buri",nil];
        NSArray *f2 = [[NSArray alloc] initWithObjects:@"Chicken",@"Chicken", @"Salmon",@"Tuna", @"Tuna",nil];
        
        NSArray *testFeatures = [[NSArray alloc] initWithObjects:@"Tuna",nil];
        Bayes *classifier = [[Bayes alloc] init];
        
        [classifier train:f1 forlabel:@"S1"];
        [classifier train:f2 forlabel:@"S2"];
        
        [classifier guessNaiveBayes:testFeatures];
        NSLog(@"%@", classifier.probabilities);
        [classifier guessRobinson:testFeatures];
        NSLog(@"%@", classifier.probabilities);

    }
    return 0;

  }