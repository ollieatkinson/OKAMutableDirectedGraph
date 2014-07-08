//
//  OKAHashMutableDirectedGraph.m
//  DirectedGraph
//
//  Created by Oliver on 30/01/2014.
//  Copyright (c) 2014 Oliver Atkinson @ Common Agency. All rights reserved.
//

#import "OKAMutableDirectedGraph.h"

@interface OKAMutableDirectedGraph ()

@property (nonatomic, strong) NSMutableDictionary *nodeToPredecessors;
@property (nonatomic, strong) NSMutableDictionary *nodeToSuccessors;

@property (nonatomic, strong) NSMutableOrderedSet *mutableHeads;
@property (nonatomic, strong) NSMutableOrderedSet *mutableTails;

@end

@implementation OKAMutableDirectedGraph

- (void)clear;
{
  [self.nodeToPredecessors  removeAllObjects];
  [self.nodeToSuccessors  removeAllObjects];
  [self.mutableHeads removeAllObjects];
  [self.mutableTails removeAllObjects];
}

- (NSArray *)heads;
{
  return [self.mutableHeads array];
}

- (NSArray *)tails;
{
  return [self.mutableTails array];
}

- (NSArray *)predecessors:(id)node;
{
  NSArray *list = self.nodeToPredecessors[node];
  
  if (list) {
    return list;
  } else {
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ is not in graph", node]
                                 userInfo:nil];
  }
}

- (NSArray *)successors:(id)node;
{
  NSArray *list = self.nodeToSuccessors[node];
  
  if (list) {
    return list;
  } else {
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ is not in graph", node]
                                 userInfo:nil];
  }
}

- (NSUInteger)count;
{
  return self.nodeToPredecessors.count;
}

- (NSEnumerator *)enumerator;
{
  return self.nodeToPredecessors.keyEnumerator;
}

- (void)addEdgeFrom:(id)start to:(id)destination;
{
  NSParameterAssert(start);
  NSParameterAssert(destination);
  
  if ([self containsEdgeFrom:start to:destination]) {
    return;
  }
  
  NSMutableArray *successorList = [self.nodeToSuccessors[start] mutableCopy];
  
  if (!successorList) {
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ is not in graph", start]
                                 userInfo:nil];
  }
  
  NSMutableArray *predecessorList = [self.nodeToPredecessors[destination] mutableCopy];
  
  if (!predecessorList) {
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ is not in graph", destination]
                                 userInfo:nil];
  }
  
  if ([self.mutableHeads containsObject:destination]) {
    [self.mutableHeads removeObject:destination];
  }
  
  if ([self.mutableTails containsObject:start]) {
    [self.mutableTails removeObject:start];
  }
  
  [successorList addObject:destination];
  [predecessorList addObject:start];
  
  self.nodeToSuccessors[start]         = [successorList copy];
  self.nodeToPredecessors[destination] = [predecessorList copy];
}

- (void)removeEdgeFrom:(id)start to:(id)destination;
{
  NSParameterAssert(start);
  NSParameterAssert(destination);
  
  NSMutableArray *successorList = [self.nodeToSuccessors[start] mutableCopy];
  
  if (!successorList) {
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ is not in graph", start]
                                 userInfo:nil];
  }
  
  NSMutableArray *predecessorList = [self.nodeToPredecessors[destination] mutableCopy];
  
  if (!predecessorList) {
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ is not in graph", destination]
                                 userInfo:nil];
  }
  
  [successorList removeObject:destination];
  [predecessorList removeObject:start];
  
  if (successorList.count == 0) {
    [self.mutableTails addObject:start];
  }
  
  if (predecessorList.count == 0) {
    [self.mutableHeads addObject:destination];
  }
  
  self.nodeToSuccessors[start]         = successorList;
  self.nodeToPredecessors[destination] = predecessorList;
}

- (BOOL)containsEdgeFrom:(id)start to:(id)destination;
{
  NSArray *successors = self.nodeToSuccessors[start];
  
  if (!successors) {
    return NO;
  }
  
  return [successors containsObject:destination];
}

- (BOOL)containsNode:(id)node;
{
  return [self.nodeToPredecessors.allKeys containsObject:node];
}

- (NSArray *)nodes;
{
  return self.nodeToPredecessors.allKeys;
}

- (void)addNode:(id)node;
{
  if ([self containsNode:node]) {
    return;
  }
  
  self.nodeToSuccessors[node]   = [NSArray array];
  self.nodeToPredecessors[node] = [NSArray array];
  
  [self.mutableHeads addObject:node];
  [self.mutableTails addObject:node];
}

- (void)removeNode:(id)node;
{
  for (NSMutableDictionary *dictionary in @[ self.nodeToSuccessors, self.nodeToPredecessors ]) {
    
    NSEnumerator *enumerator = [dictionary[node] objectEnumerator];
    id            nextNode;
    
    while (nextNode = [enumerator nextObject]) {
      [self removeEdgeFrom:node to:nextNode];
    }
    
    [dictionary removeObjectForKey:node];
    
  }
  
  if ([self.mutableHeads containsObject:node]) {
    [self.mutableHeads removeObject:node];
  }
  
  if ([self.mutableTails containsObject:node]) {
    [self.mutableTails removeObject:node];
  }
}

#pragma mark - Properties

- (NSMutableDictionary *)nodeToSuccessors;
{
  return _nodeToSuccessors = _nodeToSuccessors ?: [@{} mutableCopy];
}

- (NSMutableDictionary *)nodeToPredecessors;
{
  return _nodeToPredecessors = _nodeToPredecessors ?: [@{} mutableCopy];
}

- (NSMutableOrderedSet *)mutableHeads;
{
  return _mutableHeads = _mutableHeads ?: [NSMutableOrderedSet orderedSet];
}

- (NSMutableOrderedSet *)mutableTails;
{
  return _mutableTails = _mutableTails ?: [NSMutableOrderedSet orderedSet];
}

@end
