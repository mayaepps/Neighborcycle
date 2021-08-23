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
    [self getGeoPointFromAddress: self.addressTextField.text];
}

- (void) saveUserChanges: (PFUser*) user withGeoPoint: (PFGeoPoint*) geoPoint {
    
    user.username = self.usernameTextField.text;
    user.email = self.emailTextField.text;
    user[@"address"] = self.addressTextField.text;
    user[@"phone_number"] = self.phoneNumberTextField.text;
    user[@"location"] = geoPoint;
    
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

// Gets the geopoint information from the address, before trying to register the user in Parse.
- (void) getGeoPointFromAddress: (NSString*) fullAddress {
    
    // Get the coordinates that correspond to the address.
    [[CLGeocoder new] geocodeAddressString:fullAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks != NULL) {
            PFGeoPoint *geopoint = [PFGeoPoint new];
            CLLocationCoordinate2D coordinate = placemarks[0].location.coordinate;
            
            geopoint.latitude = coordinate.latitude;
            geopoint.longitude = coordinate.longitude;
            [self saveUserChanges: PFUser.currentUser withGeoPoint: geopoint];
            
        } else {
            //TODO: make an error message to display to the user
            NSLog(@"Error: Unknown address");
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
