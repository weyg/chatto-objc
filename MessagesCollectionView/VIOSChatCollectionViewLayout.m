//
//  VIOSMessagesCollectionViewLayout.m
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import "VIOSChatCollectionViewLayout.h"

#import "VIOSLayoutItemProtocol.h"
#import "VIOSChatLayoutMaker.h"

#import "LayoutSourceItemStub.h"

#import "NSArray+BlockKit.h"

@interface VIOSChatCollectionViewLayout ()
//@property (nonatomic, assign) CGSize contentSize;
//@property (nonatomic, strong) NSMutableArray <id<VIOSLayoutSourceItem>> *items;
//
//@property (nonatomic, strong) id<VIOSLayoutAttributesItem> resultingAttributesItem;

// Optimization: after reloadData we'll get invalidateLayout, but prepareLayout will be delayed until next run loop.
// Client may need to force prepareLayout after reloadData, but we don't want to compute layout again in the next run loop.
@property (nonatomic, assign) BOOL layoutNeedsUpdate;
@end

@implementation VIOSChatCollectionViewLayout

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
    
    __block VIOSChatCollectionViewLayoutModel *oldLayoutModel = self.layoutModel;
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

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setup];
//    }
//    return self;
//}
//
//- (void)setup {
//    _contentSize = CGSizeZero;
//    _items = [NSMutableArray new];
//}
//
////- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
////    CGPoint p = [self.collectionView contentOffset];
////    if (fabs(p.x - proposedContentOffset.x) > 0.00001) {
////        proposedContentOffset.x = p.x;
////    }
////    return proposedContentOffset;
////}
//
//- (void)setDelegate:(id<VIOSMessagesCollectionViewLayoutDelegate>)delegate {
//    _delegate = delegate;
//    [self layoutItems];
//}
//
//- (void)layoutItems {
//    assert(_items.count == 0);
//    
//    CGSize size = [self.delegate collectionViewSize];
//    CGFloat width = size.width;
//    
//    NSMutableArray *sections = [NSMutableArray new];
//    for(NSInteger i=0; i<4; i++) {
//        NSArray *its = @[
//                         [[LayoutSourceItemStub alloc] initWithHeight:34],
//                         [[LayoutSourceItemStub alloc] initWithHeight:34],
//                         [[LayoutSourceItemStub alloc] initWithHeight:34],
//                         ];
//        LayoutSourceItemStub *si = [[LayoutSourceItemStub alloc] initWithHeight:12 items:its];
//        [sections addObject:si];
//    }
//    LayoutSourceItemStub *sourceItem = [[LayoutSourceItemStub alloc] initWithHeight:14 items:sections];
//
//    VIOSChatLayoutMaker *sut = [VIOSChatLayoutMaker new];
//    NSLog(@"calculate layout =>");
//    self.resultingAttributesItem =
//    [sut layoutAttributesWithSourceItem:sourceItem fixedWidth:width minimalHeight:0]; //size.height
//    NSLog(@"calculate layout <=");
//
//    self.contentSize = [self.resultingAttributesItem size];
//}
//
//#pragma mark - Subclassing -
//
//- (void)invalidateLayout {
//    [super invalidateLayout];
//    
//    _items = [NSMutableArray new];
//}
//
//- (CGSize)collectionViewContentSize {
//    return self.contentSize;
//}
//
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    // find top level items for given rect
//    NSArray *sectionItems = [self.resultingAttributesItem items];
//    NSInteger i,j;
//    NSMutableArray *attributes = [NSMutableArray new];
//
//    for (i=0; i<sectionItems.count; i++) {
//        id<VIOSLayoutAttributesItem> sectionItem = [sectionItems objectAtIndex:i];
//        CGRect sectionRect = CGRectMake(sectionItem.center.x, sectionItem.center.y, sectionItem.size.width, sectionItem.size.height);
//        
//        if (CGRectIntersectsRect(sectionRect, rect)) {
//
//            NSArray *items = [sectionItem items];
//            for (j=0; j<items.count; j++) {
//                id<VIOSLayoutAttributesItem> rowItem = [items objectAtIndex:j];
//                
//                CGFloat sectionTop = sectionItem.center.y - sectionItem.size.height/2;
//                CGRect rowRect = CGRectMake(rowItem.center.x, sectionTop + rowItem.center.y, rowItem.size.width, rowItem.size.height);
//                
//                if (CGRectIntersectsRect(rowRect, rect)) {
//                    
//                    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
//                    [attributes addObject:attr];
//                }
//            }
//
//        }
//    }
//    
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//    NSArray *sectionItems = [self.resultingAttributesItem items];
//    id<VIOSLayoutAttributesItem> sectionItem = [sectionItems objectAtIndex:indexPath.section];
//    NSArray *items = [sectionItem items];
//    id<VIOSLayoutAttributesItem> rowItem = [items objectAtIndex:indexPath.row];
//
//    CGFloat sectionTop = sectionItem.center.y - sectionItem.size.height/2;
//    
//    CGPoint center = rowItem.center;
//    center.y += sectionTop;
//    
//    CGRect bounds = CGRectMake(0, 0, rowItem.size.width, rowItem.size.height);
//    
//    attr.bounds = bounds;
//    attr.center = center;
//
////    NSLog(@"indexPath (row: %ld, sec: %ld", [indexPath row], [indexPath section]);
//    
//    return attr;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}
//
//#pragma mark - Updates -
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
//    return nil;
//}
//
//- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
//    
//}
//
//- (void)finalizeCollectionViewUpdates {
//    
//}

@end
