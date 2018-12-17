
#import "NSDirectoryViewController.h"
#import "NSDocumentViewController.h"
#import "PDFDocumentShowViewController.h"

@implementation NSDirectoryViewController


#pragma mark -
#pragma mark View lifecycle


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    
    
    return self;
}



-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        //self.tableView.frame = [UIScreen mainScreen].bounds;
        //[self loadFileNameInDocumentDirectory];
    }
    
    return self;

    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.frame = 
    self.hidesBottomBarWhenPushed = NO;
    //[self.tabBarController.tabBar setHidden:NO];
    //[self.navigationController setToolbarHidden:YES animated:YES];
    // 1. init toolbar style.
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
   // self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

	//self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
   // [self.navigationController.toolbar removeFromSuperview];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    self.navigationController.toolbar.translucent = NO;
    allFile = [AllViewFile sharedAllFile];
    
    self.tableView.frame =[self getScreenRect]; //[UIScreen mainScreen].bounds;
   
    
	// 2. init title.
    if (allFile.selectListName == @"54/74 TTL Logic IC") {
        self.title = NSLocalizedString(@"54/74 TTL", @"54/74 TTL"); 
    }else if(allFile.selectListName == @"40XX CMOS Logic IC"){
        
        self.title = NSLocalizedString(@"40XX CMOS", @"40XX CMOS"); 
        
        
    }else if(allFile.selectListName == @"45XX CMOS Logic IC"){
        
        self.title = NSLocalizedString(@"45XX CMOS", @"45XX CMOS"); 
        
    }else{
        
        self.title = NSLocalizedString(@"Document", @"document"); 
        
    }
      
    self.navigationController.navigationBar.translucent = NO;
    
	//self.title = @"Documents";
	
	// 3. init file name and path array.
	fileNames_ = [[NSMutableArray alloc]init];
	filePaths_ = [[NSMutableArray alloc]init];
	
    
    
    // 4. load file info.
	[self loadFileNameInDocumentDirectory];
    
   // noUnload = YES;
    
    UIBarButtonItem *selectbutton = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(searchPdfDocument)];
    
    self.navigationItem.rightBarButtonItem = selectbutton ;
    
}
-(void)searchPdfDocument
{
    
    
    //NSLog(@"main scence w,h is %f,%f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    
    //[UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:kDuration];
    
    //向下反转
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    //向上反转
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    
   // [self.view addSubview:self.tabBarController.view];
    
    //从左向右
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.tableView cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
    
    
    //从右向左
    // [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    
    
    
    //   NSUInteger green = [[self.view subviews] indexOfObject:[[NSDirectoryViewController alloc]initWithNibName:nil bundle:nil].view];
    //   NSUInteger blue = [[self.view subviews] indexOfObject:self.view];
    
    // [self.view exchangeSubviewAtIndex:blue withSubviewAtIndex:green];
    
    //  NSUInteger green = [self indexOfAccessibilityElement:[[NSDirectoryViewController alloc]initWithNibName:nil bundle:nil]];
    
    
    NSUInteger blue = [[self.view subviews] indexOfObject:self.view];
    
    // NSUInteger blue = [self indexOfAccessibilityElement:self];
    if (pdfdocumentController == nil) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
            pdfdocumentController = [[PDFDocumentShowViewController alloc]initWithNibName:@"PDFDocumentShowViewController_iPhone" bundle:nil];
            
           // pdfdocumentController = [[PDFDocumentShowViewController alloc]initWithStyle:UITableViewStyleGrouped];            
        }else{
            
            pdfdocumentController = [[PDFDocumentShowViewController alloc]initWithNibName:@"PDFDocumentShowViewController_iPad" bundle:nil];
            
        }
        
    }
    
   // [self.view removeFromSuperview];
    //  NSDirectoryViewController *nsdircontroller = [[NSDirectoryViewController alloc]initWithNibName:nil bundle:nil];
    
    
    // [self.navigationController setNavigationBarHidden:YES animated:YES];
    //[self.navigationController setToolbarHidden:YES animated:YES];
    //self.navigationItem.hidesBackButton = YES;
    pdfdocumentController.tableView.frame = allFile.mainFramrect;
    [pdfdocumentController.navigationItem setHidesBackButton:NO];
    
    [self.view insertSubview:pdfdocumentController.tableView atIndex:blue];
    
    
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];

    
    
    
    NSLog(@"search button is chect!");
    
    
}


