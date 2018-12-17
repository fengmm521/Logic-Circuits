   
#import "NSDocumentViewController.h"


@implementation NSDocumentViewController
@synthesize unLoad = unLoad_;

- (id) initWithFileName:(NSString*)filename withFilePath:(NSString*)filepath
{
    if ((self = [super init])) {
       // fileName_ = [filename retain];
       // filePath_ = [filepath retain];
        
        fileName_ = filename;
        filePath_ = filepath;
        
       // manager_ = nil;
        
        // init page view manager.
        manager_ = [[NSPageViewManager alloc]initWithFilePath:filepath];
        
        isCanRotation = YES;
        isOutin = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
      //  unLoad_ = NO;
    }
    
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
      
    
    
   // [self.tabBarController.tabBar set:YES];    
    
    manager_.orientation = self.interfaceOrientation;
    
    // 1. init tool bar's style.
    self.wantsFullScreenLayout = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;	
	self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
    // 2. init title.
    self.title = fileName_;
    
    // 3. init background view
    CGRect bgRect = [manager_ getScreenRect];
    backgroundView_ = [[UIScrollView alloc]initWithFrame:bgRect];
    backgroundView_.backgroundColor = [UIColor grayColor];
    backgroundView_.pagingEnabled = YES;
    int pageCount = [manager_ getDocumentPageCount];
    CGSize contentSize = CGSizeMake(bgRect.size.width * pageCount, bgRect.size.height);
    backgroundView_.contentSize = contentSize;
    backgroundView_.delegate = self;
    
    
    // 4. init recognizers 
	doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] 
								  initWithTarget:self action:@selector(actionOnDoubleTappedByOneFinger:)];
	[doubleTapGestureRecognizer setDelaysTouchesBegan:YES];
	[doubleTapGestureRecognizer setNumberOfTapsRequired:2];
	[backgroundView_ addGestureRecognizer:doubleTapGestureRecognizer];
    
    twoFingerTapGestureRecognizer = [[UITapGestureRecognizer alloc] 
									 initWithTarget:self action:@selector(actionOnTappedByTwoFingers:)];
    [twoFingerTapGestureRecognizer setNumberOfTouchesRequired:2];
	[backgroundView_ addGestureRecognizer:twoFingerTapGestureRecognizer];
    
    // 5. init first pageview.
    [self insertPageViewToBackgroundViewWithPageIndex:0];
    
    [self.view addSubview:backgroundView_];
    // 6. init toolbar items
    /*
    UIBarButtonItem* lockRotationItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
																					target:self 
																					action:@selector(actionOnTouchLockRotationButton)] autorelease];
    
    
    UIBarButtonItem* filex = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                       target:nil 
                                                                                       action:nil ]autorelease];
    
    UIBarButtonItem* pageNumberItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera 
                                                                                      target:self 
                                                                                      action:@selector(actionOnTouchPageNumButton)] autorelease];
    
    UIBarButtonItem* sendMail = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize 
                                                                                     target:self 
                                                                                     action:@selector(actionSendMail)] autorelease];
    
    */
    
    lockRotationItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                                       target:self 
                                                                                       action:@selector(actionOnTouchLockRotationButton)];
    
    
    UIBarButtonItem* filex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                            target:nil 
                                                                            action:nil ];
    
    UIBarButtonItem* pageNumberItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera 
                                                                                     target:self 
                                                                                     action:@selector(actionOnTouchPageNumButton)];
    
    UIBarButtonItem* sendMail = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize 
                                                                               target:self 
                                                                               action:@selector(actionSendMail)];
    
    
    
    NSMutableArray *items_ = [[NSMutableArray alloc] init];
    [items_ addObject:filex];
    [items_ addObject:lockRotationItem];
    [items_ addObject:filex];
    [items_ addObject:pageNumberItem];
    [items_ addObject:filex];
    [items_ addObject:sendMail];
    [items_ addObject:filex];
    self.toolbarItems = items_;
   // [items_ release];
    
    
    
    
    // 7. init page number label
    float toolbarHeight = 44.0;
    if (UIInterfaceOrientationIsPortrait(manager_.orientation) == YES) {
        toolbarHeight = 44.0;
	} else {
        toolbarHeight = 32.0;
	}
    
    CGRect labelRect = CGRectMake(10, toolbarHeight + 25, 50, 30);
    labelPageNum_ = [[UILabel alloc]initWithFrame:labelRect];
    labelPageNum_.textAlignment = UITextAlignmentCenter;
    labelPageNum_.adjustsFontSizeToFitWidth = YES;
    labelPageNum_.backgroundColor = [UIColor clearColor];
    
    int pageNum = pageIndex + 1;
    labelPageNum_.text = [NSString stringWithFormat:@"%d/%d", pageNum, pageCount];
	[self.view addSubview:labelPageNum_];
    
    // 8. init page slider bar.
    CGRect sliderRect = CGRectMake(10, bgRect.size.height - toolbarHeight - 25, 
                                   bgRect.size.width - 20, 20);
	labelSlider_ = [[UISlider alloc]initWithFrame:sliderRect];
	labelSlider_.minimumValue = 0;
	labelSlider_.maximumValue = [manager_ getDocumentPageCount] - 1;
	labelSlider_.continuous = YES;
	[labelSlider_ addTarget:self
                     action:@selector(actionOnSliderValueChanging) 
           forControlEvents:UIControlEventValueChanged];
    [labelSlider_ addTarget:self
                     action:@selector(actionOnSliderValueChanged) 
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:labelSlider_];
    
    // 9. restore file status.
    // TODO: 应用上次关闭时的状态（页码、倍率、显示位置等）
    
    	 
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
        
    // 1. save page status.
    // TODO: 保存关闭时的状态（页码、倍率、显示位置等）
    for(UIView* viewx in backgroundView_.subviews)
    {
        [viewx removeFromSuperview];
    }
    
    [backgroundView_ removeGestureRecognizer:doubleTapGestureRecognizer];
    [backgroundView_ removeGestureRecognizer:twoFingerTapGestureRecognizer];
    [backgroundView_ removeFromSuperview];
    [labelSlider_ removeFromSuperview];
    [labelPageNum_ removeFromSuperview];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;	
	self.navigationController.toolbar.barStyle = UIBarStyleDefault;
   // [self.navigationController.toolbar setHidden:YES];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    
  //  self.hidesBottomBarWhenPushed = YES;
   // unLoad_ = YES;
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
    [super viewWillDisappear:animated];
    
}


