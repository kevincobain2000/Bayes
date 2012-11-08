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
          NSArray *f2 = [[NSArray alloc] initWithObjects:@"Chicken",@"Chicken", @"Salmon",nil];
        
          Bayes *bayesClasssifier = [[Bayes alloc] init];
          [bayesClasssifier train:f1 forlabel:@"S1"];
          [bayesClasssifier train:f2 forlabel:@"S2"];
        
          [bayesClasssifier test:f2];
          NSLog(@"%@", bayesClasssifier.probabilities);
        
      }
      return 0;
  }