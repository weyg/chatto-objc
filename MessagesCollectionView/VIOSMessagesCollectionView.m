//
//  VIOSMessagesCollectionView.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSMessagesCollectionView.h"
#import "VIOSMessagesCollectionViewLayout.h"

@implementation VIOSMessagesCollectionView

- (NSInteger)numberOfSections {
    return 4;
}

- (NSInteger)numberOfRowsForSectionAtIndex:(NSInteger)sectionIndex {
    return 3;
}

- (CGFloat)heightForSectionAtIndex:(NSInteger)sectionIndex {
    return 0;
}

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath*)indexPath {
    return 0;
}

- (CGSize)collectionViewSize {
    return self.bounds.size;
}

@end
