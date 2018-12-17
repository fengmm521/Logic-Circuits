//
//  NSDirectoryViewController.h
//  NSPdfViewer
//
//  Created by liuqw on 11-10-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllViewFile.h"
#import "TDBadgedCell.h"
#import "NSDocumentViewController.h"
@class PDFDocumentShowViewController;

@interface NSDirectoryViewController : UITableViewController {
    NSMutableArray* fileNames_;
	NSMutableArray* filePaths_;
    AllViewFile *allFile;
    
    UIInterfaceOrientation orientation;
    
   PDFDocumentShowViewController *pdfdocumentController;
    
    //BOOL noUnload;
}

- (void) loadFileNameInDocumentDirectory;
-(void)searchPdfDocument;
-(void)animationFinished;
-(CGRect) getScreenRect;
@end
