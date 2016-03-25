//
//  CollectionChanges.h
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMAUniqueIdentificable.h"

@protocol BMACollectionChangeMove <NSObject>
@property (nonatomic, readonly) NSIndexPath *indexPathOld;
@property (nonatomic, readonly) NSIndexPath *indexPathNew;
@end

@protocol BMACollectionChanges <NSObject>
@property (nonatomic, readonly) NSSet<NSIndexPath*> *insertedIndexPaths;
@property (nonatomic, readonly) NSSet<NSIndexPath*> *deletedIndexPaths;
@property (nonatomic, readonly) NSArray<id<BMACollectionChangeMove>> *movedIndexPaths;
@end

@interface BMACollectionChanges : NSObject
+ (id<BMACollectionChanges>)generageChangesWithOldCollection:(NSArray<id<BMAUniqueIdentificable>>*)oldCollection
                                            newCollection:(NSArray<id<BMAUniqueIdentificable>>*)newCollection;
@end
