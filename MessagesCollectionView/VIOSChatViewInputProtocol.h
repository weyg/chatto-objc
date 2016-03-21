//
//  VIOSChatViewInputProtocol.h
//  vipole
//
//  Created by Aziz Latypov on 21/01/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VIOSChatChangeTypes.h"

@protocol VIOSChatViewInputProtocol

- (void)beginUpdates;
- (void)endUpdates;

- (void)updateSectionAtIndex:(NSInteger)sectionIndex changeType:(VIOSChatChangeType)type;
- (void)updateMessageAtIndexPath:(NSIndexPath *)oldIndexPath newIndexPath:(NSIndexPath *)newIndexPath changeType:(VIOSChatChangeType)type;

//- (void)finishedLoadPage;
//- (void)showHUD;
//- (void)hideHUD;
//- (void)newMessageCameSoIfPositionIsOutOfVisionPresentScrollToBottomView;
//- (void)dropKeyboard; // Yay !

//@optional
//
//- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(NSInteger)position animated:(BOOL)animated;
//- (void)reloadContents;

@end