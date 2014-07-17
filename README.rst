Bayes
=====

TODO: dig back the documentation. I am not a JAIST student anymore :( `Documentation and Usage <http://www.jaist.ac.jp/~s1010205/bayesObjectiveC>`_

Usage:

```
#import <Foundation/Foundation.h>
#import "Api.h"
  
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Api *myApi = [[Api alloc] init];
        
        //Classifiers  
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
```

About
=====

1. Library includes standard naive bays, robinson's classifier.
2. For sentiment analysis api is used for which json is used dependencies of which are included in the project.
3. Basic text processing
   
   - Remove StopWords
   - Tokenizer, POS-Tagger, bigrams, trigrams etc..
