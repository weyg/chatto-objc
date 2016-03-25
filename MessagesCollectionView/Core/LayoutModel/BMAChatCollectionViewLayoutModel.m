//
//  BMAChatCollectionViewLayoutModel.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAChatCollectionViewLayoutModel.h"

@implementation BMAChatCollectionViewLayoutModel

- (instancetype)initWithContentSize:(CGSize)contentSize
                   layoutAttributes:(NSArray <UICollectionViewLayoutAttributes *> *)layoutAttributes
   layoutAttributesBySectionAndItem:(NSArray <NSArray <UICollectionViewLayoutAttributes *>*> *)layoutAttributesBySectionAndItem
                 calculatedForWidth:(CGFloat)calculatedForWidth
{
    self = [super init];
    if (self) {
        _contentSize = contentSize;
        _layoutAttributes = layoutAttributes;
        _layoutAttributesBySectionAndItem = layoutAttributesBySectionAndItem;
        _calculatedForWidth = calculatedForWidth;
    }
    return self;
}

+ (instancetype)createModelForCollectionViewWidth:(CGFloat)collectionViewWidth
                                  itemsLayoutData:(NSArray <id<BMAItemLayoutData>>*)itemsLayoutData {
    NSMutableArray *layoutAttributes = [NSMutableArray new];
    NSMutableArray *layoutAttributesBySectionAndItem = [NSMutableArray new];
    [layoutAttributesBySectionAndItem addObject:[NSMutableArray new]];
    
    CGFloat verticalOffset = 0;
    for (NSInteger i=0; i<itemsLayoutData.count; i++) {
        id<BMAItemLayoutData> layoutData = itemsLayoutData[i];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat height = [layoutData height], bottomMargin = [layoutData bottomMargin];
        CGSize itemSize = CGSizeMake(collectionViewWidth, height);
        CGRect frame = CGRectMake(0, verticalOffset, itemSize.width, itemSize.height);
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = frame;
        [layoutAttributes addObject:attributes];
        [layoutAttributesBySectionAndItem[0] addObject:attributes];
        verticalOffset += itemSize.height;
        verticalOffset += bottomMargin;
    }
    
    NSLog(@"calculated model for %ld items and width %lf", itemsLayoutData.count, collectionViewWidth);
    
    return [[self alloc] initWithContentSize:CGSizeMake(collectionViewWidth, verticalOffset)
                            layoutAttributes:layoutAttributes
            layoutAttributesBySectionAndItem:layoutAttributesBySectionAndItem
                          calculatedForWidth:collectionViewWidth];
}

@end