//
//  MoreTableViewController.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/22/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"

@interface MoreTableViewController : UITableViewController

@property (nonatomic, retain) Club *club;
@property (nonatomic, assign) BOOL bBeenHere;
@property (nonatomic, assign) BOOL bWantToGo;
@property (weak, nonatomic) IBOutlet UINavigationItem *clubName;

@end
