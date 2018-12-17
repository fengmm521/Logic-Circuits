//
//  AllViewFile.m
//  Digital Circuits
//
//  Created by woodcol on 12-10-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllViewFile.h"

@implementation AllViewFile
static AllViewFile *_sharedAllFile = nil;

@synthesize imagefile = imagefile_;
@synthesize pdfFileDictionary = pdfFileDictionary_;
@synthesize pdfFileImageDictionary = pdfFileImageDictionary_;
@synthesize packageImageFileDictionary = packageImageFileDictionary_;
@synthesize allList = allList_;
@synthesize aloneList = aloneList_;
@synthesize selectListName = selectListName_;
@synthesize ICNameDictionary = ICNameDictionary_;
@synthesize mainFramrect = mainFramrect_;
@synthesize ICtypeDictionary = ICtypeDictionary_;

+(AllViewFile *)sharedAllFile;
{
    @synchronized(self){
        if (_sharedAllFile == nil) {
            
            _sharedAllFile = [[self alloc] init]; }
    }
    return _sharedAllFile;
    
}
- (id)init {
    self = [super init];
    if (self) {
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"List5474.plist" ofType:nil];
        
        //5474
        aloneList_ = [[NSMutableArray alloc]init];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        allList_ = [[NSMutableArray alloc]initWithContentsOfFile:path];
        
        //40xx
        path = [[NSBundle mainBundle] pathForResource:@"List40XX.plist" ofType:nil];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        [allList_ addObjectsFromArray:[[NSArray alloc]initWithContentsOfFile:path]];
        
        
        //45xx
        path = [[NSBundle mainBundle] pathForResource:@"List45XX.plist" ofType:nil];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        [allList_ addObjectsFromArray:[[NSArray alloc]initWithContentsOfFile:path]];
        
        //8051
        path = [[NSBundle mainBundle] pathForResource:@"List8051.plist" ofType:nil];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        [allList_ addObjectsFromArray:[[NSArray alloc]initWithContentsOfFile:path]];
        
        
        //avr
        path = [[NSBundle mainBundle] pathForResource:@"ListAVR.plist" ofType:nil];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        [allList_ addObjectsFromArray:[[NSArray alloc]initWithContentsOfFile:path]];
        
        //pic
        path = [[NSBundle mainBundle] pathForResource:@"ListPIC.plist" ofType:nil];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        [allList_ addObjectsFromArray:[[NSArray alloc]initWithContentsOfFile:path]];
        
        //arm 
        path = [[NSBundle mainBundle] pathForResource:@"ListARM.plist" ofType:nil];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        [allList_ addObjectsFromArray:[[NSArray alloc]initWithContentsOfFile:path]];
         
        //other
        path = [[NSBundle mainBundle] pathForResource:@"ListOther.plist" ofType:nil];
        [aloneList_ addObject:[[NSArray alloc]initWithContentsOfFile:path]];
        [allList_ addObjectsFromArray:[[NSArray alloc]initWithContentsOfFile:path]];
        
        
        NSLog(@"allList count is %i,alonelist count is %i",[allList_ count],[aloneList_ count]);
         
        pdfFileDictionary_ = [NSMutableDictionary dictionary];
        pdfFileImageDictionary_ = [NSMutableDictionary dictionary];
        
        
        for (NSString *tmp in allList_) {
            
            NSString *ICfileName = [NSString stringWithFormat:@"%@.pdf",tmp];
            
            [pdfFileDictionary_ setObject:ICfileName forKey:tmp];
            
            ICfileName = [NSString stringWithFormat:@"%@.png",tmp];
            
            [pdfFileImageDictionary_ setObject:ICfileName forKey:tmp];
            
        }
        
       // NSArray *pathD = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
       
        
       // NSString *document_ = [[pathD objectAtIndex:0] stringByAppendingPathComponent:@"pdffiledictionary.plist"];;
        
        // [pdfFileDictionary_ writeToFile:document_ atomically:YES];
        
        
         NSString *pathName = [[NSBundle mainBundle] pathForResource:@"pdffiledictionary.plist" ofType:nil];
        
        
        ICNameDictionary_ = [[NSMutableDictionary alloc] initWithContentsOfFile:pathName];
        
        NSString *nn = [[NSString alloc]initWithString:@"74ls00"];
        
        NSLog(@"%@ file is %@",nn,[ICNameDictionary_ objectForKey:nn]);
       
        path = [[NSBundle mainBundle] pathForResource:@"pdffileOC3state.plist" ofType:nil];
        ICtypeDictionary_ = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        
        
        
        
        
        
        path = [[NSBundle mainBundle] pathForResource:@"Listpackage.plist" ofType:nil];
        NSArray *packagelist = [[NSArray alloc]initWithContentsOfFile:path];
        
        packageImageFileDictionary_ = [NSMutableDictionary dictionary];
        
        for (NSString *tmpp in packagelist) {
            NSString *packagefilename = [NSString stringWithFormat:@"%@.png",tmpp];
            [packageImageFileDictionary_ setObject:packagefilename forKey:tmpp];
        }
        
    }
    return self;
}

- (void)dealloc {
    
    
    
  //  [super dealloc];
}

@end
