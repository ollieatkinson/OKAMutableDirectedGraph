//
//  OKAHashMutableDirectedGraph.h
//  DirectedGraph
//
//  Created by Oliver on 30/01/2014.
//  Copyright (c) 2014 Oliver Atkinson @ Common Agency. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OKADirectedGraph.h"

@interface OKAMutableDirectedGraph : NSObject <OKADirectedGraph>

- (void)addEdgeFrom:(id)start to:(id)destination;
- (void)removeEdgeFrom:(id)start to:(id)destination;
- (BOOL)containsEdgeFrom:(id)start to:(id)destination;

- (void)addNode:(id)node;
- (void)removeNode:(id)node;
- (BOOL)containsNode:(id)node;

@end
