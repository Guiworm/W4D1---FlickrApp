//
//  DetailViewController.h
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-22.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface DetailViewController : UIViewController <UIScrollViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) Photo *photo;

@end
