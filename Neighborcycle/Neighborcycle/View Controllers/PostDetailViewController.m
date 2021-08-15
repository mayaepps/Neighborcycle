//
//  PostDetailViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/15/21.
//

#import "PostDetailViewController.h"

@interface PostDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.post.title;
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
