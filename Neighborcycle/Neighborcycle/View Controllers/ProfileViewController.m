//
//  ProfileViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 7/30/21.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIButton *logOutButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogout:(id)sender {
    
    // Asynchronously log out
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        NSLog(@"Log out successful");
        
        // Manually switch to login view using root view controller
        SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *loginNavController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavController"];
        myDelegate.window.rootViewController = loginNavController;
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