- (void) actionOnDoubleTappedByOneFinger:(UIGestureRecognizer *)gestureRecognizer
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        PDFScrollView* pageView_ = (PDFScrollView* )[self getPageViewWithPageIndex:pageIndex];
//        CGPoint touchPoint = [gestureRecognizer locationInView:pageView_.pdfView];
//        if (isOutin) {
//            
//            isOutin = NO;
//            [manager_ zoomOutPageView:pageView_ withTouchPoint:touchPoint];
//            
//        }else{
//            
//            isOutin = YES;
//            [manager_ zoomInPageView:pageView_ withTouchPoint:touchPoint];
//            
//        }
//    }
}



- (void) actionOnTappedByTwoFingers:(UIGestureRecognizer *)gestureRecognizer
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        PDFScrollView* pageView_ = (PDFScrollView* )[self getPageViewWithPageIndex:pageIndex];
//        CGPoint touchPoint = [gestureRecognizer locationInView:pageView_.pdfView];
//        [manager_ zoomOutPageView:pageView_ withTouchPoint:touchPoint];
//    }
}

- (void) insertPageViewToBackgroundViewWithPageIndex:(int)index
{
    pageIndex = index;
    
	PDFScrollView* pageView_ = [self getPageViewWithPageIndex:index];
	if (pageView_ == nil) {
		pageView_ = [manager_ createNewPageViewWithPageIndex:index];
        pageView_.tag = index;
        CGRect frame_ = pageView_.frame;
        frame_.origin = CGPointMake(backgroundView_.frame.size.width * index, 0);
        pageView_.frame = frame_;
        [backgroundView_ addSubview:pageView_];
	}
	
	PDFScrollView* prePage_ = [self getPageViewWithPageIndex:(index - 1)];
	if (prePage_ == nil && (index - 1 >= 0))
	{
		prePage_ = [manager_ createNewPageViewWithPageIndex:index - 1];
        prePage_.tag = index - 1;
        CGRect frame_ = prePage_.frame;
        frame_.origin = CGPointMake(backgroundView_.frame.size.width * (index - 1), 0);
        prePage_.frame = frame_;
        [backgroundView_ addSubview:prePage_];
	}
	
    PDFScrollView* nextPage_ = [self getPageViewWithPageIndex:(index + 1)];
	if (nextPage_ == nil && (index + 1 <= [manager_ getDocumentPageCount] - 1))
	{
		nextPage_ = [manager_ createNewPageViewWithPageIndex:index + 1];
        nextPage_.tag = index + 1;
        CGRect frame_ = nextPage_.frame;
        frame_.origin = CGPointMake(backgroundView_.frame.size.width * (index + 1), 0);
        nextPage_.frame = frame_;
        [backgroundView_ addSubview:nextPage_];
	}
}

