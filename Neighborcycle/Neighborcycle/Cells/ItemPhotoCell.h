//
//  itemPhotoCell.h
//  
//
//  Created by Maya Epps on 8/11/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemPhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *itemImageView;

@end

NS_ASSUME_NONNULL_END
