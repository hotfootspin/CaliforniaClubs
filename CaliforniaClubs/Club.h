//
//  Club.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/16/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Club : NSObject

@property (nonatomic, copy) NSString* club;
@property (nonatomic, copy) NSString* dayofweek;
@property (nonatomic, copy) NSString* level;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* county;
@property (nonatomic, copy) NSString* caller;
@property (nonatomic, copy) NSString* venue;
@property (nonatomic, copy) NSString* address;
@property (nonatomic, copy) NSString* contact;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double distance;
@property (nonatomic, copy) NSString* direction;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) int clubId;
@property (nonatomic, copy) NSString* web;

@end
