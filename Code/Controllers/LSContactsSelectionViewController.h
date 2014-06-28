//
//  LSContactsSelectionViewController.h
//  LayerSample
//
//  Created by Kevin Coleman on 6/12/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LayerKit/LayerKit.h>

@class LSContactsSelectionViewController;

@protocol LSContactsSelectionViewControllerDelegate <NSObject>

@required
- (void)contactsSelectionViewController:(LSContactsSelectionViewController *)contactsSelectionViewController didSelectContacts:(NSSet *)contacts;
- (void)contactsSelectionViewControllerDidCancel:(LSContactsSelectionViewController *)contactsSelectionViewController;

@end

/**
 @abstract The `LSContactsSelectionViewController` class provides an interface for selecting a group of contacts.
 */
@interface LSContactsSelectionViewController : UITableViewController

@property (nonatomic, weak) id<LSContactsSelectionViewControllerDelegate> delegate;

@end
