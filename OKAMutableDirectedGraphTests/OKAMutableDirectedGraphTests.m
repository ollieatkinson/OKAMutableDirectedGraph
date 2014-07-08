#import <Specta/Specta.h>

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "OKAMutableDirectedGraph.h"

SpecBegin(TestSpec)

describe(@"OKAMutableDirectedGraph#dependencies", ^{
  
  it (@"traverse the graph edges when removing heads", ^{
    
    NSString *a = @"a";
    NSString *b = @"b";
    NSString *c = @"c";
    
    OKAMutableDirectedGraph *graph = [[OKAMutableDirectedGraph alloc] init];
    
    for (NSString *job in @[ a, b, c ]) {
      [graph addNode:job];
    }
    
    [graph addEdgeFrom:c to:b];
    [graph addEdgeFrom:b to:a];
    
    NSMutableArray *sorted = [NSMutableArray array];
    
    do {
      
      NSArray *heads = graph.heads;
      
      for (NSString *job in heads) {
        [graph removeNode:job];
        [sorted addObject:job];
      }
      
    } while (graph.heads.count != 0);
    
    expect(sorted).to.equal(@[ c, b, a ]);
    
  });
  
});

SpecEnd
