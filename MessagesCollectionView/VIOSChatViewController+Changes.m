//
//  VIOSChatViewController+Changes.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSChatViewController+Changes.h"

#import "VIOSChatCollectionViewLayout.h"
#import "VIOSChatCollectionViewLayoutModel.h"

#import "VIOSChatDataSourceProtocol.h"

#import "NSArray+BlockKit.h"
#import "NSSet+BlockKit.h"

#import "VIOSChatViewController+Scrolling.h"
#import "VIOSChatViewController+Presenters.h"

#import "CollectionChanges.h"

static NSInteger preferredMaxMessageCount = 500;
static double updatesAnimationDuration = 0.35;

@interface IntermediateItemLayoutData : NSObject <VIOSItemLayoutData>
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonnull, strong) NSArray <id<VIOSItemLayoutData>> *items;
- (instancetype)initWithHeight:(CGFloat)height topMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin items:(NSArray <id<VIOSItemLayoutData>> *)items;
@end
@implementation IntermediateItemLayoutData
- (instancetype)initWithHeight:(CGFloat)height topMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin items:(NSArray <id<VIOSItemLayoutData>> *)items
{
    self = [super init];
    if (self) {
        _height = height;
        _bottomMargin = bottomMargin;
        _topMargin = topMargin;
    }
    return self;
}
@end

@protocol ModelChanges <NSObject>
@property (nonatomic, readonly) id<CollectionChanges> changes;
@property (nonatomic, readonly) void(^updateModelClosure)();
@end

@interface ModelChangesItem : NSObject <ModelChanges>
@property (nonatomic, readonly) id<CollectionChanges> changes;
@property (nonatomic, readonly) void(^updateModelClosure)();
- (instancetype)initWithChanges:(id<CollectionChanges>)changes
             updateModelClosure:(void(^)())updateModelClosure;
@end
@implementation ModelChangesItem
- (instancetype)initWithChanges:(id<CollectionChanges>)changes
             updateModelClosure:(void(^)())updateModelClosure;
{
    self = [super init];
    if (self) {
        _changes = changes;
        _updateModelClosure = updateModelClosure;
    }
    return self;
}
@end

@implementation VIOSDecorateChatItemObject
- (instancetype)initWithChatItem:(id<VIOSChatItemProtocol>)chatItem
                      attributes:(id<ChatItemDecorationAttributesProtocol>)attributes
{
    self = [super init];
    if (self) {
        _chatItem = chatItem;
        _decorationAttributes = attributes;
    }
    return self;
}
@end

typedef void(^UpdatesBlock)(id<CollectionChanges>, void(^)());

@implementation VIOSChatViewController (Changes)

- (void)chatDataSourceDidUpdate:(id<VIOSChatDataSourceProtocol>)chatDataSource context:(VIOSChatUpdateType)context
{
    [self enqueueModelUpdate:context];
}

- (void)enqueueModelUpdate:(VIOSChatUpdateType)context {
    NSArray *newItems = [self.chatDataSource chatItems];
    __weak typeof(self) weakSelf = self;
    [self.updateQueue addTask:^(VIOSTaskClosureComletion completion) {
        __strong typeof(self) sSelf = weakSelf;
        
        NSArray *oldItems = [sSelf.decoratedChatItems bk_map:^(id obj){ return [obj chatItem]; }];
        [sSelf updateModels:newItems oldItems:oldItems context:context completion:^{
            if (sSelf.updateQueue.isEmpty) {
                [sSelf enqueueMessageCountReductionIfNeeded];
            }
            completion();
        }];
    }];
}

- (void)enqueueMessageCountReductionIfNeeded {
    if ([self.chatDataSource chatItems].count <= preferredMaxMessageCount) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.updateQueue addTask:^(VIOSTaskClosureComletion completion) {
        __strong typeof(self) sSelf = weakSelf;

        __weak typeof(self) weakSelf = sSelf;
        [sSelf.chatDataSource adjustNumberOfMessagesToPreferredMaxCount:preferredMaxMessageCount focusPosition:sSelf.focusPosition completion:^(BOOL didAdjust) {
            __strong typeof(self) sSelf = weakSelf;
            
            if (!sSelf) {
                completion();
                return;
            }
            
            NSArray *newItems = sSelf.chatDataSource.chatItems;
            NSArray *oldItems = [sSelf.decoratedChatItems bk_map:^(id obj){ return [obj chatItem]; }];
            [sSelf updateModels:newItems oldItems:oldItems context:VIOSChatUpdateMessageCountReduction completion:completion];
        }];
    }];
}

