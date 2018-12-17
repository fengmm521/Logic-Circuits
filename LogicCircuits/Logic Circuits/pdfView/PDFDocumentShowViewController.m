//
//  PDFDocumentShowViewController.m
//  Digital Circuits
//
//  Created by woodcol on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PDFDocumentShowViewController.h"
#import "NSDocumentViewController.h"
//#import "NSDirectoryViewController.h"
//#import <QuartzCore/QuartzCore.h>

@implementation PDFDocumentShowViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
       // self.tableView.frame = [UIScreen mainScreen].bounds;
       // [self loadfileNameInBundle];
    }
    
    return self;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1. init toolbar style.
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
    // self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
	//self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    // [self.navigationController.toolbar removeFromSuperview];
    [self.navigationItem setHidesBackButton:NO animated:NO];
    self.navigationController.toolbar.translucent = NO;
    
    self.tableView.frame =[self getScreenRect];
    
    
    
    allFile = [AllViewFile sharedAllFile];
    
    
    logicICList = [[NSMutableArray alloc]init];
    logicICpath = [[NSMutableArray alloc]init];
    
    triggerICList = [[NSMutableArray alloc]init];
    triggerICpath = [[NSMutableArray alloc]init];
    
    registerICList = [[NSMutableArray alloc]init];
    registerICpath = [[NSMutableArray alloc]init];
    
    interfaceICList = [[NSMutableArray alloc]init];
    interfaceICpath = [[NSMutableArray alloc]init];
    
    codecICList = [[NSMutableArray alloc]init];
    codecICpath = [[NSMutableArray alloc]init];
    
    counterICList = [[NSMutableArray alloc]init];
    counterICpath = [[NSMutableArray alloc]init];
    
    
    //@"54/74 TTL Logic IC",@"40XX CMOS Logic IC",@"45XX CMOS Logic IC",@"8051 core CISC",@"AVR core RISC",@"PIC MCU or SOC",@"ARM core RISC",@"Other core Chip"
    
    if ([AllViewFile sharedAllFile].selectListName == @"54/74 TTL Logic IC") {
        
        self.title = NSLocalizedString(@"54/74 TTL", @"54/74 TTL"); 
        
        cellsections = 6;
        
        selectIC = E_5474;
        
    }else if([AllViewFile sharedAllFile].selectListName == @"40XX CMOS Logic IC"){
        
        self.title = NSLocalizedString(@"40XX CMOS", @"40XX CMOS"); 
        
        cellsections = 6;
        
        selectIC = E_40xx;
        
    }else if(allFile.selectListName == @"45XX CMOS Logic IC"){
        
        self.title = NSLocalizedString(@"45XX CMOS", @"45XX CMOS"); 
        
        cellsections = 6;
        
        selectIC = E_45xx;
        
    }else if(allFile.selectListName == @"8051 core CISC"){
        
        self.title = NSLocalizedString(@"8051 core", @"8051 core"); 
        
        cellsections = 1;
        
        selectIC = E_8051;
        
    }else if(allFile.selectListName == @"AVR core RISC"){
        
        self.title = NSLocalizedString(@"AVR core", @"AVR core");
        
        cellsections = 1;
        
        selectIC = E_avr;
        
    }else if(allFile.selectListName == @"PIC MCU or SOC"){
        
        self.title = NSLocalizedString(@"PIC", @"PIC");
        
        cellsections = 1;
        
        selectIC = E_pic;
        
    }else if(allFile.selectListName == @"ARM core RISC"){
        
        self.title = NSLocalizedString(@"ARM", @"ARM");
        
        cellsections = 1;
        
        selectIC = E_arm;
        
    }else if(allFile.selectListName == @"Other core Chip"){
        
        self.title = NSLocalizedString(@"Other Chip", @"Other Chip");
        
        cellsections =1;
        
        selectIC = E_other;
        
    }
    
    
    
    
    [self loadfileNameInBundle];
    
    
    
    
    UIBarButtonItem *selectbutton = [[UIBarButtonItem alloc]initWithTitle:@"search" style:UIBarButtonItemStylePlain target:self action:@selector(searchPdfDocument)];
    
    self.navigationItem.rightBarButtonItem = selectbutton ;    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)searchPdfDocument
{
    
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //[UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:kDuration];
    
    //向下反转
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    //向上反转
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];

    //从左向右
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.tableView cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.tabBarController.view cache:YES];
    //从右向左
   // [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    
    self.navigationItem.hidesBackButton = YES;
    
 //   NSUInteger green = [[self.view subviews] indexOfObject:[[NSDirectoryViewController alloc]initWithNibName:nil bundle:nil].view];
 //   NSUInteger blue = [[self.view subviews] indexOfObject:self.view];
    
    // [self.view exchangeSubviewAtIndex:blue withSubviewAtIndex:green];
    
  //  NSUInteger green = [self indexOfAccessibilityElement:[[NSDirectoryViewController alloc]initWithNibName:nil bundle:nil]];
    
    
  NSUInteger blue = [[self.view subviews] indexOfObject:self.view];
    
   // NSUInteger blue = [self indexOfAccessibilityElement:self];
    
    if (changeToviewController == nil) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            changeToviewController = [[NSDirectoryViewController alloc]initWithNibName:@"NSDirectoryViewController_iPhone" bundle:nil];
           
            // changeToviewController = [[NSDirectoryViewController alloc]initWithStyle:UITableViewStylePlain];
            
        
        }else{
            
            changeToviewController = [[NSDirectoryViewController alloc]initWithNibName:@"NSDirectoryViewController_iPad" bundle:nil];
            
        }
        
    }
    
    
    
    
   // changeToviewController = [[NSDirectoryViewController alloc]initWithNibName:nil bundle:nil];
    
  //  NSDirectoryViewController *nsdircontroller = [[NSDirectoryViewController alloc]initWithNibName:nil bundle:nil];
    
        
    
   
   // [self.navigationController setNavigationBarHidden:YES animated:YES];
    //[self.navigationController setToolbarHidden:YES animated:YES];
    //self.navigationItem.hidesBackButton = YES;
    changeToviewController.tableView.frame = allFile.mainFramrect;
    
   // UIView *firstView = changeToviewController.tableView;
    
    
    //[self.tabBarController.view insertSubview:nil atIndex:0];
    
    [self.view insertSubview:changeToviewController.tableView atIndex:blue];

   // [self.view removeFromSuperview];
    
    
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}



