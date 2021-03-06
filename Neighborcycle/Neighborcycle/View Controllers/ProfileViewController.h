//
//  ProfileViewController.h
//  Neighborcycle
//
//  Created by Maya Epps on 7/30/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property Boolean *updated;

@end

NS_ASSUME_NONNULL_END
