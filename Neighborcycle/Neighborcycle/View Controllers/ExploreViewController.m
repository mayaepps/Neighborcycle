//
//  ExploreViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 7/30/21.
//

#import "ExploreViewController.h"
#import <Parse/Parse.h>

@interface ExploreViewController ()

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Personalize explore screen
    PFUser *currentUser = [PFUser currentUser];
    self.welcomeLabel.text = [NSString stringWithFormat: @"Welcome, %@", currentUser.username];
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
