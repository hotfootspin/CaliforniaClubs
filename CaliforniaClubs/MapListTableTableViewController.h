//
//  MapListTableTableViewController.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/16/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"
#import "AppDelegate.h"

@interface MapListTableTableViewController : UITableViewController  {
}

- (BOOL) matchesClub: (Club*) club;
- (BOOL) matchesDay: (Club*) club;
- (BOOL) matchesLevel: (Club*) club;

@property (nonatomic, retain) Club *club;
@property (nonatomic, assign) BOOL bShowNearby;
@property (nonatomic, assign) BOOL bShowBeenThere;
@property (nonatomic, assign) BOOL bShowWantToGo;
@property (nonatomic, retain) NSArray *sortedClubs;
@property (nonatomic, retain) NSMutableArray *subsetClubs;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (nonatomic, retain) AppDelegate *myAppDelegate;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (strong) NSArray *userClubBookmarks;

@property (nonatomic, assign) BOOL bShowSunday;
@property (nonatomic, assign) BOOL bShowMonday;
@property (nonatomic, assign) BOOL bShowTuesday;
@property (nonatomic, assign) BOOL bShowWednesday;
@property (nonatomic, assign) BOOL bShowThursday;
@property (nonatomic, assign) BOOL bShowFriday;
@property (nonatomic, assign) BOOL bShowSaturday;

@property (nonatomic, assign) BOOL bShowMainstream;
@property (nonatomic, assign) BOOL bShowPlus;
@property (nonatomic, assign) BOOL bShowAdvanced;
@property (nonatomic, assign) BOOL bShowChallenge;
@property (nonatomic, assign) BOOL bShowRounds;


@end
