//
//  PostCollectionViewCell.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/12/21.
//

#import "PostCollectionViewCell.h"
#import "Post.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@implementation PostCollectionViewCell

- (void)viewDidLoad {
    [self viewDidLoad];
}

- (void)setPost:(Post *)post {
    NSLog(@"%@", post);
    self.itemImageView.file = post.images[0];
    [self.itemImageView loadInBackground];
    
    NSArray *conditions = @[@"Poor condition", @"Fair condition", @"Good condition", @"Very good condition", @"As new condition"];
    self.conditionLabel.text = conditions[post.quality.intValue];

    double distance = [PostCollectionViewCell getDistanceFromPost:post];
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", distance];
    
    self.titleLabel.text = post.title;
}

// Gets the distance between the location of the user who posted the item and the current user's location.
+ (double) getDistanceFromPost: (Post*) post {
    PFGeoPoint *postLocation = post.author[@"location"];
    PFGeoPoint *userLocation = PFUser.currentUser[@"location"];
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:postLocation.latitude longitude:postLocation.longitude];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:userLocation.latitude longitude:userLocation.longitude];

    CLLocationDistance distance = [locA distanceFromLocation:locB];
    return distance/1609; // TODO: figure out constants in objective-c
}

@end
