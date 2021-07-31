//
//  SignUpViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 7/29/21.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "AppDelegate.h"
#import <CoreLocation/CLGeocoder.h>

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *streetAddressField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *stateField;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapSignUp:(id)sender {
    NSString *fullAddress = [NSString stringWithFormat: @"%@, %@, %@ %@", self.streetAddressField.text, self.cityField.text, self.stateField.text, self.zipCodeField.text];
    [self getGeoPointFromAddress:fullAddress];
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
            [self parseSignUpWithGeoPoint: geopoint];
            
        } else {
            //TODO: make an error message to display to the user
            NSLog(@"Error: Unknown address");
        }
    }];
}

// Signs a new user up in Parse given a PFGeoPoint using the user's responses.
- (void) parseSignUpWithGeoPoint: (PFGeoPoint*) geoPoint {
    
    // Initialize a user object
    PFUser *newUser = [PFUser user];
        
    // Set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    newUser[@"location"] = geoPoint;
    newUser[@"phone_number"] = self.phoneNumberField.text;
    
    // Sign up asynchronously
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // Manually switch to logged in view using root view controller
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
