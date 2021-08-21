//
//  PostProfileViewController.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/20/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostProfileViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
