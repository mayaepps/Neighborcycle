//
//  UserInfoPopupViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/21/21.
//

#import "UserInfoPopupViewController.h"
#import <MessageUI/MessageUI.h>

@interface UserInfoPopupViewController ()

@end

@implementation UserInfoPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameLabel.text = self.user.username;
    self.emailAddressLabel.text = self.user.email;
    self.phoneNumberLabel.text = self.user[@"phone_number"];
}

- (IBAction)didTapPhoneNumberCopy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.user[@"phone_number"];
}

- (IBAction)didTapEmailCopy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.user.email;
}

- (IBAction)didTapPhone:(id)sender atIndex: (double)index {
    
    NSString *urlString = [NSString stringWithFormat: @"tel:%@", self.user[@"phone_number"]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
    
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Success opening phone app.");
            }
        }];
    }
}

- (IBAction)didTapMail:(id)sender {
    
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"This device does not have a mail app.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat: @"mailto:%@?subject=Neighborcycle item you are interested in", self.user.email];

    NSString *encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: encodedURL] options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Success opening mail app.");
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
