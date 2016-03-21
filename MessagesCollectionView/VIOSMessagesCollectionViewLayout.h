//
//  VIOSMessagesCollectionViewLayout.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VIOSMessagesCollectionViewLayout;

@protocol VIOSMessagesCollectionViewLayoutDelegate <NSObject>
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsForSectionAtIndex:(NSInteger)sectionIndex;
- (CGFloat)heightForSectionAtIndex:(NSInteger)sectionIndex;
- (CGFloat)heightForItemAtIndexPath:(NSIndexPath*)indexPath;
- (CGSize)collectionViewSize;
@end

@interface VIOSMessagesCollectionViewLayout : UICollectionViewLayout
@property (weak, nonatomic) id<VIOSMessagesCollectionViewLayoutDelegate> delegate;
@end
