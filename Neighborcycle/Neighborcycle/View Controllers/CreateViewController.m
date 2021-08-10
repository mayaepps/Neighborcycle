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
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Post saved successfully!");
            self.titleField.text = @"";
            self.notesTextView.text = @"";
            self.conditionSegmentedControl.selectedSegmentIndex = 0;
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
