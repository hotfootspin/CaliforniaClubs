//
//  HomeViewController.m
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/28/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import "HomeViewController.h"
#import "MapListTableTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize bBeenTherePressed;
@synthesize bWantToGoPressed;
@synthesize bListPressed;
@synthesize savedColor;

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
}

- (void) viewWillAppear:(BOOL)animated
{
    for (int i=2; i<=4; ++i) {
        UIButton *b = (UIButton*)[[[self view] subviews] objectAtIndex:i];
        // b.layer.cornerRadius = 8;
        // b.layer.borderColor = [UIColor whiteColor].CGColor;
        // b.layer.borderWidth = 1;
        // b.backgroundColor = [UIColor colorWithRed:166.0/256 green:82.0/256 blue:34.0/256 alpha:1.0];
        
        [b.layer setMasksToBounds:YES];
        [b.layer setCornerRadius:8.0f];
        [b.layer setBorderColor:[UIColor whiteColor].CGColor];
        [b.layer setBorderWidth:1.0f];
        
        CAGradientLayer *grad = [CAGradientLayer layer];
        [grad setBounds:b.bounds];
        NSArray *colors = [NSArray arrayWithObjects:
                           /*
                           (id) [UIColor colorWithRed:180.0f / 255.0f green:90.0f / 255.0f blue:44.0f / 255.0f alpha:1.0f].CGColor, // top
                           (id) [UIColor colorWithRed:150.0f / 245.0f green:70.0f / 255.0f blue:27.0f / 255.0f alpha:1.0f].CGColor, // bottom
                            */
                           (id) [UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:1.0f].CGColor, // top
                           (id) [UIColor colorWithRed:0.6 green:0.1 blue:0.1 alpha:1.0f].CGColor, // bottom
                           nil];
        [grad setPosition:CGPointMake([b bounds].size.width / 2, [b bounds].size.height / 2)];
        [grad setColors:colors];
        
        // if we never assigned a gradient before
        if ([b.layer.sublayers count] < 1)
            [b.layer insertSublayer:grad atIndex:0];
        // if there is already a gradient assigned - replace it instead of adding one
        else
            [b.layer replaceSublayer:[b.layer.sublayers objectAtIndex:0] with:grad];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // ((UIButton*) sender).backgroundColor = [UIColor colorWithRed:0.9 green:0.6 blue:0.2 alpha:1.0];
    // ((UIButton*) sender).backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:0.8 alpha:1.0];
    UIButton *b = (UIButton*) sender;

    CAGradientLayer *grad = [CAGradientLayer layer];
    [grad setBounds:b.bounds];
    NSArray *colors = [NSArray arrayWithObjects:
                       (id) [UIColor colorWithRed:0.2 green:0.4 blue:0.8 alpha:1.0f].CGColor, // top
                       (id) [UIColor colorWithRed:0.1 green:0.3 blue:0.6 alpha:1.0f].CGColor, // bottom
                       nil];
    [grad setPosition:CGPointMake([b bounds].size.width / 2, [b bounds].size.height / 2)];
    [grad setColors:colors];
    // [b.layer insertSublayer:grad atIndex:0];
    [b.layer replaceSublayer:[b.layer.sublayers objectAtIndex:0] with:grad];

    if ([[segue identifier] isEqualToString:@"bookmarkSegue"]) {

        // Get the new view controller using [segue destinationViewController].
        MapListTableTableViewController *next = [segue destinationViewController];
        
        // Pass the selected object to the new view controller.
        if (bBeenTherePressed) {
            next.bShowBeenThere = YES;
            next.bShowWantToGo = NO;
            next.bShowNearby = NO;
        }
        else if (bWantToGoPressed) {
            next.bShowBeenThere = NO;
            next.bShowWantToGo = YES;
            next.bShowNearby = NO;
        }
        else if (bListPressed) {
            next.bShowBeenThere = NO;
            next.bShowWantToGo = NO;
            next.bShowNearby = NO;
        }
    }
}

- (IBAction)beenThereButton:(id)sender {
    bBeenTherePressed = YES;
    bWantToGoPressed = NO;
    bListPressed = NO;
    // UIColor *savedColor = ((UIButton*) sender).backgroundColor;
    // ((UIButton*) sender).backgroundColor = [UIColor colorWithRed:0.9 green:0.6 blue:0.2 alpha:1.0];
    [self performSegueWithIdentifier:@"bookmarkSegue" sender:sender];
    // ((UIButton*) sender).backgroundColor = savedColor;
}

- (IBAction)wantToGoButton:(id)sender {
    bBeenTherePressed = NO;
    bWantToGoPressed = YES;
    bListPressed = NO;
    [self performSegueWithIdentifier:@"bookmarkSegue" sender:sender];
}

- (IBAction)viewListButton:(id)sender {
    bBeenTherePressed = NO;
    bWantToGoPressed = NO;
    bListPressed = YES;
    [self performSegueWithIdentifier:@"bookmarkSegue" sender:sender];
}
@end
