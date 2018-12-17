//
//  PDFDocumentShowViewController.h
//  Digital Circuits
//
//  Created by woodcol on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllViewFile.h"
#import "TDBadgedCell.h"
#import "NSDirectoryViewController.h"

#define kDuration 0.7   // 动画持续时间(秒)


//@class NSDirectoryViewController;

@interface PDFDocumentShowViewController : UITableViewController{

//logic IC
    NSMutableArray *logicICList;
    NSMutableArray *logicICpath;
//Trigger IC
    NSMutableArray *triggerICList;
    NSMutableArray *triggerICpath;
//register
    NSMutableArray *registerICList;
    NSMutableArray *registerICpath;
//Interface IC
    NSMutableArray *interfaceICList;
    NSMutableArray *interfaceICpath;
//Codec IC
    NSMutableArray *codecICList;
    NSMutableArray *codecICpath;
//counter
    NSMutableArray *counterICList;
    NSMutableArray *counterICpath;
    
    UIInterfaceOrientation orientation;
    
    
    AllViewFile *allFile;
    
    enum selecttype{
        
        E_5474,
        E_40xx,
        E_45xx,
        E_8051,
        E_avr,
        E_arm,
        E_pic,
        E_package,
        E_other      
        
    }selectIC;
    
    
    int cellsections;
    int cellRowsInSection;
    
    
    NSDirectoryViewController *changeToviewController;
    
    
}

-(void)loadfileNameInBundle;
-(void)searchPdfDocument;
-(void)animationFinished;
-(CGRect) getScreenRect;

@end
