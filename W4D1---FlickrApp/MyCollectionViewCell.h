//
//  MyCollectionViewCell.h
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface MyCollectionViewCell : UICollectionViewCell
@property (nonatomic) Photo *photoObject;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