/*
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

   // self.navigationController.toolbarHidden = YES;
    
}
 */
-(void)animationFinished
{
    
   [self.view removeFromSuperview];
    
    //NSLog(@"2pdf and nschange size is (%f,%f),(%f,%f)",pdfdocumentController.tableView.bounds.size.width,pdfdocumentController.tableView.bounds.size.height,self.tableView.bounds.size.width,self.tableView.bounds.size.height);
    
   // pdfdocumentController.view.frame = self.view.bounds;
    
    // NSLog(@"pdf and nschange size is (%f,%f),(%f,%f)",pdfdocumentController.tableView.bounds.size.width,pdfdocumentController.tableView.bounds.size.height,self.tableView.bounds.size.width,self.tableView.bounds.size.height);
   
    
     self.navigationController.hidesBottomBarWhenPushed = NO;    
   // [self.navigationController popToRootViewControllerAnimated:NO];
    [self.navigationController popViewControllerAnimated:NO];
   // [self.navigationController popToViewController:pdfdocumentController animated:NO];
    
     [pdfdocumentController.tableView removeFromSuperview];
}
                                   
                                         
                                         
                                         
                                         
                               

- (void) loadFileNameInDocumentDirectory
{
    
    //@"54/74 TTL Logic IC",@"40XX CMOS Logic IC",@"45XX CMOS Logic IC",@"8051 core CISC",@"AVR core RISC",@"PIC MCU or SOC",@"ARM core RISC",@"Other core Chip"

    if (allFile.selectListName == @"54/74 TTL Logic IC") {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"List5474.plist" ofType:nil];
        
        fileNames_ = [[NSMutableArray alloc]initWithContentsOfFile:path];
        filePaths_ = [[NSMutableArray alloc]initWithObjects:path, nil];
        [filePaths_ removeAllObjects];
        
        for (NSString *tmp in fileNames_) {
            NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
            if (filePath !=nil) {
                [filePaths_ addObject:filePath];
            }else{
                
                NSLog(@"-------NULL file filename is %@---------",tmp);
                
            }
           //  NSLog(@"5474 filename is %@:%@),",tmp,filePath);
           
        }
        
        
        
    }else if(allFile.selectListName == @"40XX CMOS Logic IC"){
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"List40XX.plist" ofType:nil];
        
        fileNames_ = [[NSMutableArray alloc]initWithContentsOfFile:path];
        filePaths_ = [[NSMutableArray alloc]initWithObjects:path, nil];
        [filePaths_ removeAllObjects];
        
        for (NSString *tmp in fileNames_) {
            NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
            if (filePath !=nil) {
                [filePaths_ addObject:filePath];
            }else{
                NSLog(@"-------NULL file filename is %@---------",tmp);
                
                
            }
           //  NSLog(@"40xx filename is %@:%@),",tmp,filePath);
           
            
        }
  
        
    }else if(allFile.selectListName == @"45XX CMOS Logic IC"){
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"List45XX.plist" ofType:nil];
        
        fileNames_ = [[NSMutableArray alloc]initWithContentsOfFile:path];
        filePaths_ = [[NSMutableArray alloc]initWithObjects:path, nil];
        [filePaths_ removeAllObjects];
        
        for (NSString *tmp in fileNames_) {
            NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
            if (filePath !=nil) {
                [filePaths_ addObject:filePath];
            }else{
                 NSLog(@"-------NULL file filename is %@---------",tmp);
                
                
            }
           //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
           
            
        }
        
        
        
        
        
    }else{
        NSString *path = [[NSBundle mainBundle]pathForResource:@"List45XX.plist" ofType:nil];
        
        fileNames_ = [[NSMutableArray alloc]initWithContentsOfFile:path];
        filePaths_ = [[NSMutableArray alloc]initWithObjects:path, nil];
        [filePaths_ removeAllObjects];
        
        for (NSString *tmp in fileNames_) {
            NSString *filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.pdf",tmp] ofType:nil];
            if (filePath !=nil) {
                [filePaths_ addObject:filePath];
                
            }else{
                
                 NSLog(@"-------NULL file filename is %@---------",tmp);
  
            }
           //  NSLog(@"45xx filename is %@:%@),",tmp,filePath);
            
          
            
            
        }
        
        
        
    }
    

    
    NSLog(@"filename count is %i,filepaths count is %i",[fileNames_ count],[filePaths_ count]);
    
    /*
	NSArray* paths_ = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														  NSUserDomainMask,
														  YES);
	NSString* dir_ = [paths_ objectAtIndex:0];
	NSFileManager* fileMgr_ = [NSFileManager defaultManager];
	NSArray* files_ = [fileMgr_ contentsOfDirectoryAtPath:dir_ error:nil];
	
	for (NSString* item in files_) 
    {
        if ([[item pathExtension] caseInsensitiveCompare:@"pdf"] == NSOrderedSame)
        { 
            // 1. add file name.
            [fileNames_ addObject:item];
            
            // 2. add file path.
            NSString* filePath_ = [dir_ stringByAppendingPathComponent:item];
            [filePaths_ addObject:filePath_];
        }
	}
     */
    
}


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
   // if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
      //  if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height) {
            
       
    orientation = interfaceOrientation;      
     
     allFile.mainFramrect = [self getScreenRect];
            
    //NSLog(@"raton.");
    
   // }else{
        
        
   // }
        
   // }else{
        
        
  //  }
    
	return YES;
}

