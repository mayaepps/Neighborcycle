//
//  Post.h
//  Neighborcycle
//
//  Created by Maya Epps on 8/10/21.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject <PFSubclassing>

@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSNumber *quality;

@property (nonatomic, strong) PFFileObject *image1;
@property (nonatomic, strong) PFFileObject *image2;
@property (nonatomic, strong) PFFileObject *image3;

@property (nonatomic, strong) NSDate *updatedAt;

@end

NS_ASSUME_NONNULL_END
