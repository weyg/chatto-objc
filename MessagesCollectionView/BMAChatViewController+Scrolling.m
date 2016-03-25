//
//  BMAMessagesCollectionViewController+Scrolling.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAChatViewController+Scrolling.h"

static const CGFloat BMAAutoloadingFractionalThreshold = 0.5;

@implementation BMAChatViewController (Scrolling)

- (BOOL)isScrolledAtBottom {
    if( [self.collectionView numberOfSections] == 0 || [self.collectionView numberOfItemsInSection:0] == 0) {
        return YES;
    }
    
    NSInteger sectionIndex = [self.collectionView numberOfSections] - 1;
    NSInteger itemIndex = [self.collectionView numberOfItemsInSection:sectionIndex] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex];
    return [self isIndexPathVisible:lastIndexPath atEdge:BMACellVerticalEdgeBottom];
}

- (BOOL)isScrolledAtTop {
    if( [self.collectionView numberOfSections] == 0 || [self.collectionView numberOfItemsInSection:0] == 0) {
        return YES;
    }
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    return [self isIndexPathVisible:firstIndexPath atEdge:BMACellVerticalEdgeTop];
}

- (BOOL)isCloseToBottom {
    if( fabs([self.collectionView contentSize].height) <= 0.0001) {
        return YES;
    }

    return CGRectGetMaxY([self visibleRect]) / self.collectionView.contentSize.height > (1 - BMAAutoloadingFractionalThreshold);
}

- (BOOL)isCloseToTop {
    if( fabs([self.collectionView contentSize].height) <= 0.0001) {
        return YES;
    }
    
    return CGRectGetMinY([self visibleRect]) / self.collectionView.contentSize.height < (1 - BMAAutoloadingFractionalThreshold);
}

- (BOOL)isIndexPathVisible:(NSIndexPath*)indexPath atEdge:(BMACellVerticalEdge)edge {
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes) {
        CGRect visibleRect = [self visibleRect];
        CGRect intersection = CGRectIntersection(visibleRect, attributes.frame);
        if (edge == BMACellVerticalEdgeTop) {
            return CGRectGetMinY(intersection) == CGRectGetMinY(attributes.frame);
        } else {
            return CGRectGetMaxY(intersection) == CGRectGetMaxY(attributes.frame);
        }
    }
    return NO;
}

- (CGRect)visibleRect {
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGRect collectionViewBounds = self.collectionView.bounds;
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGSize contentSize = self.collectionView.contentSize;
    return CGRectMake(0, contentOffset.y + contentInset.top,CGRectGetWidth(collectionViewBounds), MIN(contentSize.height, CGRectGetHeight(collectionViewBounds) - contentInset.top - contentInset.bottom));
}

- (void)scrollToBottom:(BOOL)animated {
    // Note that we don't rely on collectionView's contentSize. This is because it won't be valid after performBatchUpdates or reloadData
    // After reload data, collectionViewLayout.collectionViewContentSize won't be even valid, so you may want to refresh the layout manually
    CGFloat a = -self.collectionView.contentInset.top;
    CGFloat b = self.collectionView.collectionViewLayout.collectionViewContentSize.height - self.collectionView.bounds.size.height + self.collectionView.contentInset.bottom;
    CGFloat offsetY = MAX(a, b);
    [self.collectionView setContentOffset:CGPointMake(0, offsetY) animated:animated];
}

- (void)scrollToPreservePositionWithOldRect:(CGRect*)oldRectRef newRect:(CGRect*)newRectRef {
    if (!oldRectRef || !newRectRef) { return; }
    CGFloat diffY = CGRectGetMinY(*newRectRef) - CGRectGetMinY(*oldRectRef);
    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentOffset.y + diffY)];
}

@end

//extension ChatViewController {
//
//        public func scrollViewDidScroll(scrollView: UIScrollView) {
//            if self.collectionView.dragging {
//                self.autoLoadMoreContentIfNeeded()
//            }
//        }
//
//        public func scrollViewDidScrollToTop(scrollView: UIScrollView) {
//            self.autoLoadMoreContentIfNeeded()
//        }
//
//        public func autoLoadMoreContentIfNeeded() {
//            guard self.autoLoadingEnabled, let dataSource = self.chatDataSource else { return }
//
//            if self.isCloseToTop() && dataSource.hasMorePrevious {
//                dataSource.loadPrevious({ [weak self] () -> Void in
//                    self?.enqueueModelUpdate(context: .Pagination)
//                })
//            } else if self.isCloseToBottom() && dataSource.hasMoreNext {
//                dataSource.loadNext({ [weak self] () -> Void in
//                    self?.enqueueModelUpdate(context: .Pagination)
//                })
//            }
//        }
//        }
