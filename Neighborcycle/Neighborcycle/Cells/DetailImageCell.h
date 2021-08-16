//
//  DetailImageCell.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/15/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *itemImageView;

@end

NS_ASSUME_NONNULL_END
