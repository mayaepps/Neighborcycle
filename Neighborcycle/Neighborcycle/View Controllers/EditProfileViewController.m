//
//  EditProfileViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/19/21.
//

#import "EditProfileViewController.h"
#import <Parse/Parse.h>

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveChangesButton;


@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *user = PFUser.currentUser;
    
    self.usernameTextField.text = user.username;
    self.addressTextField.text = user[@"address"];
    self.emailTextField.text = user.email;
    self.phoneNumberTextField.text = user[@"phone_number"];
    
    self.saveChangesButton.layer.shadowColor = UIColor.grayColor.CGColor;
    self.saveChangesButton.layer.shadowOffset = CGSizeMake(3, 3);
    self.saveChangesButton.layer.shadowRadius = 3;
    self.saveChangesButton.layer.shadowOpacity = 0.5;
}

- (IBAction)didTapSaveChanges:(id)sender {
    PFUser *user = PFUser.currentUser;
    
    user.username = self.usernameTextField.text;
    user.email = self.emailTextField.text;
    user[@"address"] = self.addressTextField.text;
    user[@"phone_number"] = self.phoneNumberTextField.text;
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Changes saved successfully!");
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (error) {
            NSLog(@"Error saving the user's profile changes: %@", error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
 

@end
