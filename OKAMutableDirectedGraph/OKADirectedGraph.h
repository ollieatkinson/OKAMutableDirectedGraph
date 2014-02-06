//
//  OKADirectedGraph.h
//  DirectedGraph
//
//  Created by Oliver on 30/01/2014.
//  Copyright (c) 2014 Oliver Atkinson @ Common Agency. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OKADirectedGraph <NSObject>

- (NSArray *)heads;
- (NSArray *)tails;
- (NSArray *)predecessors:(id)node;
- (NSArray *)successors:(id)node;
- (NSUInteger)count;
- (NSEnumerator *)enumerator;

@end
