//
//  ViewController.m
//  KVOExample
//
//  Created by Patrick O'Brien on 1/28/15.
//  Copyright (c) 2015 Patrick O'Brien. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.segmentedControl addTarget:self
                       action:@selector(changedButton)
             forControlEvents:UIControlEventValueChanged];
  self.tableView.layer.cornerRadius = 12.0f;
  self.tableView.clipsToBounds = YES;
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self animateTableViewHeight];
}

- (void)changedButton {
  
  NSLog(@"initial tableView.contentSize.height: %.2f",self.tableView.contentSize.height);
  
  // event delegate
  NSObject <TableDataProtocol> *eventDelegate = (NSObject<TableDataProtocol>*) self.tableView.delegate;
  
  // set delegate for contentSizeDidChange
  [eventDelegate setDelegate:self];
  
  // observe changes to contentSize
  [eventDelegate startObservingContentSizeChangesInTableView:self.tableView];
  
  /**
   * Cast the tableView delegate to use our specified protocol (so it knows about the 
   * updateTableView:withSegmentedControl:withCallback: method
   */
  [(id <TableDataProtocol>)self.tableView.delegate updateTableView:self.tableView withSegmentIndex:self.segmentedControl.selectedSegmentIndex withCallback:^{
    
    // this should work, but it doesn't.
    NSLog(@"after updates tableView.contentSize.height: %.2f",self.tableView.contentSize.height);
  
  }];
}

- (void)contentSizeDidChange {
  // the size has now changed
  NSLog(@"tableView.contentSize.height after KVO: %.2f",self.tableView.contentSize.height);
  // animate the table view
  [self animateTableViewHeight];
}

- (void)animateTableViewHeight {
  /**
   * Quick POP animation to change the table view height
   */
  [self.tableViewHeight pop_removeAllAnimations];
  POPBasicAnimation *height = [POPBasicAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
  height.toValue = [NSNumber numberWithFloat:self.tableView.contentSize.height];
  [self.tableViewHeight pop_addAnimation:height forKey:@"height"];
}

@end