#pragma mark -
#pragma mark Table view data source
// Override to support conditional editing of the table view.
/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		NSLog(@"delete a contact");
		//[self deleteContactFromAddressBookWithIndex:indexPath.row];
		//[self initContactInfo];
        NSString *filePathdel = [filePaths_ objectAtIndex:indexPath.row];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        [fileMgr removeItemAtPath:filePathdel error:nil];
        [fileNames_ removeObjectAtIndex:indexPath.row];
		[self.tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [fileNames_ count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //self.navigationController.navigationBar.translucent = NO;    
    
    
    
  static   NSString *CellIdentifier1 = @"cells" ;
    
   // CellIdentifier1 = [NSString stringWithFormat:@"cellns%d%d",indexPath.section,indexPath.row];
   
    
    TDBadgedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    
    if (cell == nil) {
        cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1];

    }
    

    
   // TDBadgedCell *cell = [[TDBadgedCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1];
    
    int index = [indexPath row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;    
    
       
    
    NSString *string  = [fileNames_ objectAtIndex:index];
        
    cell.textLabel.text = string;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.detailTextLabel.text = [allFile.ICNameDictionary objectForKey:string];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
       //  NSLog(@"indexpath section is %i,allfile name is %@",indexPath.section,[allFile.ICNameDictionary objectForKey:string]);
        
    
    
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
        
    //}

    // init cell.

}

-(void)viewWillDisappear:(BOOL)animated
{
    
    
    
    
    [super viewWillDisappear:animated];
        
    
}

-(void)viewDidDisappear:(BOOL)animated
{
   // [self.tableView removeFromSuperview];
    
    [super viewDidDisappear:animated];
}

/*
-(void)viewWillDisappear:(BOOL)animated{

    
    
    [super viewWillDisappear:animated];
    
}
*/
#pragma mark -
#pragma mark Table view delegate
// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [fileNames_ removeObjectAtIndex:[indexPath row]];
//        [tableView reloadData];
//    }  
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
	NSString* fileName = [fileNames_ objectAtIndex:[indexPath row]];
    NSString* filePath = [filePaths_ objectAtIndex:[indexPath row]];
	NSDocumentViewController* controller = [[NSDocumentViewController alloc]initWithFileName:fileName 
                                                                                withFilePath:filePath];
    
     controller.hidesBottomBarWhenPushed = YES;   
    
	[self.navigationController pushViewController:controller animated:YES];
	//[controller release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

     [self.tableView removeFromSuperview];
    
    [super viewDidUnload];

    
}


- (void)dealloc {
    //[fileNames_ release];
	//[filePaths_ release];
    
    //[super dealloc];
}


@end

