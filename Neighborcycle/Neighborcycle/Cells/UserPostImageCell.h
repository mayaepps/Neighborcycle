//
//  UserPostImageCell.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/20/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPostImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *imageView;

@end

NS_ASSUME_NONNULL_END
