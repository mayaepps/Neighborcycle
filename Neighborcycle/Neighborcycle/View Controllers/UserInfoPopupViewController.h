//
//  UserInfoPopupViewController.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/21/21.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserInfoPopupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressLabel;

@property (strong, nonatomic) PFUser *user;

@end

NS_ASSUME_NONNULL_END
