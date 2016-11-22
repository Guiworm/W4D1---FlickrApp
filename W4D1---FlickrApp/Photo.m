//
//  Photo.m
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "Photo.h"
@implementation Photo
- (instancetype)initWithTitle:(NSString*)title andURL:(NSURL*)url andImage:(UIImage *)image
{
	self = [super init];
	if (self) {
		_title = title;
		_image = image;
		_url = url;
	}
	return self;
}


@end
