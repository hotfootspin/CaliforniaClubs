//
//  LocationViewController.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/26/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Club.h"

@interface LocationViewController : UIViewController <CLLocationManagerDelegate> {
    
}

- (void) computeAllClubDistances:(CLLocation*) loc;
- (void) recolorButton: (id) button;

@property (nonatomic, retain) NSMutableArray *nearbyClubs;
@property (nonatomic, retain) NSMutableArray *clubDistances;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) CLLocation *requestedLocation;
@property (weak, nonatomic) IBOutlet UITextField *requestedLocationField;
- (IBAction)doCurrentLocation:(id)sender;
- (IBAction)doRequestedLocation:(id)sender;
- (IBAction)doCachedLocation:(id)sender;
- (IBAction)checkboxPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSunday;
@property (weak, nonatomic) IBOutlet UIButton *btnMonday;
@property (weak, nonatomic) IBOutlet UIButton *btnTuesday;
@property (weak, nonatomic) IBOutlet UIButton *btnWednesday;
@property (weak, nonatomic) IBOutlet UIButton *btnThursday;
@property (weak, nonatomic) IBOutlet UIButton *btnFriday;
@property (weak, nonatomic) IBOutlet UIButton *btnSaturday;
@property (weak, nonatomic) IBOutlet UIButton *btnMainstream;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;
@property (weak, nonatomic) IBOutlet UIButton *btnAdvanced;
@property (weak, nonatomic) IBOutlet UIButton *btnChallenge;
@property (weak, nonatomic) IBOutlet UIButton *btnRounds;

@end
