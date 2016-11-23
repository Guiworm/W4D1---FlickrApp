//
//  MapAnnotation.h
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-22.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MapAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;


// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

-(MKAnnotationView*) createAnnotationView;

@end
