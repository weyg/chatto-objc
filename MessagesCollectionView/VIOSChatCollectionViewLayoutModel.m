//
//  VIOSChatCollectionViewLayoutModel.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSChatCollectionViewLayoutModel.h"

@implementation VIOSChatCollectionViewLayoutModel

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

//+ (instancetype)createModelForCollectionViewWidth:(CGFloat)collectionViewWidth itemsLayoutData:(NSArray <id<VIOSItemLayoutData>>*)itemsLayoutData {
//    NSMutableArray *layoutAttributes = [NSMutableArray new];
//    NSMutableArray *layoutAttributesBySectionAndItem = [NSMutableArray new];
//    [layoutAttributesBySectionAndItem addObject:[NSMutableArray new]];
//    
//    CGFloat verticalOffset = 0;
//    for (NSInteger i=0; i<itemsLayoutData.count; i++) {
//        id<VIOSItemLayoutData> layoutData = itemsLayoutData[i];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        CGFloat height = [layoutData height], bottomMargin = [layoutData bottomMargin];
//        CGSize itemSize = CGSizeMake(collectionViewWidth, height);
//        CGRect frame = CGRectMake(0, verticalOffset, itemSize.width, itemSize.height);
//        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        attributes.frame = frame;
//        [layoutAttributes addObject:attributes];
//        [layoutAttributesBySectionAndItem[0] addObject:attributes];
//        verticalOffset += itemSize.height;
//        verticalOffset += bottomMargin;
//    }
//    
//    return [[self alloc] initWithContentSize:CGSizeMake(collectionViewWidth, verticalOffset)
//                            layoutAttributes:layoutAttributes
//            layoutAttributesBySectionAndItem:layoutAttributesBySectionAndItem
//                          calculatedForWidth:collectionViewWidth];
//}

+ (instancetype)createModelForCollectionViewWidth:(CGFloat)collectionViewWidth itemsLayoutData:(NSArray <id<VIOSItemLayoutData>>*)itemsLayoutData {
    NSMutableArray *layoutAttributes = [NSMutableArray new];
    NSMutableArray *layoutAttributesBySectionAndItem = [NSMutableArray new];
    
    CGFloat verticalOffset = 0;
    for (NSInteger i=0; i<itemsLayoutData.count; i++) {
        id<VIOSItemLayoutData> layoutData = itemsLayoutData[i];
        
        NSArray <id<VIOSItemLayoutData>> *items = layoutData.items;
        if (items.count > 0) { // really sectioned array
            [layoutAttributesBySectionAndItem insertObject:[NSMutableArray new] atIndex:i];

            CGFloat bottomMargin = [layoutData bottomMargin], topMargin = [layoutData topMargin];

            verticalOffset += topMargin;

            for(NSInteger j=0; j<items.count; j++) {
                id<VIOSItemLayoutData> item = items[j];

                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
                CGFloat height = [item height], bottomMargin = [item bottomMargin], topMargin = [item topMargin];
                
                verticalOffset += topMargin;

                CGSize itemSize = CGSizeMake(collectionViewWidth, height);
                CGRect frame = CGRectMake(0, verticalOffset, itemSize.width, itemSize.height);
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                attributes.frame = frame;
                [layoutAttributes addObject:attributes];
                [layoutAttributesBySectionAndItem[i] insertObject:attributes atIndex:j];
                
                verticalOffset += itemSize.height;
                verticalOffset += bottomMargin;
            }
            
            verticalOffset += bottomMargin;

        } else { // just a plain array
            [layoutAttributesBySectionAndItem addObject:[NSMutableArray new]];

            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            CGFloat height = [layoutData height], bottomMargin = [layoutData bottomMargin], topMargin = [layoutData topMargin];
            
            verticalOffset += topMargin;

            CGSize itemSize = CGSizeMake(collectionViewWidth, height);
            CGRect frame = CGRectMake(0, verticalOffset, itemSize.width, itemSize.height);
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = frame;
            [layoutAttributes addObject:attributes];
            [layoutAttributesBySectionAndItem[0] addObject:attributes];
            
            verticalOffset += itemSize.height;
            verticalOffset += bottomMargin;
            
        }
    }
    
    return [[self alloc] initWithContentSize:CGSizeMake(collectionViewWidth, verticalOffset)
                            layoutAttributes:layoutAttributes
            layoutAttributesBySectionAndItem:layoutAttributesBySectionAndItem
                          calculatedForWidth:collectionViewWidth];
}

@end