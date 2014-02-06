OKAMutableDirectedGraph
=======================

A directed graph (or digraph) is a set of vertices and a collection of directed edges that each connects an ordered pair of vertices. We say that a directed edge points from the first vertex in the pair and points to the second vertex in the pair. 

![image](http://algs4.cs.princeton.edu/42directed/images/digraph.png)

__Example usage for dependency management__
_NB: See Unit tests_

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
    
    (lldb) sorted => @[ c, b, a ]