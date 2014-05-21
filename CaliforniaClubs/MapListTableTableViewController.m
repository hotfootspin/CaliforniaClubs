//
//  MapListTableTableViewController.m
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/16/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import "MapListTableTableViewController.h"
#import "MapViewController.h"
#import "Club.h"
#import "Data.h"
#import "UserClubBookmark.h"

@interface MapListTableTableViewController ()

@end

@implementation MapListTableTableViewController

@synthesize bShowNearby;
@synthesize bShowBeenThere;
@synthesize bShowWantToGo;
@synthesize sortedClubs;
@synthesize subsetClubs;
@synthesize navBar;
@synthesize myAppDelegate;
@synthesize context;
@synthesize userClubBookmarks;

@synthesize bShowSunday;
@synthesize bShowMonday;
@synthesize bShowTuesday;
@synthesize bShowWednesday;
@synthesize bShowThursday;
@synthesize bShowFriday;
@synthesize bShowSaturday;

@synthesize bShowMainstream;
@synthesize bShowPlus;
@synthesize bShowAdvanced;
@synthesize bShowChallenge;
@synthesize bShowRounds;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        bShowNearby = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // bShowNearby = YES;
    NSLog(@"%hhd", bShowNearby);
    
    if (bShowNearby) {
        NSMutableArray *clubs = [[Data sharedClubData] getClubs];
        int nClubs = [clubs count];

        subsetClubs = [[NSMutableArray alloc] init];
        for (int i=0; i<nClubs; ++i) {
            Club* thisClub = [clubs objectAtIndex:i];
            if ([self matchesClub:thisClub])
                [subsetClubs addObject:thisClub];
        }

        // http://stackoverflow.com/questions/805547/how-to-sort-an-nsmutablearray-with-custom-objects-in-it
        sortedClubs = [subsetClubs sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSNumber* first = [NSNumber numberWithDouble:[(Club*)a distance]];
            NSNumber* second = [NSNumber numberWithDouble:[(Club*)b distance]];
            return [first compare:second];
        }];
        
        navBar.title = @"Nearby locations";
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL) matchesClub: (Club*) club
{
    return ([self matchesDay:club] && [self matchesLevel:club]);
}

- (BOOL) matchesDay: (Club*) club
{
    if (bShowSunday && [club.dayofweek rangeOfString:@"Sunday"].location != NSNotFound )
        return YES;
    if (bShowMonday && [club.dayofweek rangeOfString:@"Monday"].location != NSNotFound )
        return YES;
    if (bShowTuesday && [club.dayofweek rangeOfString:@"Tuesday"].location != NSNotFound )
        return YES;
    if (bShowWednesday && [club.dayofweek rangeOfString:@"Wednesday"].location != NSNotFound )
        return YES;
    if (bShowThursday  && [club.dayofweek rangeOfString:@"Thursday"].location != NSNotFound )
        return YES;
    if (bShowFriday && [club.dayofweek rangeOfString:@"Friday"].location != NSNotFound )
        return YES;
    if (bShowSaturday && [club.dayofweek rangeOfString:@"Saturday"].location != NSNotFound )
        return YES;
    return NO;
}

- (BOOL) matchesLevel: (Club*) club
{
    // Levels could be any or more of:
    // A1 A2 C1 C2 C3A C4 (I don't see any C3B or C3)
    // Basic MS Plus Rounds Advanced
    // There are some ranges like A1-C1, C1-C4, MS-A2
    if (bShowMainstream && [club.level rangeOfString:@"MS"].location != NSNotFound )
        return YES;
    if (bShowMainstream && [club.level rangeOfString:@"Basic"].location != NSNotFound )
        return YES;
    if (bShowPlus && [club.level rangeOfString:@"Plus"].location != NSNotFound )
        return YES;
    if (bShowAdvanced && [club.level rangeOfString:@"Advanced"].location != NSNotFound )
        return YES;
    if (bShowAdvanced && [club.level rangeOfString:@"A1"].location != NSNotFound )
        return YES;
    if (bShowAdvanced && [club.level rangeOfString:@"A2"].location != NSNotFound )
        return YES;
    if (bShowChallenge && [club.level rangeOfString:@"C1"].location != NSNotFound )
        return YES;
    if (bShowChallenge && [club.level rangeOfString:@"C2"].location != NSNotFound )
        return YES;
    if (bShowChallenge && [club.level rangeOfString:@"C3"].location != NSNotFound )
        return YES;
    if (bShowChallenge && [club.level rangeOfString:@"C4"].location != NSNotFound )
        return YES;
    if (bShowRounds && [club.level rangeOfString:@"Rounds"].location != NSNotFound )
        return YES;
    // special case
    if (bShowPlus && [club.level rangeOfString:@"MS-A2"].location != NSNotFound )
        return YES;
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1; // [maps count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (bShowNearby)
        return MIN(10, sortedClubs.count);
    else
        return [[[Data sharedClubData] getClubs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ]; // forIndexPath:indexPath]; // not 5.1
    
    // Configure the cell...
    int index = indexPath.row;
    Club *club;
    NSString *title, *subtitle;
    if (bShowNearby) {
        club = [sortedClubs objectAtIndex:index];
        title = [NSString stringWithFormat:@"%@, %@, %@, %@", [club club], [club city], [club level], [club dayofweek]];
        subtitle = [NSString stringWithFormat:@"%4.0f miles %@ (as the crow flies)", [club distance]/1609.0, [club direction]];
    }
    else {
        club = [[[Data sharedClubData] getClubs] objectAtIndex:index];
        title = [club club];
        subtitle = [NSString stringWithFormat:@"%@, %@, %@", [club city], [club level], [club dayofweek]];
    }
    
    [[cell textLabel] setText:title];
    [[cell detailTextLabel] setText:subtitle];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    MapViewController *next = [segue destinationViewController];
    
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    if (bShowNearby) {
        next.club = [sortedClubs objectAtIndex:selectedRowIndex.row];
        /*
        NSMutableArray *sortedIndexes = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i=0; i<10 && i<sortedClubs.count; ++i) {
            Club *thisClub = [sortedClubs objectAtIndex:i];
            [sortedIndexes addObject:[NSNumber numberWithInt:[thisClub index]]];
        }
        next.subsetIndexes = sortedIndexes;
         */
    }
    else
        next.club = [[[Data sharedClubData] getClubs] objectAtIndex:selectedRowIndex.row];
}

@end
