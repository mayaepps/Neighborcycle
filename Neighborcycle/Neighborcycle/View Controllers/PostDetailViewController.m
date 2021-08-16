//
//  PostDetailViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/15/21.
//

#import "PostDetailViewController.h"
#import "DetailImageCell.h"

@interface PostDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *expressInterestButton;

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesCollectionView.delegate = self;
    self.imagesCollectionView.dataSource = self;
    
    self.titleLabel.text = self.post.title;
    self.notesLabel.text = self.post.notes;
    
    self.expressInterestButton.layer.cornerRadius = 10;
    
}

- (IBAction)didExpressInterest:(id)sender {
    NSLog(@"Expressed interest in this item");
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
   
    DetailImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailsImageCell" forIndexPath:indexPath];
    //Configure the cell...
    cell.itemImageView.file = self.post.images[indexPath.item];
    [cell.itemImageView loadInBackground];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.post.images.count;
}

@end
