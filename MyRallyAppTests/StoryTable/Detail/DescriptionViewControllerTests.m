#import "DescriptionViewControllerTests.h"
#import "DescriptionViewController.h"

@implementation DescriptionViewControllerTests

- (void)testSetsTextViewAndWebViewWhenViewLoads {
    NSMutableDictionary *story = [@{@"Description" : @"<em>hello</em>"} mutableCopy];
    DescriptionViewController *controller = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" story:story];
    [controller loadView];
    [controller viewDidLoad];

    STAssertEqualObjects([controller.textView text], @"<em>hello</em>", @"");
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