// Returns scrolling position in interval [0, 1], 0 top, 1 bottom
- (double)focusPosition {
    if ([self isCloseToBottom]) {
        return 1.0;
    } else if ([self isCloseToTop]) {
        return 0;
    }
    
    double contentHeight = self.collectionView.contentSize.height;
    if (contentHeight <= 0) {
        return 0.5;
    }
    
    // Rough estimation
    double midContentOffset = self.collectionView.contentOffset.y + self.visibleRect.size.height / 2;
    return MIN(MAX(0, midContentOffset / contentHeight), 1.0);
}

- (void)updateVisibleCells:(id<CollectionChanges>)changes {
    // Datasource should be already updated!
    
    NSMutableSet<NSIndexPath*> *visibleIndexPaths =
    [NSMutableSet setWithArray:[self.collectionView.indexPathsForVisibleItems bk_filter:^BOOL(id obj) {
        return ![[changes insertedIndexPaths] containsObject:obj] && ![[changes deletedIndexPaths] containsObject:obj];
    }]];
    
    NSMutableSet<NSIndexPath*> *updatedIndexPaths = [NSMutableSet new];
    for (id<CollectionChangeMove> move in [changes movedIndexPaths]) {
        NSIndexPath *indexPathOld = [move indexPathOld];
        NSIndexPath *indexPathNew = [move indexPathNew];

        [updatedIndexPaths addObject:indexPathOld];
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPathOld];
        if (cell) {
            id<ChatItemPresenterProtocol> presenter = [self presenterForIndexPath:indexPathNew];
            id<ChatItemDecorationAttributesProtocol> decorationAttributes = [self decorationAttributesForIndexPath:indexPathNew];
            [presenter configureCell:cell decorationAttributes:decorationAttributes];
        }
    }
    
    // Update remaining visible cells
    NSSet<NSIndexPath*> *remaining = [visibleIndexPaths bk_reject:^BOOL(id obj) { // remaining = visibleIndexPaths - updatedIndexPaths
        return [updatedIndexPaths containsObject:obj];
    }];
    for (NSIndexPath *indexPath in remaining) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        if (cell) {
            id<ChatItemPresenterProtocol> presenter = [self presenterForIndexPath:indexPath];
            id<ChatItemDecorationAttributesProtocol> decorationAttributes = [self decorationAttributesForIndexPath:indexPath];
            [presenter configureCell:cell decorationAttributes:decorationAttributes];
        }
    }
}

- (void)performBatchUpdates:(void(^)())updateModelClosure
                    changes:(id<CollectionChanges>)changes
                    context:(VIOSChatUpdateType)context completion:(void(^)())completion
{
    BOOL shouldScrollToBottom = context != VIOSChatUpdatePagination && self.isScrolledAtBottom;
    CGRect oldRect = [self rectAtIndexPath:[[changes movedIndexPaths].firstObject indexPathOld]];
    void(^myCompletion)() = ^{
        // Found that cells may not match correct index paths here yet! (see comment below)
        // Waiting for next loop seems to fix the issue
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    };
    
    if (context == VIOSChatUpdateNormal) {
        [UIView animateWithDuration:updatesAnimationDuration animations:^{
            [self.collectionView performBatchUpdates:^{
            // We want to update visible cells to support easy removal of bubble tail or any other updates that may be needed after a data update
            // Collection view state is not constistent after performBatchUpdates. It can happen that we ask a cell for an index path and we still get the old one.
            // Visible cells can be either updated in completion block (easier but with delay) or before, taking into account if some cell is gonna be moved

                updateModelClosure();
                [self updateVisibleCells:changes];
                
                [self.collectionView deleteItemsAtIndexPaths:[[changes deletedIndexPaths] allObjects]];
                [self.collectionView insertItemsAtIndexPaths:[[changes insertedIndexPaths] allObjects]];

                for (id<CollectionChangeMove> move in [changes movedIndexPaths]) {
                    [self.collectionView moveItemAtIndexPath:[move indexPathOld] toIndexPath:[move indexPathNew]];
                }

            } completion:^(BOOL finished) {
                myCompletion();
            }];
        }];
    } else {
        updateModelClosure();
        [self.collectionView reloadData];
        [self.collectionView.collectionViewLayout prepareLayout];
        myCompletion();
    }
    
    if (shouldScrollToBottom) {
        [self scrollToBottom:(context == VIOSChatUpdateNormal)];
    } else {
        CGRect newRect = [self rectAtIndexPath:[[[changes movedIndexPaths] firstObject] indexPathNew]];
        [self scrollToPreservePositionWithOldRect:oldRect newRect:newRect];
    }
}

