//
//  LSUtilities.h
//  LayerSample
//
//  Created by Kevin Coleman on 7/1/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LayerKit/LayerKit.h>
#import "LSPersistenceManager.h"

/**
 @abstract `LSUtilities` provides convenience functions for app configuration.
 */

typedef enum {
    LYRUIProduction,
    LYRUIDevelopment,
    LYRUIStage1,
    LYRUIDev1,
    LSTestEnvironment,
    LSAdHoc
} LSEnvironment;

BOOL LSIsRunningTests();

NSURL *LSRailsBaseURL();

NSString *LSLayerConfigurationURL(LSEnvironment);

NSUUID *LSLayerAppID(LSEnvironment);

NSString *LSApplicationDataDirectory();

NSString *LSLayerPersistencePath();

LSPersistenceManager *LSPersitenceManager();

void LSAlertWithError(NSError *error);

CGRect LSImageRectForThumb(CGSize size, NSUInteger maxConstraint);

NSString *MIMETypeTextPlain();

NSString *MIMETypeImagePNG();

NSString *MIMETypeImageJPEG();
