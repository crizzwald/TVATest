//
//  ViewController.h
//  TableViewAnimationTest
//
//  Created by Carly and Todd Crown on 5/31/13.
//  Copyright (c) 2013 Golf Contender. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end