- (void)updateModels:(NSArray<id<VIOSChatItemProtocol>>*)newItems oldItems:(NSArray<id<VIOSChatItemProtocol>>*)oldItems context:(VIOSChatUpdateType)context completion:(void(^)())completion {
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    context = self.isFirstLayout ? VIOSChatUpdateFirstLoad : context;
    BOOL performInBackground = context != VIOSChatUpdateFirstLoad;

    self.autoLoadingEnabled = NO;
    
    __weak typeof(self) weakSelf = self;
    UpdatesBlock perfomBatchUpdates = ^(id<CollectionChanges> changes, void(^updateModelClosure)()) {
        [weakSelf performBatchUpdates:updateModelClosure
                              changes:changes
                              context:context
                           completion:^{
            weakSelf.autoLoadingEnabled = YES;
            completion();
        }];
    };
    
    id<ModelChanges> (^createModelUpdate)() = ^{
        return [weakSelf createModelUpdates:newItems oldItems:oldItems collectionViewWidth:collectionViewWidth];
    };

    if (performInBackground) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            id<ModelChanges> modelUpdate = createModelUpdate();
            dispatch_async(dispatch_get_main_queue(), ^{
                perfomBatchUpdates(modelUpdate.changes, modelUpdate.updateModelClosure);
            });
        });
    } else {
        id<ModelChanges> modelUpdate = createModelUpdate();
        perfomBatchUpdates(modelUpdate.changes, modelUpdate.updateModelClosure);
    }
}

- (id<ModelChanges>)createModelUpdates:(NSArray<id<VIOSChatItemProtocol>>*)newItems
                              oldItems:(NSArray<id<VIOSChatItemProtocol>>*)oldItems
                   collectionViewWidth:(double)collectionViewWidth
{
    
    NSArray<id<VIOSDecoratedChatItem>> *newDecoratedItems;
    if (self.chatItemsDecorator) {
        newDecoratedItems = [self.chatItemsDecorator decorateItems:newItems];
    } else {
        newDecoratedItems = [newItems bk_map:^id(id obj) {
            return [[VIOSDecorateChatItemObject alloc] initWithChatItem:obj attributes:nil];
        }];
    }
    
    id<CollectionChanges> changes =
    [CollectionChanges generageChangesWithOldCollection:oldItems newCollection:newItems];
    
    id layoutModel = [self createLayoutModel:newDecoratedItems collectionViewWidth:collectionViewWidth];
    
    __weak typeof(self) wSelf = self;
    id updateModelClosure = ^{
        __strong typeof(self) sSelf = wSelf;
        
        sSelf.layoutModel = layoutModel;
        sSelf.decoratedChatItems = newDecoratedItems;
    };
    
    return [[ModelChangesItem alloc] initWithChanges:changes updateModelClosure:updateModelClosure];
}

- (VIOSChatCollectionViewLayoutModel *)createLayoutModel:(NSArray<id<VIOSDecoratedChatItem>>*)decoratedItems collectionViewWidth:(double)collectionViewWidth {
    BOOL isInbackground = ![NSThread isMainThread];
    NSMutableArray *itemsForMainThread = [NSMutableArray new];
    NSMutableArray *intermediateLayoutData = [NSMutableArray new];
    
    for (NSInteger index = 0; index < decoratedItems.count; index++) {
        id<VIOSDecoratedChatItem> decoratedItem = decoratedItems[index];
        id<ChatItemPresenterProtocol> presenter = [self presenterForIndex:index decoratedChatItems:decoratedItems];
        id<ChatItemDecorationAttributesProtocol> decorationAttributes = [decoratedItem decorationAttributes];
        double height = 0;
        double bottomMargin = [decorationAttributes bottomMargin];
        double topMargin = [decorationAttributes topMargin];
        if (!isInbackground) {
            height = [presenter heightForCell:collectionViewWidth decorationAttributes:decorationAttributes];
        } else {
            [itemsForMainThread addObject:@[@(index), decoratedItem, presenter]];
        }
        
        [intermediateLayoutData addObject:[[IntermediateItemLayoutData alloc] initWithHeight:height topMargin:topMargin bottomMargin:bottomMargin items:nil]];
    }
    
    if (itemsForMainThread.count > 0) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            for (NSArray *tuple in itemsForMainThread) {
                NSInteger index = [tuple[0] integerValue];
                id<VIOSDecoratedChatItem> decoratedItem = tuple[1];
                id<ChatItemPresenterProtocol> presenter = tuple[2];

                CGFloat height = [presenter heightForCell:collectionViewWidth decorationAttributes:decoratedItem.decorationAttributes];
                [intermediateLayoutData[index] setHeight:height];
            }
        });
    }
    
    return [VIOSChatCollectionViewLayoutModel createModelForCollectionViewWidth:self.collectionView.bounds.size.width itemsLayoutData:intermediateLayoutData];
}

- (VIOSChatCollectionViewLayoutModel *)chatCollectionViewLayoutModel {
    if (self.layoutModel.calculatedForWidth != self.collectionView.bounds.size.width) {
        self.layoutModel =
        [self createLayoutModel:self.decoratedChatItems
            collectionViewWidth:self.collectionView.bounds.size.width];
    }
    return self.layoutModel;
}

@end

