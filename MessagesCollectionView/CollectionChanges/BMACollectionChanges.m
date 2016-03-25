//
//  CollectionChanges.m
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMACollectionChanges.h"

#import "NSArray+BlockKit.h"

#import <UIKit/UIKit.h>

@interface BMACollectionChangeMoveItem : NSObject <BMACollectionChangeMove>
@property (nonatomic, strong) NSIndexPath *indexPathOld;
@property (nonatomic, strong) NSIndexPath *indexPathNew;
- (instancetype)initWithIndexPathOld:(NSIndexPath*)indexPathOld indexPathNew:(NSIndexPath*)indexPathNew;
@end
@implementation BMACollectionChangeMoveItem
- (instancetype)initWithIndexPathOld:(NSIndexPath*)indexPathOld indexPathNew:(NSIndexPath*)indexPathNew {
    self = [super init];
    if (self) {
        _indexPathOld = indexPathOld;
        _indexPathNew = indexPathNew;
    }
    return self;
}
- (NSUInteger)hash {
    return [super hash] ^ [self.indexPathOld hash] ^ [self.indexPathNew hash];
}
- (BOOL)isEqual:(id)object {
    return [super isEqual:object] &&
    [object isMemberOfClass:self.class] &&
    [[self indexPathOld] isEqual:[object indexPathOld]] &&
    [[self indexPathNew] isEqual:[object indexPathNew]];
}
@end

@interface BMACollectionChangesObject : NSObject <BMACollectionChanges>
@property (nonatomic, strong) NSSet<NSIndexPath*> *insertedIndexPaths;
@property (nonatomic, strong) NSSet<NSIndexPath*> *deletedIndexPaths;
@property (nonatomic, strong) NSArray<id<BMACollectionChangeMove>> *movedIndexPaths;
- (instancetype)initWithInsertedIndexPaths:(NSSet*)insertedIndexPaths deletedIndexPaths:(NSSet*)deletedIndexPaths movedIndexPaths:(NSArray*)movedIndexPaths;
@end
@implementation BMACollectionChangesObject
- (instancetype)initWithInsertedIndexPaths:(NSSet*)insertedIndexPaths deletedIndexPaths:(NSSet*)deletedIndexPaths movedIndexPaths:(NSArray*)movedIndexPaths
{
    self = [super init];
    if (self) {
        _insertedIndexPaths = insertedIndexPaths;
        _deletedIndexPaths = deletedIndexPaths;
        _movedIndexPaths = movedIndexPaths;
    }
    return self;
}
@end

@implementation BMACollectionChanges

+ (NSDictionary<NSString*, NSNumber *>*)generateIndexesById:(NSArray<NSString*>*)uids {
    NSMutableDictionary *map = [[NSMutableDictionary alloc] initWithCapacity:uids.count];
    for(NSInteger index = 0; index<uids.count; index++) {
        NSString *uid = uids[index];
        map[uid] = @(index);
    }
    return map;
}

+ (id<BMACollectionChanges>)generageChangesWithOldCollection:(NSArray<id<BMAUniqueIdentificable>>*)oldCollection
                                            newCollection:(NSArray<id<BMAUniqueIdentificable>>*)newCollection
{
    NSArray *oldUids = [oldCollection bk_map:^id(id obj) { return [obj uid]; }];
    NSArray *newUids = [newCollection bk_map:^id(id obj) { return [obj uid]; }];
    NSDictionary<NSString*, NSNumber *>*oldIndexsById = [self generateIndexesById:oldUids];
    NSDictionary<NSString*, NSNumber *>*newIndexsById = [self generateIndexesById:newUids];
    NSMutableSet *deletedIndexPaths = [NSMutableSet new];
    NSMutableSet *insertedIndexPaths = [NSMutableSet new];
    NSMutableArray *movedIndexPaths = [NSMutableArray new];
    
    // Deletions
    for(NSString *oldId in oldUids) {
        BOOL isDeleted = newIndexsById[oldId] == nil;
        if (isDeleted) {
            [deletedIndexPaths addObject:[NSIndexPath indexPathForItem:oldIndexsById[oldId].integerValue inSection:0]];
        }
    }
    
    // Insertions and movements
    for (NSString *newId in newUids) {
        NSInteger newIndex = newIndexsById[newId].integerValue;
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newIndex inSection:0];
        NSNumber *oldIndex = oldIndexsById[newId];
        if (oldIndex) {
            if (oldIndex.integerValue != newIndex) {
                NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:oldIndex.integerValue inSection:0];
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newIndex inSection:0];
                BMACollectionChangeMoveItem *moveItem =
                [[BMACollectionChangeMoveItem alloc] initWithIndexPathOld:oldIndexPath indexPathNew:newIndexPath];
                [movedIndexPaths addObject:moveItem];
            }
        } else {
            // It's new
            [insertedIndexPaths addObject:newIndexPath];
        }
    }
    
    id changes =
    [[BMACollectionChangesObject alloc] initWithInsertedIndexPaths:insertedIndexPaths
                                                 deletedIndexPaths:deletedIndexPaths
                                                   movedIndexPaths:movedIndexPaths];
    
    return changes;
}
@end