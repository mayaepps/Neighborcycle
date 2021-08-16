//
//  SearchTableViewCell.m
//  Neighborcycle
//
//  Created by Maya Epps on 8/13/21.
//

#import "SearchTableViewCell.h"
#import "PostCollectionViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPost: (Post*) post {
    self.titleLabel.text = post.title;
    NSArray *conditions = @[@"Poor condition", @"Fair condition", @"Good condition", @"Very good condition", @"As new condition"];
    self.conditionLabel.text = conditions[post.quality.intValue];
    self.distanceLabel.text = [NSString stringWithFormat:@"%f mi", [PostCollectionViewCell getDistanceFromPost:post]];
    self.itemImageView.file = post.images[0];
}

@end
