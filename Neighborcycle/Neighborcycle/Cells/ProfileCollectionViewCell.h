//
//  ProfileCollectionViewCell.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/18/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
