#import "DescriptionViewController.h"
#import "HtmlWrapper.h"

@implementation DescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil story:(NSMutableDictionary *)story1 {
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        self.story = story1;
    }

    return self;
}

- (IBAction)editViewValueChanged:(id)sender {
    int index = [sender selectedSegmentIndex];
    BOOL editing = index == 0;
    [self.textView setHidden:!editing];
    [self.webView setHidden:editing];
}

- (void)viewDidLoad {
    NSString *description = [self.story objectForKey:@"Description"];
    [self.textView setText:description];
    [self.textView setDelegate:self];
    [self.webView loadHTMLString:[[HtmlWrapper new] htmlFor:description] baseURL:nil];
    [self.navigationItem setTitle:@"Description"];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *description = [textView text];
    [self.webView loadHTMLString:[[HtmlWrapper new] htmlFor:description] baseURL:nil];
    [self.story setObject:description forKey:@"Description"];
}

@end