//
//  NSDocumentViewController.h
//  NSPdfViewer
//
//  Created by liuqw on 11-10-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "NSPageViewManager.h"
//#import "CALayer.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface NSDocumentViewController : UIViewController<UIScrollViewDelegate,UIPrintInteractionControllerDelegate,
MFMailComposeViewControllerDelegate> {
    NSString*               fileName_;
    NSString*               filePath_;
    NSPageViewManager*      manager_;
    
    UITapGestureRecognizer* doubleTapGestureRecognizer;
	UITapGestureRecognizer* twoFingerTapGestureRecognizer;
    
    UIScrollView*           backgroundView_;
    UILabel*                labelPageNum_;
    UISlider*               labelSlider_;
    
    int                     pageIndex;
    BOOL                    isCanRotation;
    BOOL                    isOutin;
    
    UIBarButtonItem* lockRotationItem;
    
   // BOOL unLoad_;
}
@property (readwrite,nonatomic)BOOL unLoad;

// for init..
- (id) initWithFileName:(NSString*)filename withFilePath:(NSString*)filepath;

// for move page..
- (void) insertPageViewToBackgroundViewWithPageIndex:(int)index;
- (PDFScrollView*) getPageViewWithPageIndex:(int)index;

// for touch..
- (void) actionOnDoubleTappedByOneFinger:(UIGestureRecognizer *)gestureRecognizer;
- (void) actionOnTappedByTwoFingers:(UIGestureRecognizer *)gestureRecognizer;

// for rotation.
- (void) removePageViewsFromBackgroundView;
- (void) updateBackgroundView;
- (void) updateLabelControlRectForRotation;

// for lock rotation..
- (void) actionOnTouchLockRotationButton;
// for page number ..
- (void) actionOnTouchPageNumButton;
// for move page with slider
- (void) actionOnSliderValueChanging;
- (void) actionOnSliderValueChanged;

- (NSURL *) getPrintURL;
@end
