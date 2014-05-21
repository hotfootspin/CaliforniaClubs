//
//  MoreTableViewController.m
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/22/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import "MoreTableViewController.h"
#import "Club.h"
#import "AppDelegate.h"
#import "UserClubBookmark.h"

@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

@synthesize club;
@synthesize bBeenHere;
@synthesize bWantToGo;
@synthesize clubName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    clubName.title = [club club];
    

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
    return 1; // so far
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 12; // so far // removed comments field
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"morecell" ]; //  forIndexPath:indexPath]; // not 5.1
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"morecell"];
    
    /*
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"morecell"];
    }
     */
    
    // Configure the cell...
    switch (indexPath.row) {
            /*
        case 0:
            cell.textLabel.text = @"Club";
            cell.detailTextLabel.text = [club club];
            break;
             */
            
        case 0:
            cell.textLabel.text = @"Day";
            cell.detailTextLabel.text = [club dayofweek];
            break;
            
        case 1:
            cell.textLabel.text = @"City";
            cell.detailTextLabel.text = [club city];
            break;
            
        case 2:
            cell.textLabel.text = @"County";
            cell.detailTextLabel.text = [club county];
            break;
            
        case 3:
            cell.textLabel.text = @"Level";
            cell.detailTextLabel.text = [club level];
            break;
            
        case 4:
            cell.textLabel.text = @"Caller";
            cell.detailTextLabel.text = [club caller];
            break;
            
        case 5:
            cell.textLabel.text = @"Venue";
            cell.detailTextLabel.text = [club venue];
            break;
            
        case 6:
            cell.textLabel.text = @"Address";
            cell.detailTextLabel.text = [club address];
            break;
            
        case 7:
            cell.textLabel.text = @"Latitude";
            cell.detailTextLabel.text = [[NSNumber numberWithDouble:[club latitude]] stringValue];
            break;
            
        case 8:
            cell.textLabel.text = @"Longitude";
            cell.detailTextLabel.text = [[NSNumber numberWithDouble:[club longitude]] stringValue];
            break;
            
        case 9:
            cell.textLabel.text = @"Contact";
            cell.detailTextLabel.text = [club contact];
            break;
            
        case 10:
            cell.textLabel.text = @"Web Site";
            cell.detailTextLabel.text = [club web];
            if ([[club web] length] > 5) {
                // put clickable code here
            }
            break;
            
        case 11:
            cell.textLabel.text = @"Club ID";
            cell.detailTextLabel.text = [[NSNumber numberWithInt:[club clubId]] stringValue];
            break;
            
        default:
            break;
    }
 
    
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
