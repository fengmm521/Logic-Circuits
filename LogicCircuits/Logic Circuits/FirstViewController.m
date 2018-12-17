//
//  FirstViewController.m
//  Logic Circuits
//
//  Created by woodcol on 12-11-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = NSLocalizedString(@"54/74 TTL", @"54/74 TTL"); 
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        //allFile = [AllViewFile sharedAllFile];
    }
    return self;
}
							



- (void)didReceiveMemoryWarning
{
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
    
   // if ([AllViewFile sharedAllFile].selectListName == @"54/74 TTL Logic IC") {
        
        
        
        cellsections = 6;
        
        selectIC = E_5474;
   /*     
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
    
    
    */
    
    [self loadfileNameInBundle];
    
    
    
    
    UIBarButtonItem *selectbutton = [[UIBarButtonItem alloc]initWithTitle:@"search" style:UIBarButtonItemStylePlain target:self action:@selector(searchPdfDocument)];
    
    self.navigationItem.rightBarButtonItem = selectbutton ;    
    
    
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
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

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
   // return 0;
    
    return [super numberOfSectionsInTableView:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [super tableView:tableView numberOfRowsInSection:section];
    
    //return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
     */
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
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    orientation = interfaceOrientation;
    
    allFile.mainFramrect = [self getScreenRect];
    
    
    
    
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
     

   
}

@end
