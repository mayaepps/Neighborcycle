//
//  SearchTableViewCell.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/13/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet PFImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

- (void) setPost: (Post*) post;

@end

NS_ASSUME_NONNULL_END
