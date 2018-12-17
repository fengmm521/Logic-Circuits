//
//  NSPageViewManager.h
//  NSPdfViewer
//
//  Created by liuqw on 11-10-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSScrollView.h"
//#import "NSPdfPageView.h"
#import "PDFScrollView.h"
#import "TiledPDFView.h"

@interface NSPageViewManager : NSObject {
    NSString*               filePath_;
    CGPDFDocumentRef        documentRef_;
    UIInterfaceOrientation  orientation;
    CGFloat pdfScale;
}
@property UIInterfaceOrientation  orientation;

// load document info.
- (id) initWithFilePath:(NSString*)filepath;
- (BOOL) loadDocumentWithFilePath:(NSString*)filepath;
- (int) getDocumentPageCount;

// init pageview info.
- (PDFScrollView*) createNewPageViewWithPageIndex:(int)index;
- (CGRect) getScreenRect;

// for zoom in out ..
- (void) zoomInPageView:(UIScrollView*)pageView withTouchPoint:(CGPoint)point;
- (void) zoomOutPageView:(UIScrollView*)pageView withTouchPoint:(CGPoint)point;

@end