- (PDFScrollView*) getPageViewWithPageIndex:(int)index
{
	for (UIView* subView in backgroundView_.subviews) {
		if (subView.tag == index) {
			return (PDFScrollView*)subView;
		}
	}
    
	return nil;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return isCanRotation;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    // 1. remove old views
    [self removePageViewsFromBackgroundView];
    
    // 2. update backgrund view..
    [self updateBackgroundView];
    
    // 3. upate orientation.
    manager_.orientation = toInterfaceOrientation;
    
    // 4. insert new page.
    [self insertPageViewToBackgroundViewWithPageIndex:pageIndex];
    
    // 5. update label control frame.
    [self updateLabelControlRectForRotation];
}

- (void) updateBackgroundView
{
    // 1. remove background delegate.
    backgroundView_.delegate = nil;
    
    // 2. update background view frame.
    backgroundView_.frame = CGRectMake(0, 0, 
                                       backgroundView_.frame.size.height, 
                                       backgroundView_.frame.size.width);
    
    // 3. update content size.
	int pageCount = [manager_ getDocumentPageCount];
	int width = backgroundView_.frame.size.width * pageCount;
	backgroundView_.contentSize = CGSizeMake(width, backgroundView_.frame.size.height);
    
    // 4. reset content offset.
    int position = backgroundView_.frame.size.width * pageIndex;
	backgroundView_.contentOffset = CGPointMake(position, 0);
    
    // 5. restore background delegate.
    backgroundView_.delegate = self;
}

- (void) updateLabelControlRectForRotation
{
    float toolbarHeight = 44.0;
    if (UIInterfaceOrientationIsPortrait(manager_.orientation) == YES)
	{
        toolbarHeight = 44.0;
	} else {
        toolbarHeight = 32.0;
	}
    
    // 1. update page number label
    CGRect labelRect = CGRectMake(10, toolbarHeight + 25, 50, 30);
    labelPageNum_.frame = labelRect;
    
    // 2. update page slider bar.
    CGRect bgRect = [manager_ getScreenRect];
    CGRect sliderRect = CGRectMake(10, bgRect.size.height - toolbarHeight - 25, 
                                   bgRect.size.width - 20, 20);
    labelSlider_.frame = sliderRect;
}

- (void) removePageViewsFromBackgroundView
{
	NSArray *subviews = [backgroundView_ subviews];
	for (PDFScrollView *pageView in subviews) {
		if (pageView != nil) {
			[pageView removeFromSuperview];
		}
	}
}

