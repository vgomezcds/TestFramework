//
//  PPPdf417RecognizerSettings.h
//  Pdf417Framework
//
//  Created by Jura on 10/07/15.
//  Copyright (c) 2015 MicroBlink Ltd. All rights reserved.
//

#import "PPRecognizerSettings.h"

/**
 * Settings class for configuring PDF417 Barcode recognizer
 */
@interface PPPdf417RecognizerSettings : PPRecognizerSettings

/**
 * Set this to YES to scan even barcode not compliant with standards
 * For example, malformed PDF417 barcodes which were incorrectly encoded
 *
 * Use only if necessary because it slows down the recognition process
 */
@property (nonatomic) BOOL scanUncertain;

/**
 * Set this to YES to scan barcodes which don't have quiet zone (white area) around it
 *
 * Use only if necessary because it slows down the recognition process
 */
@property (nonatomic) BOOL allowNullQuietZone;

/**
 * Set this to YES to allow scanning barcodes with inverted intensities 
 * (i.e. white barcodes on black background)
 * 
 * NOTE: this options doubles the frame processing time
 */
@property (nonatomic) BOOL scanInverse;

@end
