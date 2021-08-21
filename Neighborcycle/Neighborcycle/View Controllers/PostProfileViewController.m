//
//  PostProfileViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/20/21.
//

#import "PostProfileViewController.h"
#import "NeighborCell.h"
#import "UserPostImageCell.h"
#import <Parse/PFImageView.h>

@interface PostProfileViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@end

@implementation PostProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.itemTitleLabel.text = self.post.title;
    self.conditionLabel.text = [Post getConditionFromIndex:self.post.quality];
    self.notesLabel.text = self.post.notes;
    
    [self.collectionView reloadData];
    [self.tableView reloadData];
}

- (IBAction)didTapDeletePost:(id)sender {
    [self.post deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [self.navigationController popViewControllerAnimated:YES];
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
    
    UserPostImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserPostImageCell" forIndexPath:indexPath];
     //Configure the cell...
    cell.imageView.file = self.post.images[indexPath.item];
    [cell.imageView loadInBackground];

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.post.images.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NeighborCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NeighborCell" forIndexPath:indexPath];
    
    //Configure the cell...
    PFUser *interestedUser = self.post.interestedUsers[indexPath.item];
    [interestedUser fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        cell.nameLabel.text = interestedUser.username;
        cell.user = interestedUser;
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.post.interestedUsers.count;
}

@end
