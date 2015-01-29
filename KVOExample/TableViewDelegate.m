//
//  TableViewDelegate.m
//  KVOExample
//
//  Created by Patrick O'Brien on 1/29/15.
//  Copyright (c) 2015 Patrick O'Brien. All rights reserved.
//

#import "TableViewDelegate.h"

#define kItemsInArrayOne 8
#define kItemsInArrayTwo 4
#define kItemsInArrayThree 18

// constants
static NSString *kCellIdentifier = @"cell";
static NSString *kButtonOneLabelText = @"button data one";
static NSString *kButtonTwoLabelText = @"button data two";
static NSString *kButtonThreeLabelText = @"button data three";

// KVO items
static NSString *kPropertyToObserve = @"contentSize";
static int kObservingContentSizeChangesContext;

@interface TableViewDelegate ()

@property (nonatomic, strong) NSMutableArray *tableViewData;

@end

@implementation TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.tableViewData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
  cell.textLabel.text = self.tableViewData[indexPath.row];
  return cell;
}

- (void)setSegmentOneData {
  NSMutableArray *mutableArray = [NSMutableArray new];
  for (int i = 0; i < kItemsInArrayOne; i++) {
    [mutableArray addObject:kButtonOneLabelText];
  }
  self.tableViewData = mutableArray;
}

- (void)setSegmentTwoData {
  NSMutableArray *mutableArray = [NSMutableArray new];
  for (int i = 0; i < kItemsInArrayTwo; i++) {
    [mutableArray addObject:kButtonTwoLabelText];
  }
  self.tableViewData = mutableArray;
}

- (void)setSegmentThreeData {
  NSMutableArray *mutableArray = [NSMutableArray new];
  for (int i = 0; i < kItemsInArrayThree; i++) {
    [mutableArray addObject:kButtonThreeLabelText];
  }
  self.tableViewData = mutableArray;
}

- (NSMutableArray *)tableViewData {
  if (!_tableViewData) {
    [self setSegmentOneData];
  }
  return _tableViewData;
}

-(void)setDelegate:(id<TableDisplayProtocol>)delegate {
  if (!_delegate) {
    _delegate = delegate;
  }
}

-(void)updateTableView:(UITableView *)tableView withSegmentIndex:(NSInteger)index withCallback:(GeneralVoidCallback)callback{
  
  if (index == 0) {
    // switch to segment one data
    [self setSegmentOneData];
  } else if (index == 1) {
    // switch to segment two data
    [self setSegmentTwoData];
  } else if (index == 2) {
    // switch to segment three data
    [self setSegmentThreeData];
  }
  
  /*
   * In order to have a callback for the tableView updates we need to modify the CATransaction layer
   *
   * This is only here to show that when setting the completion block, the contentSize property has not updated, even though the CATransaction has completed.
   */
  
  [CATransaction begin];
  
  // callback to run after the sections are reloaded
  [CATransaction setCompletionBlock: ^{
    if (callback != nil) {
      callback();
    }
  }];
  [tableView beginUpdates];
  
  // the row animation is probably why the contentSize hasn't finished updating
  [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
  
  [tableView endUpdates];
  [CATransaction commit];
}

/**
 * Key-Value Observations methods
 */
- (void)startObservingContentSizeChangesInTableView:(UITableView *)tableView {
  [tableView addObserver:self forKeyPath:kPropertyToObserve options:0 context:&kObservingContentSizeChangesContext];
}

- (void)stopObservingContentSizeChangesInTableView:(UITableView *)tableView {
  [tableView removeObserver:self forKeyPath:kPropertyToObserve context:&kObservingContentSizeChangesContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (context == &kObservingContentSizeChangesContext) {
    // use the delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentSizeDidChange)]) {
      // call content size did change
      [self.delegate contentSizeDidChange];
    }
    [self stopObservingContentSizeChangesInTableView:object];
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

@end
