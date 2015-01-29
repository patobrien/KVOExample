//
//  TableViewDelegate.h
//  KVOExample
//
//  Created by Patrick O'Brien on 1/29/15.
//  Copyright (c) 2015 Patrick O'Brien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface TableViewDelegate : NSObject <UITableViewDataSource,UITableViewDelegate,TableDataProtocol>

@property (nonatomic, weak) id <TableDisplayProtocol> delegate;

@end
