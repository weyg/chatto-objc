//
//  BMAMessagesCollectionViewController+Scrolling.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAChatViewController.h"

typedef enum : NSUInteger {
    BMACellVerticalEdgeTop,
    BMACellVerticalEdgeBottom,
} BMACellVerticalEdge;

@interface BMAChatViewController (Scrolling)
- (BOOL)isScrolledAtBottom;
- (BOOL)isScrolledAtTop;
- (BOOL)isCloseToBottom;
- (BOOL)isCloseToTop;
- (BOOL)isIndexPathVisible:(NSIndexPath*)indexPath atEdge:(BMACellVerticalEdge)edge;
- (CGRect)visibleRect;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToPreservePositionWithOldRect:(CGRect*)oldRectRef newRect:(CGRect*)newRectRef;
@end