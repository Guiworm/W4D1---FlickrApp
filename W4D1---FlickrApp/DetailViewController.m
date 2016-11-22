//
//  DetailViewController.m
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-22.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.pageControl.transform = CGAffineTransformMakeRotation(M_PI / 2);
	self.imageView.image = self.photo.image;
	self.upButton.hidden = YES;
	
	self.textView.textContainerInset = UIEdgeInsetsMake(70, 20, 20, 20);
	//self.textView.text = @"PUT DATA HERE";
	//[self.mapView.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
	CGFloat pageHeight = self.scrollView.bounds.size.height;
	NSInteger pageNumber = floor((scrollView.contentOffset.y - pageHeight / 2) / pageHeight) + 1;
	self.pageControl.currentPage = pageNumber;
	
	self.upButton.hidden = NO;
	self.downButton.hidden = NO;
	
	if (self.pageControl.currentPage == 0) {
		self.upButton.hidden = YES;
	}
	if (self.pageControl.currentPage == self.pageControl.numberOfPages-1) {
		self.downButton.hidden = YES;
	}
}
- (IBAction)scrollUp:(UIButton *)sender {
	NSInteger y =  self.scrollView.contentOffset.y - self.scrollView.contentSize.height/self.pageControl.numberOfPages;
	[self.scrollView setContentOffset:CGPointMake(0, y) animated:YES];
	self.upButton.hidden = NO;
}

- (IBAction)scrollDown:(UIButton *)sender {
	NSInteger y =  self.scrollView.contentOffset.y + self.scrollView.contentSize.height/self.pageControl.numberOfPages;
	[self.scrollView setContentOffset:CGPointMake(0, y) animated:YES];
	self.downButton.hidden = NO;
}


@end
