#import "DescriptionViewControllerTests.h"
#import "DescriptionViewController.h"

@implementation DescriptionViewControllerTests

- (void)testEditViewSegmentTogglesVisibility {
    DescriptionViewController *controller = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" story:nil];
    [controller loadView];
    STAssertNotNil(controller.editViewSegment, @"");

    [controller.editViewSegment setSelectedSegmentIndex:1];
    [controller editViewValueChanged:controller.editViewSegment];
    STAssertFalse([controller.webView isHidden], @"");
    STAssertTrue([controller.textView isHidden], @"");

    [controller.editViewSegment setSelectedSegmentIndex:0];
    [controller editViewValueChanged:controller.editViewSegment];
    STAssertTrue([controller.webView isHidden], @"");
    STAssertFalse([controller.textView isHidden], @"");
}

- (void)testSetsTextViewAndWebViewWhenViewLoads {
    NSMutableDictionary *story = [@{@"Description" : @"<em>hello</em>"} mutableCopy];
    DescriptionViewController *controller = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" story:story];
    [controller loadView];
    [controller viewDidLoad];

    STAssertEqualObjects([controller.textView text], @"<em>hello</em>", @"");
}

- (void) testHtmlForWrapsContentInHtml {
    DescriptionViewController *controller = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" story:nil];
    STAssertEqualObjects([controller htmlFor: @"<em>hello</em>"], @"<html><body><em>hello</em></body></html>", @"");
}

- (void) testTextViewDidChangeUpdatesStory {
    NSMutableDictionary *story = [@{} mutableCopy];
    DescriptionViewController *controller = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" story:story];
    [controller loadView];

    [controller.textView setText:@"internal change"];
    [controller textViewDidChange:controller.textView];
    STAssertEqualObjects([story objectForKey:@"Description"], @"internal change", @"");
}

@end