//
//  VIOSMessagesCollectionViewController+Scrolling.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSMessagesCollectionViewController.h"

typedef enum : NSUInteger {
    VIOSCellVerticalEdgeTop,
    VIOSCellVerticalEdgeBottom,
} VIOSCellVerticalEdge;

@interface VIOSMessagesCollectionViewController (Scrolling)
- (BOOL)isScrolledAtBottom;
- (BOOL)isScrolledAtTop;
- (BOOL)isCloseToBottom;
- (BOOL)isCloseToTop;
- (BOOL)isIndexPathVisible:(NSIndexPath*)indexPath atEdge:(VIOSCellVerticalEdge)edge;
- (CGRect)visibleRect;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToPreservePositionWithOldRect:(CGRect)oldRect newRect:(CGRect)newRect;
@end