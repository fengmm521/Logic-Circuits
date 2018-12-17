//
//  AllViewFile.h
//  Digital Circuits
//
//  Created by woodcol on 12-10-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PDFDocumentShowViewController.h"

@interface AllViewFile : NSObject{
    
    NSString *imagefile_;
    NSMutableDictionary *pdfFileDictionary_;
    NSMutableDictionary *pdfFileImageDictionary_;
    NSMutableDictionary *packageImageFileDictionary_;
    NSMutableDictionary *ICNameDictionary_;
    NSMutableDictionary *ICtypeDictionary_;
    NSMutableArray *allList_;
    NSMutableArray *aloneList_;
    NSString *selectListName_;
    
    CGRect mainFramrect_;
    
}
@property (readwrite,nonatomic,retain)NSString *imagefile;
@property (readwrite,nonatomic)CGRect mainFramrect;
@property (readwrite,nonatomic,retain)NSMutableDictionary *pdfFileDictionary;
@property (readwrite,nonatomic,retain)NSMutableDictionary *pdfFileImageDictionary;
@property (readwrite,nonatomic,retain)NSMutableDictionary *packageImageFileDictionary;
@property (readwrite,nonatomic,retain)NSMutableDictionary *ICNameDictionary;
@property (readwrite,nonatomic,retain)NSMutableDictionary *ICtypeDictionary;
@property (readwrite,nonatomic,retain)NSMutableArray *allList;
@property (readwrite,nonatomic,retain)NSMutableArray *aloneList;
@property (readwrite,nonatomic,retain)NSString *selectListName;

+(AllViewFile*)sharedAllFile;


@end
