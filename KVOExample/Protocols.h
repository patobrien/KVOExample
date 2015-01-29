//
//  Protocols.h
//  KVOExample
//
//  Created by Patrick O'Brien on 1/29/15.
//  Copyright (c) 2015 Patrick O'Brien. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GeneralVoidCallback)(void);

/*
 * For the View Controller
 */
@protocol TableDisplayProtocol <NSObject>

- (void)contentSizeDidChange;

@end

/*
 * Protocol the Table View delegate object
 */
@protocol TableDataProtocol <NSObject>

- (void)setDelegate:(id<TableDisplayProtocol>)delegate;
- (void)updateTableView:(UITableView *)tableView withSegmentIndex:(NSInteger)index withCallback:(GeneralVoidCallback)callback;

/**
 * Key-Value Observing methods
 */
- (void)startObservingContentSizeChangesInTableView:(UITableView *)tableView;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

@end
