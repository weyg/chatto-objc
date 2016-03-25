//
//  BMAMessagesCollectionViewLayout.m
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import "BMAChatCollectionViewLayout.h"
#import "NSArray+BlockKit.h"

@interface BMAChatCollectionViewLayout ()
// Optimization: after reloadData we'll get invalidateLayout, but prepareLayout will be delayed until next run loop.
// Client may need to force prepareLayout after reloadData, but we don't want to compute layout again in the next run loop.
@property (nonatomic, assign) BOOL layoutNeedsUpdate;
@end

@implementation BMAChatCollectionViewLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _layoutNeedsUpdate = YES;
    }
    return self;
}

- (void)invalidateLayout {
    [super invalidateLayout];
    self.layoutNeedsUpdate = YES;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    if (!self.layoutNeedsUpdate) { return; }
    if (!self.delegate) { return; }
    
    __block BMAChatCollectionViewLayoutModel *oldLayoutModel = self.layoutModel;
    self.layoutModel = [self.delegate chatCollectionViewLayoutModel];
    self.layoutNeedsUpdate = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Dealloc of layout with 5000 items take 25 ms on tests on iPhone 4s
        // This moves dealloc out of main thread
        if (oldLayoutModel != nil) {
            // Use nil check above to remove compiler warning: Variable 'oldLayoutModel' was written to, but never read
            oldLayoutModel = nil;
        }
    });
}

- (CGSize)collectionViewContentSize {
    if (self.layoutNeedsUpdate) {
        [self prepareLayout];
    }
    
    return self.layoutModel.contentSize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.layoutModel.layoutAttributes bk_filter:^(id obj){ return CGRectIntersectsRect([obj frame], rect); }];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.layoutModel.layoutAttributesBySectionAndItem.count && indexPath.item < self.layoutModel.layoutAttributesBySectionAndItem[indexPath.section].count) {
        return self.layoutModel.layoutAttributesBySectionAndItem[indexPath.section][indexPath.item];
    }
    assert(false);
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return fabs(self.layoutModel.calculatedForWidth - newBounds.size.width) > 0.0001;
}

@end
