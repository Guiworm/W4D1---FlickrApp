//
//  Photo.h
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Photo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithTitle:(NSString*)title andImage:(UIImage *)image;

@end
