//
//  LoginViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 7/29/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "SceneDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)didTapLogin:(id)sender {
    [self parseLogin];
}

- (void) parseLogin {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    // Log in asynchronously
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            // Create an alert for the error
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Error" message:error.localizedDescription preferredStyle: (UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.passwordField.text = @"";
            }];
            [self presentViewController:alert animated:YES completion:^{}];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            
        } else {
            NSLog(@"User logged in successfully");
            
            // Display tab bar controller after successful login
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
                
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
            myDelegate.window.rootViewController = tabBarController;
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
