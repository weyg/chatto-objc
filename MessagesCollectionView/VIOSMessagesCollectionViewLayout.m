//
//  VIOSMessagesCollectionViewLayout.m
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import "VIOSMessagesCollectionViewLayout.h"

#import "VIOSLayoutItemProtocol.h"
#import "VIOSChatLayoutMaker.h"

#import "LayoutSourceItemStub.h"

@interface VIOSMessagesCollectionViewLayout ()
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) NSMutableArray <id<VIOSLayoutSourceItem>> *items;

@property (nonatomic, strong) id<VIOSLayoutAttributesItem> resultingAttributesItem;
@end

@implementation VIOSMessagesCollectionViewLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _contentSize = CGSizeZero;
    _items = [NSMutableArray new];
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//    CGPoint p = [self.collectionView contentOffset];
//    if (fabs(p.x - proposedContentOffset.x) > 0.00001) {
//        proposedContentOffset.x = p.x;
//    }
//    return proposedContentOffset;
//}

- (void)setDelegate:(id<VIOSMessagesCollectionViewLayoutDelegate>)delegate {
    _delegate = delegate;
    [self layoutItems];
}

- (void)layoutItems {
    assert(_items.count == 0);
    
    CGSize size = [self.delegate collectionViewSize];
    CGFloat width = size.width;
    
    NSMutableArray *sections = [NSMutableArray new];
    for(NSInteger i=0; i<4; i++) {
        NSArray *its = @[
                         [[LayoutSourceItemStub alloc] initWithHeight:34],
                         [[LayoutSourceItemStub alloc] initWithHeight:34],
                         [[LayoutSourceItemStub alloc] initWithHeight:34],
                         ];
        LayoutSourceItemStub *si = [[LayoutSourceItemStub alloc] initWithHeight:12 items:its];
        [sections addObject:si];
    }
    LayoutSourceItemStub *sourceItem = [[LayoutSourceItemStub alloc] initWithHeight:14 items:sections];

    VIOSChatLayoutMaker *sut = [VIOSChatLayoutMaker new];
    NSLog(@"calculate layout =>");
    self.resultingAttributesItem =
    [sut layoutAttributesWithSourceItem:sourceItem fixedWidth:width minimalHeight:0]; //size.height
    NSLog(@"calculate layout <=");

    self.contentSize = [self.resultingAttributesItem size];
}

#pragma mark - Subclassing -

- (void)invalidateLayout {
    [super invalidateLayout];
    
    _items = [NSMutableArray new];
}

- (CGSize)collectionViewContentSize {
    return self.contentSize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // find top level items for given rect
    NSArray *sectionItems = [self.resultingAttributesItem items];
    NSInteger i,j;
    NSMutableArray *attributes = [NSMutableArray new];

    for (i=0; i<sectionItems.count; i++) {
        id<VIOSLayoutAttributesItem> sectionItem = [sectionItems objectAtIndex:i];
        CGRect sectionRect = CGRectMake(sectionItem.center.x, sectionItem.center.y, sectionItem.size.width, sectionItem.size.height);
        
        if (CGRectIntersectsRect(sectionRect, rect)) {

            NSArray *items = [sectionItem items];
            for (j=0; j<items.count; j++) {
                id<VIOSLayoutAttributesItem> rowItem = [items objectAtIndex:j];
                
                CGFloat sectionTop = sectionItem.center.y - sectionItem.size.height/2;
                CGRect rowRect = CGRectMake(rowItem.center.x, sectionTop + rowItem.center.y, rowItem.size.width, rowItem.size.height);
                
                if (CGRectIntersectsRect(rowRect, rect)) {
                    
                    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
                    [attributes addObject:attr];
                }
            }

        }
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    NSArray *sectionItems = [self.resultingAttributesItem items];
    id<VIOSLayoutAttributesItem> sectionItem = [sectionItems objectAtIndex:indexPath.section];
    NSArray *items = [sectionItem items];
    id<VIOSLayoutAttributesItem> rowItem = [items objectAtIndex:indexPath.row];

    CGFloat sectionTop = sectionItem.center.y - sectionItem.size.height/2;
    
    CGPoint center = rowItem.center;
    center.y += sectionTop;
    
    CGRect bounds = CGRectMake(0, 0, rowItem.size.width, rowItem.size.height);
    
    attr.bounds = bounds;
    attr.center = center;

//    NSLog(@"indexPath (row: %ld, sec: %ld", [indexPath row], [indexPath section]);
    
    return attr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - Updates -

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
    return nil;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    
}

- (void)finalizeCollectionViewUpdates {
    
}

@end
