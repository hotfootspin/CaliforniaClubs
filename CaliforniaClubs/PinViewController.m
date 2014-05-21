//
//  PinViewController.m
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/19/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import "PinViewController.h"
#import "MapViewController.h"
#import "MBMapPin.h"
#import "Data.h"
#import "AppDelegate.h"
#import "UserClubBookmark.h"

// California only
// Crescent City 42, -124
// San Diego 32, -117
// Needles 34, -114
#define US_CENTER_LAT 37.0
#define US_CENTER_LON -119.0
#define US_SPAN_LAT 9.0
#define US_SPAN_LON 9.0

@interface PinViewController ()

@end

@implementation PinViewController

@synthesize mapView;

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

    [self.mapView setDelegate:self];
    
    // define region
    MKCoordinateRegion region;
    region.center.latitude = US_CENTER_LAT;
    region.center.longitude = US_CENTER_LON;
    region.span.latitudeDelta = US_SPAN_LAT;
    region.span.longitudeDelta = US_SPAN_LON;
    [self.mapView setRegion:region animated:NO];

    // annotations
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    CLLocationCoordinate2D location;
    MBMapPin *ann;
    
    // core data - pin lists
    /*
    AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [myAppDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ClubBookmark"];
     */

    NSMutableArray *clubs = [[Data sharedClubData] getClubs];
    int numClubs = clubs.count;
    for (int i=0; i<numClubs; ++i) {
        Club *club = [clubs objectAtIndex:i];

        // more core data
        /*
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"clubId == %i", club.clubId];
        [fetchRequest setPredicate:predicate];
        NSArray *userClubBookmarks = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
        UserClubBookmark *umb;
        if (userClubBookmarks.count > 0)
            umb = [userClubBookmarks objectAtIndex:userClubBookmarks.count-1];
        else
            umb = nil;
        */
        location.latitude = [club latitude];
        location.longitude = [club longitude];
        ann = [[MBMapPin alloc] init];
        [ann setCoordinate:location];
        ann.title = [club club];
        ann.mapIndex = i;
        /*
        ann.normalBeenWant = 0;
        if (umb != nil) {
            if ([umb.beenHere intValue] == 1)
                ann.normalBeenWant = 1;
            if ([umb.wantToGo intValue] == 1)
                ann.normalBeenWant = 2;
        }
         */
        
        [annotations addObject:ann];
    }

    [self.mapView addAnnotations:annotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc]
                                 initWithAnnotation:annotation reuseIdentifier:@"pin"];

    MBMapPin *mapPin = (MBMapPin *) view.annotation;

    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    if (mapPin.normalBeenWant == 2)
        view.pinColor = MKPinAnnotationColorPurple;
    else if (mapPin.normalBeenWant == 1)
        view.pinColor = MKPinAnnotationColorGreen;
    else
        view.pinColor = MKPinAnnotationColorRed;

    view.enabled = YES;
    view.canShowCallout = YES;

    return view;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // if (![view.annotation isKindOfClass:[MyLocation class]])
       // return;
    
    // use the annotation view as the sender
    
    [self performSegueWithIdentifier:@"PinVCSegue" sender:view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender
{
    if ([segue.identifier isEqualToString:@"PinVCSegue"])
    {
        MapViewController *next = [segue destinationViewController];
        MBMapPin *pin = (MBMapPin *) sender.annotation;
        
        // Pass the selected object to the new view controller.
        // NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        next.club = [[[Data sharedClubData] getClubs] objectAtIndex:pin.mapIndex];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
