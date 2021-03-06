//
//  BMALayoutMakerSpecs.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 18/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "BMAChatLayoutMaker.h"

#import "BMALayoutAttributesItemObject.h"
#import "LayoutSourceItemStub.h"

SpecBegin(LayoutMaker)

describe(@"sut", ^{
    __block BMAChatLayoutMaker *sut;
    
    const CGFloat containerWidth = 100;
    
    beforeEach(^{
        sut = [BMAChatLayoutMaker new];
    });
    
    it(@"should layout plain items of fixed height (100)", ^{
        // given
        NSArray *sourceItems = @[
            [[LayoutSourceItemStub alloc] initWithHeight:100],
            [[LayoutSourceItemStub alloc] initWithHeight:100],
            [[LayoutSourceItemStub alloc] initWithHeight:100],
            [[LayoutSourceItemStub alloc] initWithHeight:100],
            [[LayoutSourceItemStub alloc] initWithHeight:100],
            [[LayoutSourceItemStub alloc] initWithHeight:100],
        ];
        LayoutSourceItemStub *sourceItem = [[LayoutSourceItemStub alloc] initWithHeight:0 items:sourceItems];
        
        CGFloat height = 100*6;
        CGFloat midx = containerWidth/2;
        CGSize sz = CGSizeMake(containerWidth, 100);
        NSArray *expectedAttributesItems = @[
            [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-50) size:sz],
            [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-150) size:sz],
            [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-250) size:sz],
            [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-350) size:sz],
            [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-450) size:sz],
            [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-550) size:sz],
        ];
        BMALayoutAttributesItemObject *expectedAttributesItem =
        [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointZero size:CGSizeMake(containerWidth, 600) items:expectedAttributesItems];
        
        // when
        id<BMALayoutAttributesItem> resultingAttributesItem =
        [sut layoutAttributesWithSourceItem:sourceItem fixedWidth:containerWidth minimalHeight:0];
        
        // then
        expect(resultingAttributesItem).equal(expectedAttributesItem);
    });
    
    it(@"should layout sectioned items", ^{
        // given
        NSMutableArray *sections = [NSMutableArray new];
        for(NSInteger i=0; i<4; i++) {
            NSArray *its = @[
                                     [[LayoutSourceItemStub alloc] initWithHeight:100],
                                     [[LayoutSourceItemStub alloc] initWithHeight:100],
                                     [[LayoutSourceItemStub alloc] initWithHeight:100],
                                     ];
            LayoutSourceItemStub *si = [[LayoutSourceItemStub alloc] initWithHeight:20 items:its];
            [sections addObject:si];
        }
        LayoutSourceItemStub *sourceItem = [[LayoutSourceItemStub alloc] initWithHeight:50 items:sections];
        
        CGFloat height = 320*4+50;
        CGFloat midx = containerWidth/2;
        CGSize sz = CGSizeMake(containerWidth, 100);
        NSArray *expectedAttributesItems =
        @[
          [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-320*0.5)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[ // bottom section
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
          [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-320*1.5)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
          [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-320*2.5)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
          [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, height-320*3.5)
                                                            size:CGSizeMake(containerWidth, 320)
                                                           items:@[ // top section
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-50) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-150) size:sz],
                                                                   [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointMake(midx, 320-250) size:sz],
                                                                   ]],
         ];
        
        BMALayoutAttributesItemObject *expectedAttributesItem =
        [[BMALayoutAttributesItemObject alloc] initWithCenter:CGPointZero size:CGSizeMake(containerWidth, height) items:expectedAttributesItems];
        
        // when
        id<BMALayoutAttributesItem> resultingAttributesItem =
        [sut layoutAttributesWithSourceItem:sourceItem fixedWidth:containerWidth minimalHeight:0];
        NSLog(@"expected: \n%@\n===\n", [(BMALayoutAttributesItemObject*)expectedAttributesItem debugDescription]);
        NSLog(@"result: \n%@", [(BMALayoutAttributesItemObject*)resultingAttributesItem debugDescription]);
        
        // then
        expect(resultingAttributesItem).equal(expectedAttributesItem);
    });

});

SpecEnd