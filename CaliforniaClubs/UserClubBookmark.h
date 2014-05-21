//
//  UserClubBookmark.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/28/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserClubBookmark : NSManagedObject

@property (nonatomic, retain) NSNumber * beenHere;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSNumber * clubId;
@property (nonatomic, retain) NSNumber * wantToGo;

@end
