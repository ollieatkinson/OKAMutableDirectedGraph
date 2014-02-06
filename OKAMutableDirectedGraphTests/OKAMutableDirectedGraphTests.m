#import <Kiwi/Kiwi.h>
#import "OKAMutableDirectedGraph.h"

SPEC_BEGIN(TestSpec)

describe(@"OKAMutableDirectedGraph#dependencies", ^{
  
  it (@"traverse the graph edges when removing heads", ^{
    
    NSString *a = @"a";
    NSString *b = @"b";
    NSString *c = @"c";
    
    OKAMutableDirectedGraph *graph = [[OKAMutableDirectedGraph alloc] init];
    
    for (NSString *job in @[ a, b, c ]) {
      [graph addNode:job];
    }
    
    [graph addEdgeFrom:c destination:b];
    [graph addEdgeFrom:b destination:a];
    
    NSMutableArray *sorted = [NSMutableArray array];
    
    do {
      
      NSArray *heads = graph.heads;
      
      for (NSString *job in heads) {
        [graph removeNode:job];
        [sorted addObject:job];
      }
      
    } while (graph.heads.count != 0);
    
    [[sorted should] equal:@[ c, b, a ]];
    
  });
  
});

SPEC_END