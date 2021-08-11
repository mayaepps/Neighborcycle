//
//  CreateViewController.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/10/21.
//

#import "CreateViewController.h"
#import "Post.h"
#import "SceneDelegate.h"
#import "ItemPhotoCell.h"
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>

@interface CreateViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *conditionSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (weak, nonatomic) IBOutlet UIButton *postButton;

@property NSInteger selectedImageIndex;

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;

@property (strong, nonatomic) NSMutableArray *itemPhotos;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemPhotos = [NSMutableArray new];
    
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.delegate = self;
}

- (IBAction)didTapPost:(id)sender {
    
    Post *newPost = [Post new];
    newPost.author = [PFUser currentUser];
    newPost.title = self.titleField.text;
    newPost.notes = self.notesTextView.text;
    newPost.quality = @(self.conditionSegmentedControl.selectedSegmentIndex);
    
    newPost.images = [self convertImagesToPFFiles: self.itemPhotos];
    
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Post saved successfully!");
            self.titleField.text = @"";
            self.notesTextView.text = @"";
            self.conditionSegmentedControl.selectedSegmentIndex = 0;
            [self.itemPhotos removeAllObjects];
            [self.photosCollectionView reloadData];
        }
    }];
}

- (NSMutableArray*) convertImagesToPFFiles: (NSMutableArray*) imageArray {
    
    NSMutableArray *pfFileArray = [NSMutableArray new];
    for (int i = 0; i < imageArray.count; i++) {
        UIImage *image = imageArray[i];
        
        NSData *imageData = UIImagePNGRepresentation(image);
        // get image data and check if that is not nil
        if (!imageData) {
            return nil;
        }
        [pfFileArray addObject: [PFFileObject fileObjectWithName:@"image.png" data:imageData]];
    }
        
    return pfFileArray;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedImageIndex = indexPath.item;
    NSLog(@"Selected cell number: %ld", (long)indexPath.row);
    
    [self openImagePicker];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Display the newly picked image in an image view
    if (self.selectedImageIndex >= self.itemPhotos.count) {
        [self.itemPhotos addObject:editedImage];
    } else {
        [self.itemPhotos replaceObjectAtIndex:self.selectedImageIndex withObject:editedImage];
    }
    [self.photosCollectionView reloadData];
    
    // Dismiss UIImagePickerController to go back to the original view controller
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.item >= self.itemPhotos.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"plusButtonCell" forIndexPath:indexPath];
        return cell;
    }
    
    ItemPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreateItemPhotoCell" forIndexPath:indexPath];
    UIImage *cellImage = [self.itemPhotos objectAtIndex:indexPath.item];
    cell.itemImageView.image = cellImage;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemPhotos.count + 1;
}

@end
