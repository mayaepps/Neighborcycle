//
//  ExploreViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 7/30/21.
//

#import "ExploreViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostCollectionViewCell.h"
#import "PostDetailViewController.h"

@interface ExploreViewController ()

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property NSArray<Post*> *posts;

@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Personalize explore screen
    PFUser *currentUser = [PFUser currentUser];
    self.welcomeLabel.text = [NSString stringWithFormat: @"Welcome, %@", currentUser.username];
    
    self.postsCollectionView.delegate = self;
    self.postsCollectionView.dataSource = self;
    
    [self getPosts];
}

- (void) getPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"images"];
    [postQuery whereKey:@"author" notEqualTo:PFUser.currentUser];
    
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.postsCollectionView reloadData];
        } else {
            NSLog(@"Error getting Neighborcycle posts: %@", error.localizedDescription);
        }
    }];
}


#pragma mark - Navigation

 // Preparation for navigation to post detail view.
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     UINavigationController *controller = [segue destinationViewController];
     
     if ([controller class] == [PostDetailViewController class]) {
         // Cast the sender to UICollectionViewCell
         UICollectionViewCell *cell = sender;
         NSIndexPath *indexPath = [self.postsCollectionView indexPathForCell:cell];
         Post *post = self.posts[indexPath.row];
             
         PostDetailViewController *detailsViewController = [segue destinationViewController];
         detailsViewController.post = post;
     }
 }

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
     //Configure the cell...
    Post *post = self.posts[indexPath.item];
    [cell setPost:post];
    
    cell.itemImageView.layer.cornerRadius = 15;
    cell.itemImageView.clipsToBounds = YES;
    
    cell.contentView.layer.cornerRadius = 15;
    cell.contentView.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 15;
    cell.clipsToBounds = YES;

    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 3;
    cell.layer.shadowOpacity = 0.2f;
    cell.layer.masksToBounds = NO;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10); // top, left, bottom, right
}

@end
