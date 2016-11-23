//
//  Photo.h
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import MapKit;

@interface Photo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *picId;
@property (strong, nonatomic) NSURL *url;
@property (nonatomic) CLLocationCoordinate2D location;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithTitle:(NSString*)title andURL:(NSURL*)url andID:(NSString*)picId andImage:(UIImage *)image;

@end
