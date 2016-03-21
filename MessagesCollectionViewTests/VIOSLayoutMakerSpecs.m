//
//  VIOSLayoutMakerSpecs.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 18/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "VIOSChatLayoutMaker.h"

@interface LayoutSourceItemMock : NSObject <VIOSLayoutSourceItem>

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray <id<VIOSLayoutSourceItem>>* items;

- (instancetype)initWithHeight:(CGFloat)height;
- (instancetype)initWithHeight:(CGFloat)height items:(NSArray <id<VIOSLayoutSourceItem>>*)items;

@end
@implementation LayoutSourceItemMock

- (CGFloat)heightWithFixedWith:(CGFloat)fixedWidth {
    return self.height;
}

- (instancetype)initWithHeight:(CGFloat)height
{
    return [self initWithHeight:height items:nil];
}

- (instancetype)initWithHeight:(CGFloat)height items:(NSArray <id<VIOSLayoutSourceItem>>*)items
{
    self = [super init];
    if (self) {
        _height = height;
        _items = items;
    }
    return self;
}

@end

#import "VIOSLayoutAttributesItemObject.h"

SpecBegin(LayoutMaker)

describe(@"sut", ^{
    __block VIOSChatLayoutMaker *sut;
    
    const CGFloat containerWidth = 100;
    const CGFloat containerHeight = 200;
    
    beforeEach(^{
        sut = [VIOSChatLayoutMaker new];
    });
    
    it(@"should layout plain items of fixed height (100)", ^{
        // given
        CGRect containerFrame = CGRectMake(0, 0, containerWidth, containerHeight);
        
        NSArray *sourceItems = @[
            [[LayoutSourceItemMock alloc] initWithHeight:100],
            [[LayoutSourceItemMock alloc] initWithHeight:100],
            [[LayoutSourceItemMock alloc] initWithHeight:100],
            [[LayoutSourceItemMock alloc] initWithHeight:100],
            [[LayoutSourceItemMock alloc] initWithHeight:100],
            [[LayoutSourceItemMock alloc] initWithHeight:100],
        ];
        LayoutSourceItemMock *sourceItem = [[LayoutSourceItemMock alloc] initWithHeight:0 items:sourceItems];
        
        CGFloat midx = containerWidth/2;
        CGSize sz = CGSizeMake(containerWidth, 100);
        NSArray *expectedAttributesItems = @[
            [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, containerHeight-50) size:sz],
            [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, containerHeight-150) size:sz],
            [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, containerHeight-250) size:sz],
            [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, containerHeight-350) size:sz],
            [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, containerHeight-450) size:sz],
            [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, containerHeight-550) size:sz],
        ];
        VIOSLayoutAttributesItemObject *expectedAttributesItem =
        [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, -100) size:CGSizeMake(containerWidth, 600) items:expectedAttributesItems];
        
        // when
        id<VIOSLayoutAttributesItem> resultingAttributesItem =
        [sut layoutAttributesWithSourceItem:sourceItem containerFrame:containerFrame];
        
        // then
        expect(resultingAttributesItem).equal(expectedAttributesItem);
    });
    
    it(@"should layout sectioned items", ^{
        // given
        CGRect containerFrame = CGRectMake(0, 0, containerWidth, containerHeight);
        
        NSMutableArray *sections = [NSMutableArray new];
        for(NSInteger i=0; i<4; i++) {
            NSArray *its = @[
                                     [[LayoutSourceItemMock alloc] initWithHeight:100],
                                     [[LayoutSourceItemMock alloc] initWithHeight:100],
                                     [[LayoutSourceItemMock alloc] initWithHeight:100],
                                     ];
            LayoutSourceItemMock *si = [[LayoutSourceItemMock alloc] initWithHeight:20 items:its];
            [sections addObject:si];
        }
        LayoutSourceItemMock *sourceItem = [[LayoutSourceItemMock alloc] initWithHeight:50 items:sections];
        
        CGFloat midx = containerWidth/2;
        CGSize sz = CGSizeMake(containerWidth, 100);
        NSArray *expectedAttributesItems =
        @[
          [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 40)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[ // bottom section
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
          [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, -280)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
          [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, -600)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
          [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, -920)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[ // top section
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
         ];
        
        VIOSLayoutAttributesItemObject *expectedAttributesItem =
        [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, -465) size:CGSizeMake(containerWidth, 1330) items:expectedAttributesItems];
        
        // when
        id<VIOSLayoutAttributesItem> resultingAttributesItem =
        [sut layoutAttributesWithSourceItem:sourceItem containerFrame:containerFrame];
//        NSLog(@"expected: \n%@\n===\n", [(VIOSLayoutAttributesItemObject*)expectedAttributesItem debugDescription]);
//        NSLog(@"result: \n%@", [(VIOSLayoutAttributesItemObject*)resultingAttributesItem debugDescription]);
        
        // then
        expect(resultingAttributesItem).equal(expectedAttributesItem);
    });

});

SpecEnd