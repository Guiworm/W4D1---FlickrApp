//
//  MapAnnotation.m
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-22.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation 

-(void) setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
	_coordinate = newCoordinate;
}

-(MKAnnotationView*) createAnnotationView
{
	MKAnnotationView* view = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"annotation"];
	view.enabled = YES;
	view.canShowCallout = YES;
	view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	return view;
}

@end
