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
@property (strong, nonatomic) CLLocationManager* manager;

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
	NSString *urlString = [NSString stringWithFormat: @"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=45b94e6c481a261cbc4d4fadfa6e48d3&photo_id=%@&format=json&nojsoncallback=1", self.photo.picId];
	
	NSURL *url = [NSURL URLWithString: urlString];
	
	
	NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
	
	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		
		if (error) {
					 // Handle the error
			NSLog(@"error: %@", error.localizedDescription);
			return;
		}
		
		NSError *jsonError = nil;
		NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
		
		if (jsonError) { // 3
						 // Handle the error
			NSLog(@"jsonError: %@", jsonError.localizedDescription);
			return;
		}
		
		self.manager = [CLLocationManager new];
		
		self.manager.delegate = self;
		[self.manager requestAlwaysAuthorization];
		[self.manager startUpdatingLocation];
		
		
		
		
		NSDictionary *photoDict = responseObject[@"photo"];
		NSDictionary *location = photoDict[@"location"];
		
		NSString *longitude = location[@"longitude"];
		NSString *latitude = location[@"latitude"];
		self.photo.location = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
		
		MapAnnotation* annotation = [[MapAnnotation alloc] init];
		annotation.title = self.photo.title;
		annotation.coordinate = self.photo.location;
		
		MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
		self.mapView.region = MKCoordinateRegionMake(self.photo.location, span);
		
		//Add anotation
		[self.mapView addAnnotation:annotation];
	}];
	
	[dataTask resume];

	
}

#pragma GeoLocation

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
	CLLocation* location = [locations lastObject];
	
	CLGeocoder* geocoder = [CLGeocoder new];
	[geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
		if (!error)
		{
			CLPlacemark* placemark = [placemarks lastObject];
			NSLog(@"The address is: %@", placemark.addressDictionary);
		}
	}];
	
	//    NSLog(@"You are at lat: %f and long: %f", location.coordinate.latitude, location.coordinate.longitude);
	
	[self centreMapKit:location];
}

-(void) centreMapKit:(CLLocation*) location
{
	MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
	
	[self.mapView setRegion:region];
}

-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[MapAnnotation class]])
	{
		MapAnnotation* mapAnnotation = (MapAnnotation*) annotation;
		MKAnnotationView* view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
		
		if (!view)
		{
			view = [mapAnnotation createAnnotationView];
		}
		else
		{
			view.annotation = annotation;
		}
		
		return view;
	}
	else
	{
		return nil;
	}
}

#pragma Scroll Views

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
