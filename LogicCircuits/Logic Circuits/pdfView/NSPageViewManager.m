
#import "NSPageViewManager.h"

@implementation NSPageViewManager
@synthesize orientation;

- (id) initWithFilePath:(NSString*)filepath
{
    if ((self = [super init])) {
        //filePath_ = [filepath retain];
        filePath_ = filepath;
        
        BOOL res = [self loadDocumentWithFilePath:filePath_];
        if (res == NO) {
           // [self autorelease];
            return nil;
        }
    }
    
    return self;
}

- (BOOL) loadDocumentWithFilePath:(NSString*)filepath
{
    if (filepath == nil) {
        return NO;
    }
    
    const char *fileName_const_char = [filepath UTF8String];
    char fileName_char[1024] = { 0 };
    strcpy(fileName_char, fileName_const_char);
    
	CFStringRef path = CFStringCreateWithCString(NULL, fileName_char, kCFStringEncodingUTF8);   
	CFURLRef url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);   
	CFRelease(path);
	
	documentRef_ = CGPDFDocumentCreateWithURL(url);
    
	if (documentRef_ == NULL) {
		CFRelease(url);
		return NO;
	}
	CFRelease(url);
	
	return YES;
}

- (int) getDocumentPageCount
{
    int pageCount = 0;
    pageCount = (int)CGPDFDocumentGetNumberOfPages(documentRef_);
    return pageCount;
}

- (PDFScrollView*) createNewPageViewWithPageIndex:(int)index
{
    CGRect pageViewRect = [self getScreenRect];
    float kPageViewEdgeWidth = 5.0;
    
    PDFScrollView *newPdfpage = [[PDFScrollView alloc]initWithFrame:pageViewRect FromPDF:documentRef_ andPageNumber:index];
    newPdfpage.contentInset = UIEdgeInsetsMake(0, kPageViewEdgeWidth, 0, kPageViewEdgeWidth);

    
    return newPdfpage;

    /*
    // 1. init page view
    float kPageViewEdgeWidth = 5.0;
    CGRect pageViewRect = [self getScreenRect];
    NSScrollView* pageView = [[[NSScrollView alloc]initWithFrame:pageViewRect] autorelease];
    pageView.contentInset = UIEdgeInsetsMake(0, kPageViewEdgeWidth, 0, kPageViewEdgeWidth);
	[pageView setBackgroundColor:[UIColor grayColor]];
	pageView.showsHorizontalScrollIndicator = YES;
	pageView.showsVerticalScrollIndicator = YES;
	pageView.scrollEnabled = YES;
	pageView.bounces = YES;
	pageView.scrollsToTop = NO;
    
    
    
    // 2. init pdf page
    // 2.1 get page ref
    long pageNumber = index + 1;
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(documentRef_, pageNumber);
    
    // 2.2 get page scale.
    CGRect screen = [self getScreenRect];
    CGRect rect = CGPDFPageGetBoxRect(pageRef, kCGPDFMediaBox);
    float scaleX = (float)(screen.size.width - kPageViewEdgeWidth * 2) / rect.size.width;
    float scaleY = (float)screen.size.height / rect.size.height;
    float scale = scaleX > scaleY ? scaleY : scaleX;
    
    // 2.3 get page rect.
    float originX = ((screen.size.width - kPageViewEdgeWidth * 2) - rect.size.width * scale) / 2;//change scale to scaleX
    float originY = ((screen.size.height) - rect.size.height* scale) / 2;//change scale to scaleY
    CGRect pageRect = CGRectMake(originX, 
                                 originY, 
                                 rect.size.width * scale, 
                                 rect.size.height* scale);
    //CGRect pageRect = rect;
    //pageRect.size = CGSizeMake(rect.size.width * scale, rect.size.height * scale);
    
    
    // 2.4 init pdf page.
    NSPdfPageView* page_ = [[[NSPdfPageView alloc]initWithFrame:pageRect]autorelease];
    
    // 2.5 init page index.
    page_.pageIndex = index;
    
    // 2.6 init page ref.
    page_.pageRef = pageRef;
    
    // 2.7 init page zoomscale.
    page_.baseScale = scale;
    
    pageView.page = page_;
    [pageView addSubview:page_];

    return pageView;
     */
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

- (void) zoomInPageView:(UIScrollView*)pageView withTouchPoint:(CGPoint)point
{
    if (pageView.zoomScale >= pageView.maximumZoomScale) {
        return;
    }
    
    float zoomScale = pageView.zoomScale * 2;
    if (zoomScale > pageView.maximumZoomScale) {
        zoomScale = pageView.maximumZoomScale;
    }
    
    CGRect zoomRect = CGRectNull;
	zoomRect.size.width = pageView.frame.size.width / zoomScale;
	zoomRect.size.height = pageView.frame.size.height / zoomScale;
    zoomRect.origin.x = point.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = point.y - (zoomRect.size.height / 2.0);
    
    NSLog(@"zoomRect.origin.xy is (%f,%f)",zoomRect.origin.x,zoomRect.origin.y);
    
    [pageView zoomToRect:zoomRect animated:YES];
    [pageView setNeedsUpdateConstraints];
}

- (void) zoomOutPageView:(UIScrollView*)pageView withTouchPoint:(CGPoint)point
{
    if (pageView.zoomScale <= pageView.minimumZoomScale) {
        return;
    }
    
    float zoomScale = pageView.zoomScale / 2;
    if (zoomScale < pageView.minimumZoomScale) {
        zoomScale = pageView.minimumZoomScale;
    }
    
    CGRect zoomRect = CGRectNull;
	zoomRect.size.width = pageView.frame.size.width / zoomScale;
	zoomRect.size.height = pageView.frame.size.height / zoomScale;
    zoomRect.origin.x = point.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = point.y - (zoomRect.size.height / 2.0);
    
    [pageView zoomToRect:zoomRect animated:YES];
    [pageView setNeedsUpdateConstraints];
}

- (void) dealloc {
	//[filePath_ release];	
    //[super dealloc];
}

@end
