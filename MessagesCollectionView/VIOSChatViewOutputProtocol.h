//
//  VIOSChatViewOutputProtocol.h
//  vipole
//
//  Created by Aziz Latypov on 21/01/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VIOSChatViewOutputProtocol

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex;
- (id)presenterForSectionAtIndex:(NSInteger)sectionIndex;
- (id)presenterForCellAtIndexPath:(NSIndexPath *)indexPath;

- (id)messageAtIndexPath:(NSIndexPath *)indexPath;

//- (void)loadNextHistoryPart;
//- (BOOL)canEditCellAtIndexPath:(NSIndexPath*)indexPath;

@end