-(void)animationFinished
{
    
     //[self.view removeFromSuperview];
    
    // NSLog(@"1nschange and pdf size is (%f,%f),(%f,%f)",changeToviewController.tableView.bounds.size.width,changeToviewController.tableView.bounds.size.height,self.tableView.bounds.size.width,self.tableView.bounds.size.height);
    
   // NSLog(@"animationfinished is run.");
    changeToviewController.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:changeToviewController animated:NO];
    
    [changeToviewController.tableView removeFromSuperview];
    
    
}

-(void)loadfileNameInBundle
{
    switch (selectIC) {
        case E_5474:
        {
           
            
            //logic IC load
            NSString *path = [[NSBundle mainBundle]pathForResource:@"Listlogic5474.plist" ofType:nil];
           
            
            if ([logicICList count]!=0) {
                 [logicICpath removeAllObjects];
            }
           
            logicICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            
            logicICpath = [[NSMutableArray alloc]initWithObjects:path, nil];
            [logicICpath removeAllObjects];
            
            for (NSString *tmp in logicICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [logicICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                  
            }
           
            
            //trigger IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listtrigger5474.plist" ofType:nil];
            
            if ([triggerICList count]!=0) {
                [triggerICList removeAllObjects];
            }
            triggerICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            triggerICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [triggerICpath removeAllObjects];
            
            for (NSString *tmp in triggerICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [triggerICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //register IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listregister5474.plist" ofType:nil];
            
            if ([registerICList count]!=0) {
                [registerICList removeAllObjects];
            }
            registerICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            registerICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [registerICpath removeAllObjects];
            
            for (NSString *tmp in registerICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [registerICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //interface IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listinterface5474.plist" ofType:nil];
            
            if ([interfaceICList count]!=0) {
                [interfaceICList removeAllObjects];
            }
            interfaceICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            interfaceICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [interfaceICpath removeAllObjects];
            
            for (NSString *tmp in interfaceICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [interfaceICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //codec IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listcoder5474.plist" ofType:nil];
            
            if ([codecICList count]!=0) {
                [codecICList removeAllObjects];
            }
            codecICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            codecICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [codecICpath removeAllObjects];
            
            for (NSString *tmp in codecICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [codecICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //counter IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listcounter5474.plist" ofType:nil];
            
            if ([counterICList count]!=0) {
                [counterICList removeAllObjects];
            }
            counterICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            counterICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [counterICpath removeAllObjects];
            
            for (NSString *tmp in counterICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [counterICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            
            break;
        }
        case E_40xx:
        {
            
            
            //logic IC load
            NSString *path = [[NSBundle mainBundle]pathForResource:@"Listlogic40xx.plist" ofType:nil];
            
            
            if ([logicICList count]!=0) {
                [logicICpath removeAllObjects];
            }
            
            logicICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            
            logicICpath = [[NSMutableArray alloc]initWithObjects:path, nil];
            [logicICpath removeAllObjects];
            
            for (NSString *tmp in logicICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [logicICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            
            //trigger IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listtrigger40xx.plist" ofType:nil];
            
            if ([triggerICList count]!=0) {
                [triggerICList removeAllObjects];
            }
            triggerICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            triggerICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [triggerICpath removeAllObjects];
            
            for (NSString *tmp in triggerICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [triggerICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //register IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listregister40xx.plist" ofType:nil];
            
            if ([registerICList count]!=0) {
                [registerICList removeAllObjects];
            }
            registerICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            registerICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [registerICpath removeAllObjects];
            
            for (NSString *tmp in registerICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [registerICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //interface IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listinterface40xx.plist" ofType:nil];
            
            if ([interfaceICList count]!=0) {
                [interfaceICList removeAllObjects];
            }
            interfaceICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            interfaceICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [interfaceICpath removeAllObjects];
            
            for (NSString *tmp in interfaceICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [interfaceICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //codec IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listcoder40xx.plist" ofType:nil];
            
            if ([codecICList count]!=0) {
                [codecICList removeAllObjects];
            }
            codecICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            codecICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [codecICpath removeAllObjects];
            
            for (NSString *tmp in codecICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [codecICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //counter IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listcounter40xx.plist" ofType:nil];
            
            if ([counterICList count]!=0) {
                [counterICList removeAllObjects];
            }
            counterICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            counterICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [counterICpath removeAllObjects];
            
            for (NSString *tmp in counterICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [counterICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }

            
            
            
            break;
        }
        case E_45xx:
        {
            
            
            
            
            //logic IC load
            NSString *path = [[NSBundle mainBundle]pathForResource:@"Listlogic45xx.plist" ofType:nil];
            
            
            if ([logicICList count]!=0) {
                [logicICpath removeAllObjects];
            }
            
            logicICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            
            logicICpath = [[NSMutableArray alloc]initWithObjects:path, nil];
            [logicICpath removeAllObjects];
            
            for (NSString *tmp in logicICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [logicICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            
            //trigger IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listtrigger45xx.plist" ofType:nil];
            
            if ([triggerICList count]!=0) {
                [triggerICList removeAllObjects];
            }
            triggerICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            triggerICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [triggerICpath removeAllObjects];
            
            for (NSString *tmp in triggerICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [triggerICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //register IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listregister45xx.plist" ofType:nil];
            
            if ([registerICList count]!=0) {
                [registerICList removeAllObjects];
            }
            registerICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            registerICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [registerICpath removeAllObjects];
            
            for (NSString *tmp in registerICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [registerICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //interface IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listinterface45xx.plist" ofType:nil];
            
            if ([interfaceICList count]!=0) {
                [interfaceICList removeAllObjects];
            }
            interfaceICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            interfaceICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [interfaceICpath removeAllObjects];
            
            for (NSString *tmp in interfaceICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [interfaceICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //codec IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listcoder45xx.plist" ofType:nil];
            
            if ([codecICList count]!=0) {
                [codecICList removeAllObjects];
            }
            codecICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            codecICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [codecICpath removeAllObjects];
            
            for (NSString *tmp in codecICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [codecICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            //counter IC load
            path = [[NSBundle mainBundle]pathForResource:@"Listcounter45xx.plist" ofType:nil];
            
            if ([counterICList count]!=0) {
                [counterICList removeAllObjects];
            }
            counterICList = [[NSMutableArray alloc]initWithContentsOfFile:path];
            counterICpath =[[NSMutableArray alloc]initWithObjects:path, nil];
            [counterICpath removeAllObjects];
            
            for (NSString *tmp in counterICList) {
                NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
                if (filePath !=nil) {
                    [counterICpath addObject:filePath];
                    
                }else{
                    
                    NSLog(@"-------NULL file filename is %@---------",tmp);
                    
                }
                //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
                
            }
            
            

            
            
            break;
        }
        case E_8051:
        {
            
            break;
        }
        case E_avr:
        {
            
            break;
        }
        case E_pic:
        {
            
            break;
        }
        case E_arm:
        {
            
            break;
        }
        case E_package:
        {
            
            
            break;
        }
        case E_other:
        {
            
            break;
        }
            
        default:
            break;
    }

    
    
    
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return @"Logic";
            break;
        case 1:
            return @"Trigger";
            break;
        case 2:
            return @"Register";
            break;
        case 3:
            return @"Interface";
            break;
        case 4:
            return @"CODEC";
            break;
        case 5:
            return @"Counter";
            break;
        default:
            return @"";
            break;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
    
}


- (void)viewDidUnload
{
    
    [self.tableView removeFromSuperview];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:NO animated:YES];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    
    
    [super viewDidAppear:animated];
}




- (void)viewWillDisappear:(BOOL)animated
{
   
    
    [super viewWillDisappear:animated];
    
    
}


- (CGRect) getScreenRect
{
    long pageWidth = 0;
    long pageHeight = 0;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (UIInterfaceOrientationIsPortrait(orientation) == YES)
	{
        pageWidth = screenRect.size.width;
        pageHeight = screenRect.size.height;
	} else {
        pageWidth = screenRect.size.height;
        pageHeight = screenRect.size.width;
	}
    
    screenRect = CGRectMake(0, 0, pageWidth, pageHeight);    
    
    return screenRect;
}



- (void)viewDidDisappear:(BOOL)animated
{
 
 
        
     
        

    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    orientation = interfaceOrientation;
    
    allFile.mainFramrect = [self getScreenRect];
    
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return cellsections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    switch (section) {
        case 0:
            return [logicICList count];
            break;
        case 1:
            return [triggerICList count];
            break;
        case 2:
            return [registerICList count];
            break;
        case 3:
            return [interfaceICList count];
            break;
        case 4:
            return [codecICList count];
            break;
        case 5:
            return [counterICList count];
            break;
        default:
            break;
    }
        
   
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    static  NSString *CellIdentifier = @"celld";
    
    
    
           // CellIdentifier =[NSString stringWithFormat:@"cellpdf%d%d",indexPath.section,indexPath.row]; // @"cellpdf0";

    
    
    
    
    
    TDBadgedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    
    int index = [indexPath row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *string;
    
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
        {
            string = [logicICList objectAtIndex:index];
            cell.textLabel.text = string;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.detailTextLabel.text = [allFile.ICNameDictionary objectForKey:string];
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
           
            
            
            
            

            
            
            break;
        }
        case 1:
        {
            string = [triggerICList objectAtIndex:index];
            cell.textLabel.text = string;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.detailTextLabel.text = [allFile.ICNameDictionary objectForKey:string];
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
           
            
            
            break;
        }
        case 2:
        {
            string = [registerICList objectAtIndex:index];
            cell.textLabel.text = string;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.detailTextLabel.text = [allFile.ICNameDictionary objectForKey:string];
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            
           
            
            break;
        }
        case 3:
        {
            string = [interfaceICList objectAtIndex:index];
            cell.textLabel.text = string;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.detailTextLabel.text = [allFile.ICNameDictionary objectForKey:string];
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        }
        case 4:
        {
            string = [codecICList objectAtIndex:index];
            cell.textLabel.text = string;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.detailTextLabel.text = [allFile.ICNameDictionary objectForKey:string];
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        }
        case 5:
        {
            string = [counterICList objectAtIndex:index];
            cell.textLabel.text = string;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.detailTextLabel.text = [allFile.ICNameDictionary objectForKey:string];
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        }
        default:
            break;
    }  
    
   // NSLog(@"indexpath section is %i",indexPath.section);
    
    
    NSString *typestring = [allFile.ICtypeDictionary objectForKey:string];
    if (![typestring isEqualToString:@"oo"]) {
        
        cell.badgeString = typestring;
        
        
        cell.badgeColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        cell.badge.radius = 4;
        
        if ([typestring isEqualToString:@"counter"])
        {
            cell.badgeColor = [UIColor colorWithRed:0.792 green:0.597 blue:0.219 alpha:1.000];
            
             cell.badge.radius = 9;
            
        }
        
        if ([typestring isEqualToString:@"schmitt"])
        {
            cell.badgeColor = [UIColor colorWithRed:0.792 green:0.597 blue:0.219 alpha:1.000];
            cell.badge.radius = 4;
        }
        
        if ([typestring isEqualToString:@"shift register"])
        {
            cell.badgeColor = [UIColor colorWithRed:0.197 green:0.592 blue:0.219 alpha:1.000];
            cell.badge.radius = 9;
        }
        if ([typestring isEqualToString:@"data selector"]) {
            cell.badgeColor = [UIColor colorWithRed:0.5 green:0.592 blue:0.219 alpha:1.000];
            cell.badge.radius = 4;
        }
        
        if ([typestring isEqualToString:@"flip-flop"]) {
            cell.badgeColor = [UIColor colorWithRed:0.1 green:0.392 blue:0.719 alpha:1.000];
            cell.badge.radius = 4;
        }
        
        
        
        
        
        NSRange range;
        range = [typestring rangeOfString:@"OC"];
        
        
        if (range.location != NSNotFound){//[typestring rangeOfString:@"OC"]) {
            cell.badgeColor = [UIColor colorWithRed:0.3 green:0.197 blue:0.219 alpha:1.000];
        }
        
       
        range = [typestring rangeOfString:@"3-state"];
        if (range.location != NSNotFound){//[typestring isEqualToString:@"3-state"]) {
            cell.badgeColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.519 alpha:1.000];
        }

        range = [typestring rangeOfString:@"7-segment"];
        
        if (range.location !=NSNotFound) {
            cell.badgeColor = [UIColor colorWithRed:0.7 green:0.292 blue:0.119 alpha:1.000];
            cell.badge.radius = 4;
        }
        
        
    }else{
        
        cell.badgeString = nil;
        cell.badge.radius = 4;
    }
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    NSString *fileName;
    NSString *filePath;
    int index = [indexPath row];
    switch (indexPath.section) {
        case 0:
        {
            
            fileName = [logicICList objectAtIndex:index];
            filePath = [logicICpath objectAtIndex:index];
            break;
        }
        case 1:
        {
            fileName = [triggerICList objectAtIndex:index];
            filePath = [triggerICpath objectAtIndex:index];
            break;
        }
        case 2:
        {
            fileName = [registerICList objectAtIndex:index];
            filePath = [registerICpath objectAtIndex:index];
            break;
        }
        case 3:
        {
            
            fileName = [interfaceICList objectAtIndex:index];
            filePath = [interfaceICpath objectAtIndex:index];
            break;
        }
        case 4:
        {
            fileName = [codecICList objectAtIndex:index];
            filePath = [codecICpath objectAtIndex:index];
            break;
        }
        case 5:
        {
            fileName = [counterICList objectAtIndex:index];
            filePath = [counterICpath objectAtIndex:index];
            break;
        }
        default:
            break;
    }
    
    
    
    
    
	NSDocumentViewController* controller = [[NSDocumentViewController alloc]initWithFileName:fileName 
                                                                                withFilePath:filePath];
    //[controller setOverrideTraitCollection:[this ]
    
    controller.hidesBottomBarWhenPushed = YES;   
    
	[self.navigationController pushViewController:controller animated:YES];
    
}

@end
