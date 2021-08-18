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
#import "Post.h"

@interface PostDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *expressInterestButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *postedByLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view bringSubviewToFront: self.expressInterestButton];
    
    self.expressInterestButton.layer.shadowColor = UIColor.grayColor.CGColor;
    self.expressInterestButton.layer.shadowOffset = CGSizeMake(5, 5);
    self.expressInterestButton.layer.shadowRadius = 5;
    self.expressInterestButton.layer.shadowOpacity = 1.0;
    
    self.imagesCollectionView.delegate = self;
    self.imagesCollectionView.dataSource = self;
    
    self.titleLabel.text = self.post.title;
    self.notesLabel.text = self.post.notes;
    
    self.conditionLabel.text = [Post getConditionFromIndex: self.post.quality];
    self.postedByLabel.text = [NSString stringWithFormat: @"Posted by %@", self.post.author.username];
    
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
    if (self.post.interestedUsers == nil) {
        self.post.interestedUsers = [NSArray new];
    }
    self.post.interestedUsers = [self.post.interestedUsers arrayByAddingObject:PFUser.currentUser];
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error saving interest request: %@", error.localizedDescription);
        } else {
            NSLog(@"Request saved successfully!");
            
            [self.expressInterestButton setTitle:@"Interest Expressed!" forState:UIControlStateNormal];
        }
    }];
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
