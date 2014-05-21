//
//  MBMapPin.h
//  CaliforniaClubs
//
//  Created by Mark Brautigam on 4/19/14.
//  Copyright (c) 2014 Mark Brautigam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MBMapPin : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) int mapIndex;
@property (nonatomic, assign) int normalBeenWant;

- initWithPosition:(CLLocationCoordinate2D)coords;

@end
