//
//  VIOSMessagesCollectionViewLayout.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VIOSChatCollectionViewLayoutModel.h"

@protocol VIOSChatCollectionViewLayoutDelegate <NSObject>
//- (NSInteger)numberOfSections;
//- (NSInteger)numberOfRowsForSectionAtIndex:(NSInteger)sectionIndex;
//- (CGFloat)heightForSectionAtIndex:(NSInteger)sectionIndex;
//- (CGFloat)heightForItemAtIndexPath:(NSIndexPath*)indexPath;
//- (CGSize)collectionViewSize;
- (VIOSChatCollectionViewLayoutModel*)chatCollectionViewLayoutModel;
@end

@interface VIOSChatCollectionViewLayout : UICollectionViewLayout
@property (strong, nonatomic) VIOSChatCollectionViewLayoutModel *layoutModel;
@property (weak, nonatomic) id<VIOSChatCollectionViewLayoutDelegate> delegate;
@end
