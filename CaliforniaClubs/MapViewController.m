//
//  MapViewController.m
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/16/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import "MapViewController.h"
#import "MoreTableViewController.h"
#import "UserClubBookmark.h"
#import "Data.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize club;
@synthesize clubCaption;
@synthesize clubImage;
@synthesize titleView;
@synthesize myAppDelegate;
@synthesize context;
@synthesize userClubBookmarks;
@synthesize beenHereButton;
@synthesize wantToGoButton;
@synthesize subsetIndexes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadClubData];
}

- (void) loadClubData
{
    // Core Data - get the user data
    myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = [myAppDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ClubBookmark"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"clubId == %i", club.clubId];
    [fetchRequest setPredicate:predicate];
    userClubBookmarks = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];

    UIView * uiv = (UIView*)[[[self view] subviews] objectAtIndex:0];
    uiv.layer.shadowColor = [UIColor blackColor].CGColor;
    uiv.layer.shadowOffset = CGSizeMake (4, 4);
    uiv.layer.shadowOpacity = 1;
    uiv.layer.shadowRadius = 12.0;
    uiv.clipsToBounds = NO;
    
    titleView.title = [club club];
    
    [clubCaption setText:club.club];
    
    // Core Data - get the checkmark data if there is any
    
    if ([userClubBookmarks count] > 0) {
        // There may be more than one match. If so, the last one
        // seems to be the one that is most recent.
        // 
        UserClubBookmark *umbm = (UserClubBookmark *) [userClubBookmarks objectAtIndex:[userClubBookmarks count]-1];
        if ([umbm.beenHere intValue] == 1) {
            beenHereButton.selected = YES;
        }
        else {
            beenHereButton.selected = NO;
        }
        if ([umbm.wantToGo intValue] == 1) {
            wantToGoButton.selected = YES;
        }
        else {
            wantToGoButton.selected = NO;
        }
    }
    else {
        // if there is no Core Data for this club, then both checkmarks are OFF
        beenHereButton.selected = NO;
        wantToGoButton.selected = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    for (int i=4; i<=5; ++i) {
        UIButton *b = (UIButton*)[[[self view] subviews] objectAtIndex:i];
        // b.layer.cornerRadius = 8;
        // b.layer.borderColor = [UIColor whiteColor].CGColor;
        // b.layer.borderWidth = 1;
        // b.backgroundColor = [UIColor colorWithRed:166.0/256 green:82.0/256 blue:34.0/256 alpha:1.0];
        // b.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;

        [b.layer setMasksToBounds:YES];
        [b.layer setCornerRadius:8.0f];
        [b.layer setBorderColor:[UIColor whiteColor].CGColor];
        [b.layer setBorderWidth:1.0f];
        
        CAGradientLayer *grad = [CAGradientLayer layer];
        [grad setBounds:b.bounds];
        NSArray *colors = [NSArray arrayWithObjects:
                           (id) [UIColor colorWithRed:180.0f / 255.0f green:90.0f / 255.0f blue:44.0f / 255.0f alpha:1.0f].CGColor, // top
                           (id) [UIColor colorWithRed:150.0f / 245.0f green:70.0f / 255.0f blue:27.0f / 255.0f alpha:1.0f].CGColor, // bottom
                           nil];
        [grad setPosition:CGPointMake([b bounds].size.width / 2, [b bounds].size.height / 2)];
        [grad setColors:colors];
        [b.layer insertSublayer:grad atIndex:0];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    // Get the new view controller using [segue destinationViewController].
    MoreTableViewController *next = [segue destinationViewController];

    // Pass the selected object to the new view controller.
    next.club = club;
}

- (void) saveCoreData
{
    // Core data - save the state
    // See if we have a data entry for this club first
    UserClubBookmark *existingBookmark = nil;
    
    // The reason we have a problem here is because the variable
    // "userClubBookmarks" is fetched from the persistent store only
    // when this view is loaded.
    //
    // But a new entry could be saved to the store every time one
    // of the buttons is pressed, which could be two, if the user
    // changes both checkboxes, or even many more than two, if the
    // user clicks a checkbox or checkboxes many times for whatever
    // reason. (Confused? Goofing off? Letting child play?)
    //
    // So even though we delete all previously-exisitng data entries
    // this time, there may be a bunch more of them next time.
    //
    // The alternative is to do another fetch here. But then we would
    // be doing many fetches.
    //
    
    // OK, there are still lots of problems, so I will do the fetch here
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ClubBookmark"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"clubId == %i", club.clubId];
    [fetchRequest setPredicate:predicate];
    userClubBookmarks = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];

    if ([userClubBookmarks count] > 0) {
        // delete all existing matching bookmarks
        int count = [userClubBookmarks count];
        for (int i=0; i<count; ++i) {
            existingBookmark = (UserClubBookmark *) [userClubBookmarks objectAtIndex:i];
            [context deleteObject:existingBookmark];
        }
    }
    
    // If not, then we save it
    // Create a new managed object
    UserClubBookmark *newUserClubBookmark = (UserClubBookmark *) [NSEntityDescription
                                                               insertNewObjectForEntityForName:@"ClubBookmark"
                                                               inManagedObjectContext:context];
    newUserClubBookmark.clubId = [NSNumber numberWithInt:club.clubId];
    if (beenHereButton.selected)
        newUserClubBookmark.beenHere = [NSNumber numberWithInt:1];
    else
        newUserClubBookmark.beenHere = [NSNumber numberWithInt:0];
    if (wantToGoButton.selected)
        newUserClubBookmark.wantToGo = [NSNumber numberWithInt:1];
    else
        newUserClubBookmark.wantToGo = [NSNumber numberWithInt:0];
    newUserClubBookmark.comments = @"";
    /*
     [newUserClubBookmark setValue:[NSNumber numberWithInt:club.id] forKey:@"id"];
     [newUserClubBookmark setValue:[NSNumber numberWithBool:b.selected] forKey:@"beenHere"];
     */
    
    // Save the object to persistent store
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (IBAction)bookmarkBeenHere:(id)sender {
    static bool state = NO;
    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Been Here" message:@"Been Here" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    // [alert show];
    UIButton *b = (UIButton*) sender;
    b.selected = !b.selected;
    /*
    if (state == YES) {
        // [b setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    else {
        // [b setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
     */
    state = !state;
    
    [self saveCoreData];
}

- (IBAction)bookmarkWantToGo:(id)sender {
    static bool state = NO;
    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Want To Go" message:@"Want To Go" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    // [alert show];
    UIButton *b = (UIButton*) sender;
    b.selected = !b.selected;
    
    /*
    if (state == YES)
        [b setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    else
        [b setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
     */
    state = !state;
    
    [self saveCoreData];
}

- (IBAction)btnNext:(id)sender {
    

    // find the next club in the list
    NSMutableArray *clubs = [[Data sharedClubData] getClubs];
    if (subsetIndexes != nil) {
        for (int i=0; i<subsetIndexes.count; ++i) {
            if (club.index == [[subsetIndexes objectAtIndex:i] intValue]) {
                int nextIndex = (i+1) % ([subsetIndexes count]);
                club = [clubs objectAtIndex:[[subsetIndexes objectAtIndex:nextIndex] intValue]];
                break;
            }
        }
    }
    else {
        int nClubs = clubs.count;
        if (club.index >= nClubs-1)
            club = [clubs objectAtIndex:0];
        else
            club = [clubs objectAtIndex:club.index+1];
    }
    [self loadClubData];
    [self reloadInputViews];
}

- (IBAction)btnPrevious:(id)sender {


    // find the previous club in the list
    NSMutableArray *clubs = [[Data sharedClubData] getClubs];
    if (subsetIndexes != nil) {
        for (int i=0; i<subsetIndexes.count; ++i) {
            if (club.index == [[subsetIndexes objectAtIndex:i] intValue]) {
                int prevIndex;
                if (i==0)
                    prevIndex = [subsetIndexes count] - 1; // mod % doesn't work for i<0
                else
                    prevIndex = (i-1);
                club = [clubs objectAtIndex:[[subsetIndexes objectAtIndex:prevIndex] intValue]];
                break;
            }
        }
    }
    else {
        int nClubs = clubs.count;
        if (club.index == 0)
            club = [clubs objectAtIndex:nClubs-1];
        else
            club = [clubs objectAtIndex:club.index-1];
    }
    [self loadClubData];
    [self reloadInputViews];
}
@end
