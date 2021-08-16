//
//  PostDetailViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/15/21.
//

#import "PostDetailViewController.h"
#import "DetailImageCell.h"
#import <MapKit/MKMapView.h>
#import <Parse/PFGeoPoint.h>
#import <MapKit/MKPointAnnotation.h>
#import <CoreLocation/CoreLocation.h>

@interface PostDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *expressInterestButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesCollectionView.delegate = self;
    self.imagesCollectionView.dataSource = self;
    
    self.titleLabel.text = self.post.title;
    self.notesLabel.text = self.post.notes;
    
    self.expressInterestButton.layer.cornerRadius = 10;
    
    [self setUpMapView];
}

- (void) setUpMapView {
    self.mapView.delegate = self;
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    
    PFGeoPoint *location = self.post.author[@"location"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(location.latitude, location.longitude);
    [annotation setCoordinate:coord];
    annotation.title = self.post.title;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:region];
    
    [self.mapView addAnnotation: annotation];
    
}

- (IBAction)didExpressInterest:(id)sender {
    NSLog(@"Expressed interest in this item");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
    DetailImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailsImageCell" forIndexPath:indexPath];
    //Configure the cell...
    cell.itemImageView.file = self.post.images[indexPath.item];
    [cell.itemImageView loadInBackground];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.post.images.count;
}


@end
