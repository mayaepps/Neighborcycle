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

@interface ExploreViewController ()

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
     //Configure the cell...
    Post *post = self.posts[indexPath.item];
    [cell setPost:post];
    
    cell.itemImageView.layer.cornerRadius = 15;
    cell.itemImageView.clipsToBounds = YES;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
