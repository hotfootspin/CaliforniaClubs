//
//  Data.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/17/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Club.h"

@interface Data : NSObject {
    NSMutableArray *clubs;
}

+ (Data*) sharedClubData;

- (NSMutableArray*) getClubs;

- (Club*) strToClub:(NSString*)club;

@end