- (void) actionOnTouchLockRotationButton
{
    //isCanRotation = !isCanRotation;
    
    BOOL isVailable = [UIPrintInteractionController isPrintingAvailable];
    if (isVailable) 
    {
        // Obtain the shared UIPrintInteractionController
        UIPrintInteractionController *controller = [UIPrintInteractionController 
                                                    sharedPrintController];
        if(!controller){
            //NSLog(@"Couldn't get shared UIPrintInteractionController!");
            return;
        }
        
        controller.delegate = self;
        
        // We need a completion handler block for printing.
        UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if(completed && error)
                NSLog(@"FAILED! due to error in domain %@ with error code %u", 
                      error.domain, error.code);
//            if (completed == NO) {
//                [self.navigationController popViewControllerAnimated:NO];
//            }
            return;
        };
        
        
        // get file name 
        
        // set print info
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = fileName_;
        //printInfo.duplex = ;
        //printInfo.orientation = ;
        controller.printInfo = printInfo;
        
        controller.showsPageRange = YES;
    
        
        controller.printingItem = [self getPrintURL];

        // present print controller
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
                      //  [controller presentFromBarButtonItem:printButtonItem animated:YES 
                      //                     completionHandler:completionHandler];  // iPad
           // UIBarButtonItem *buttonitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
            
            [controller presentFromBarButtonItem:lockRotationItem animated:YES completionHandler:completionHandler];  // iPad
            
                       
        }
        else {
            
            
            [controller presentAnimated:YES completionHandler:completionHandler];  // iPhone
            
            
        }
    }

}

- (NSURL *) getPrintURL
{
    NSURL *url = nil;
    //NSString *printPath = [self getPDFFileName];
    NSString *printPath = filePath_;
    url = [NSURL fileURLWithPath:printPath];
    return url;
}

- (void) actionOnTouchPageNumButton
{
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"NSPdfViewer"
//                                                    message:@"Do you want to set page num ?"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:@"Cancel" ,
//                          (char *)nil];
//    [alert show];
//    [alert release];
    
    PDFScrollView* pageView_ = [self getPageViewWithPageIndex:pageIndex];
    UIGraphicsBeginImageContextWithOptions(pageView_.pdfView.bounds.size, YES, 1.0);
     
    [pageView_.pdfView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil); 
}

- (void) actionSendMail
{
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    if (mailClass != nil && [MFMailComposeViewController canSendMail]) 
    {

        NSString* mailFileName = [fileName_ copy];
        
        NSString *sendfileName = [NSString stringWithFormat:@"%@.pdf",mailFileName];
        //NSString* mailFilePath = [filePath_ retain]; 
        
        NSString* mailFilePath = filePath_;
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        NSString *mimeType = @"application/pdf";
        NSData *attachmentData = [NSData dataWithContentsOfFile:mailFilePath];
        if (mimeType != nil && [attachmentData length] > 0)
        {
            [picker addAttachmentData:attachmentData 
                             mimeType:mimeType 
                             fileName:sendfileName];
            [self presentModalViewController:picker animated:YES];
        }
        
       // [mailFilePath release];
       // [mailFileName release];
       // [picker release];
    }

}

// Dismisses the email composition interface when users tap Cancel or Send. 
// Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController *)controller 
		  didFinishWithResult:(MFMailComposeResult)result 
						error:(NSError *)error

{
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}

- (void) actionOnSliderValueChanging
{
    int value = labelSlider_.value;
    int pageNum = value + 1;
    int pageCount = [manager_ getDocumentPageCount];
    labelPageNum_.text = [NSString stringWithFormat:@"%d/%d", pageNum, pageCount];
}

- (void) actionOnSliderValueChanged
{
    int value = labelSlider_.value;
    if (value != pageIndex) {
        int position = backgroundView_.frame.size.width * value;
        [backgroundView_ setContentOffset:CGPointMake(position, 0) animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    //self.hidesBottomBarWhenPushed = NO;
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)dealloc {
    //[fileName_ release];
    //[filePath_ release];
    //[manager_ release];
    //[backgroundView_ release];
   // [labelPageNum_ release];
   // [doubleTapGestureRecognizer release];
    //[twoFingerTapGestureRecognizer release];
   // [super dealloc];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	int preIndex = pageIndex;
	int pageWidth = backgroundView_.frame.size.width;
	int offsetX = backgroundView_.contentOffset.x;
	int index = (offsetX + pageWidth / 2 ) / pageWidth;	
	if (preIndex == index) {
		return;
	}
	
    // insert new page view for move page.
	if (index >= 0 && index <= [manager_ getDocumentPageCount] - 1) {
		[self insertPageViewToBackgroundViewWithPageIndex:index];
	}
    
    // update page number.
    int pageNum = pageIndex + 1;
    int pageCount = [manager_ getDocumentPageCount];
    labelPageNum_.text = [NSString stringWithFormat:@"%d/%d", pageNum, pageCount];
}


@end
