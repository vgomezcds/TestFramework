//
//  FClass.m
//  TestFramework
//
//  Created by Viry Gomez on 2/19/16.
//  Copyright © 2016 CodigoDelSur. All rights reserved.
//

#import "FClass.h"
#import <MicroBlink/MicroBlink.h>
#import "ViewToShow.h"
#import <opencv2/cvconfig.h>
#import <AFNetworking/AFNetworking.h>

@implementation FClass

+ (void)printOnConsole {
    NSLog(@"SWING!");
}

/**
 * Method allocates and initializes the Scanning coordinator object.
 * Coordinator is initialized with settings for scanning
 *
 *  @param error Error object, if scanning isn't supported
 *
 *  @return initialized coordinator
 */
- (PPCoordinator *)coordinatorWithError:(NSError**)error {
    
    /** 0. Check if scanning is supported */
    
    if ([PPCoordinator isScanningUnsupported:error]) {
        return nil;
    }
    
    
    /** 1. Initialize the Scanning settings */
    
    // Initialize the scanner settings object. This initialize settings with all default values.
    PPSettings *settings = [[PPSettings alloc] init];
    
    
    /** 2. Setup the license key */
    
    // Visit www.microblink.com to get the license key for your app
    settings.licenseSettings.licenseKey = @"YXH25YNJ-CV7SNCDH-JWBG7IUV-6E5UYDUG-GQYAGQ2Z-EDEPPGKJ-O5KAQRDA-ID2NNNJI";
    
    
    /**
     * 3. Set up what is being scanned. See detailed guides for specific use cases.
     * Here's an example for initializing PDF417 scanning
     */
    
    // To specify we want to perform PDF417 recognition, initialize the PDF417 recognizer settings
    PPPdf417RecognizerSettings *pdf417RecognizerSettings = [[PPPdf417RecognizerSettings alloc] init];
    
    // Add PDF417 Recognizer setting to a list of used recognizer settings
    [settings.scanSettings addRecognizerSettings:pdf417RecognizerSettings];
    
    // To specify we want to perform recognition of other barcode formats, initialize the ZXing recognizer settings
    PPZXingRecognizerSettings *zxingRecognizerSettings = [[PPZXingRecognizerSettings alloc] init];
    zxingRecognizerSettings.scanQR = YES; // we use just QR code
    
    // Add ZXingRecognizer setting to a list of used recognizer settings
    [settings.scanSettings addRecognizerSettings:zxingRecognizerSettings];
    
    // To specify we want to scan USDLs, initialize USDL rcognizer settings
    PPUsdlRecognizerSettings *usdlRecognizerSettings = [[PPUsdlRecognizerSettings alloc] init];
    
    // Add USDL Recognizer setting to a list of used recognizer settings
    [settings.scanSettings addRecognizerSettings:usdlRecognizerSettings];
    
    /** 4. Initialize the Scanning Coordinator object */
    
    PPCoordinator *coordinator = [[PPCoordinator alloc] initWithSettings:settings];
    
    return coordinator;
}

- (void)showCoordinatorError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                             message:[error localizedDescription]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showCamera {
    
    /** Instantiate the scanning coordinator */
    NSError *error;
    PPCoordinator *coordinator = [self coordinatorWithError:&error];
    
    /** If scanning isn't supported, show an error */
    if (coordinator == nil) {
        [self showCoordinatorError:error];
        return;
    }
    
    //ViewToShowInit
    
    ViewToShow *viewTS = [[ViewToShow alloc] init];
    
    
    /** Allocate and present the scanning view controller */
    UIViewController<PPScanningViewController>* scanningViewController = [coordinator cameraViewControllerWithDelegate:self overlayViewController:viewTS];
    
    /** You can use other presentation methods as well */
    [self presentViewController:scanningViewController animated:YES completion:nil];
}

@end
