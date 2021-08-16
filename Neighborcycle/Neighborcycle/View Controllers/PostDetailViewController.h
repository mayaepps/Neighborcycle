//
//  PostDetailViewController.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/15/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostDetailViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, MKMapViewDelegate>

@property Post *post;

@end

NS_ASSUME_NONNULL_END
