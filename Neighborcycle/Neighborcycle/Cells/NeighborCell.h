//
//  NeighborCell.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/20/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFUser.h>

NS_ASSUME_NONNULL_BEGIN

@interface NeighborCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) PFUser *user;

@end

NS_ASSUME_NONNULL_END
