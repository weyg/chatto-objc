//
//  CollectionChanges.h
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VIOSUniqueIdentificable.h"

@protocol CollectionChangeMove <NSObject>
@property (nonatomic, readonly) NSIndexPath *indexPathOld;
@property (nonatomic, readonly) NSIndexPath *indexPathNew;
@end

@protocol CollectionChanges <NSObject>
@property (nonatomic, readonly) NSSet<NSIndexPath*> *insertedIndexPaths;
@property (nonatomic, readonly) NSSet<NSIndexPath*> *deletedIndexPaths;
@property (nonatomic, readonly) NSArray<id<CollectionChangeMove>> *movedIndexPaths;
@end

@interface CollectionChanges : NSObject
+ (id<CollectionChanges>)generageChangesWithOldCollection:(NSArray<id<VIOSUniqueIdentificable>>*)oldCollection
                                            newCollection:(NSArray<id<VIOSUniqueIdentificable>>*)newCollection;
@end
