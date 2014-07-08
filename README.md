OKAMutableDirectedGraph
=======================

![image](http://algs4.cs.princeton.edu/42directed/images/digraph.png)

OKAMutableDirectedGraph is an implementation of a directed graph in Objective-C.

OKAMutableDirectedGraph was developed originally for managing dependencies - but it can be used for path finding, sorting, garbage collection and much more. 

----

### Example Usage

``` objective-c
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
 
 (lldb) sorted => @[ c, b, a ]
```

----

### Documentation & Research

[Princeton University - Directed Graphs](http://algs4.cs.princeton.edu/42directed/)


### Contact

Oliver Atkinson  

+ [oliveratkinson@me.com](mailto:oliveratkinson@me.com)

### Licence

OKAMutableDirectedGraph is available under the MIT license. See the LICENSE file for more info.
