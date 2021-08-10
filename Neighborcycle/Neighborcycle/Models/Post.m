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
@dynamic image1;
@dynamic image2;
@dynamic image3;
@dynamic updatedAt;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}


@end
