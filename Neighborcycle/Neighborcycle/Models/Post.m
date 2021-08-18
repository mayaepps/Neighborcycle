//
//  Post.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/10/21.
//

#import "Post.h"

@implementation Post

@dynamic author;
@dynamic title;
@dynamic notes;
@dynamic quality;
@dynamic images;
@dynamic updatedAt;
@dynamic interestedUsers;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


@end
