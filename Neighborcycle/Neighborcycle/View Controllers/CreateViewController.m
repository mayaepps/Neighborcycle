//
//  CreateViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/10/21.
//

#import "CreateViewController.h"
#import "Post.h"
#import "SceneDelegate.h"

@interface CreateViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property (weak, nonatomic) IBOutlet UIImageView *itemPhoto1;
@property (weak, nonatomic) IBOutlet UIImageView *itemPhoto2;
@property (weak, nonatomic) IBOutlet UIImageView *itemPhoto3;

@property (weak, nonatomic) IBOutlet UISegmentedControl *conditionSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (weak, nonatomic) IBOutlet UIButton *postButton;

@property (strong, nonatomic) NSNumber *imageViewSelected;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapPost:(id)sender {
    
    Post *newPost = [Post new];
    newPost.author = [PFUser currentUser];
    newPost.title = self.titleField.text;
    newPost.notes = self.notesTextView.text;
    newPost.quality = @(self.conditionSegmentedControl.selectedSegmentIndex);
    
    newPost.images = [NSMutableArray new];
    [newPost.images addObject:[Post getPFFileFromImage:self.itemPhoto1.image]];
    [newPost.images addObject:[Post getPFFileFromImage:self.itemPhoto2.image]];
    [newPost.images addObject:[Post getPFFileFromImage:self.itemPhoto3.image]];
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Post saved successfully!");
            self.titleField.text = @"";
            self.notesTextView.text = @"";
            self.conditionSegmentedControl.selectedSegmentIndex = 0;
            self.itemPhoto1.image = [UIImage systemImageNamed:@"plus.app"];
            self.itemPhoto2.image = [UIImage systemImageNamed:@"plus.app"];
            self.itemPhoto3.image = [UIImage systemImageNamed:@"plus.app"];
        }
    }];
}

- (void) openImagePicker {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // Checking that the camera is supported on the device.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera unavailable, using photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didTapImage1:(id)sender {
    NSLog(@"Tapped image1");
    self.imageViewSelected = @1;

    [self openImagePicker];
}
- (IBAction)didTapImage2:(id)sender {
    NSLog(@"Tapped image2");
    self.imageViewSelected = @2;
    
    [self openImagePicker];
}
- (IBAction)didTapImage3:(id)sender {
    NSLog(@"Tapped image3");
    self.imageViewSelected = @3;
    
    [self openImagePicker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Display the newly picked image in the correct image view
    if ([self.imageViewSelected  isEqual: @1]){
        self.itemPhoto1.image = editedImage;
    } else if ([self.imageViewSelected  isEqual: @2]) {
        self.itemPhoto2.image = editedImage;
    } else if ([self.imageViewSelected  isEqual: @3]) {
        self.itemPhoto3.image = editedImage;
    }
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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
