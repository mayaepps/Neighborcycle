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
    self.conditionLabel.text = [Post getConditionFromIndex:post.quality];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.3f mi", [PostCollectionViewCell getDistanceFromPost:post]];
    self.itemImageView.file = post.images[0];
}

@end
