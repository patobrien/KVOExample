//
//  ViewScrollView.m
//  KVOExample
//
//  Created by Patrick O'Brien on 1/29/15.
//  Copyright (c) 2015 Patrick O'Brien. All rights reserved.
//

#import "ViewScrollView.h"

@implementation ViewScrollView

/*
 * Subclass of the Scroll View to restrict movement to vertical only
 */

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
  // restrict movement to vertical only
  CGPoint newOffset = CGPointMake(0, contentOffset.y);
  [super setContentOffset:newOffset animated:animated];
}

- (void)setContentOffset:(CGPoint)contentOffset {
  // restrict movement to vertical only
  CGPoint newOffset = CGPointMake(0, contentOffset.y);
  [super setContentOffset:newOffset];
}

@end
