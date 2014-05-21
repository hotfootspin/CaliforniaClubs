//
//  HomeViewController.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/28/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

- (IBAction)beenThereButton:(id)sender;
- (IBAction)wantToGoButton:(id)sender;
- (IBAction)viewListButton:(id)sender;

@property (nonatomic, assign) BOOL bBeenTherePressed;
@property (nonatomic, assign) BOOL bWantToGoPressed;
@property (nonatomic, assign) BOOL bListPressed;
@property (nonatomic, assign) UIColor *savedColor;

@end
