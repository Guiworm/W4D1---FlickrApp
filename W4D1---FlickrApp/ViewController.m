//
//  ViewController.m
//  W4D1---FlickrApp
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Photo*> *photoArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&has_geo=1&format=json&nojsoncallback=1&api_key=45b94e6c481a261cbc4d4fadfa6e48d3&tags=cat"]; // 1
	NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2

	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4

	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

		if (error) { // 1
					 // Handle the error
			NSLog(@"error: %@", error.localizedDescription);
			return;
		}

		NSError *jsonError = nil;
		NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2

		if (jsonError) { // 3
						 // Handle the error
			NSLog(@"jsonError: %@", jsonError.localizedDescription);
			return;
		}

		NSMutableArray<Photo*> *photoObjects = [[NSMutableArray alloc] init];

		// If we reach this point, we have successfully retrieved the JSON from the API
		NSDictionary *photosDictionary = [responseObject objectForKey:@"photos"];
		NSArray *photosArray = [photosDictionary objectForKey:@"photo"];

		for (NSDictionary *photo in photosArray) { // 4

			NSString *farm = photo[@"farm"];
			NSString *serverid = photo[@"server"];
			NSString *picid = photo[@"id"];
			NSString *secret = photo[@"secret"];

			NSURL *urlParts = [NSURL URLWithString:[NSString stringWithFormat: @"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, serverid, picid, secret]];

			NSData *data = [NSData dataWithContentsOfURL : urlParts];
			UIImage *urlImage = [UIImage imageWithData: data];
			
			Photo *pic = [[Photo alloc]
						  initWithTitle:photo[@"title"] andURL:urlParts andImage: urlImage];
			[photoObjects addObject:pic];
		}
		self.photoArray = [photoObjects copy];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.collectionView reloadData];
		});
	}];
	
	
	[dataTask resume]; // 6
	
	UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
	
	CGFloat width = self.view.bounds.size.width/2;
	CGFloat height = self.view.bounds.size.height/2;
	CGSize size = CGSizeMake(width, height);
	
	layout.itemSize = size;
}

//- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths{
//	
//}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.photoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	MyCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
	Photo *photoItem = self.photoArray[indexPath.row];
	
	cell.photoObject = photoItem;
	cell.imageView.image = photoItem.image;
	cell.titleLabel.text = photoItem.title;
	
	return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MyCollectionViewCell*)sender{
	DetailViewController *vc = segue.destinationViewController;
	
	if([segue.identifier isEqualToString:@"showDetail"]){
		vc.photo = sender.photoObject;
	}
}

@end
