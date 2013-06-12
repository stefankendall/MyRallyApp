#import "DescriptionViewController.h"

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
    [self.webView loadHTMLString:[self htmlFor:description] baseURL:nil];
}

- (NSString *)htmlFor:(NSString *)description {
    return [NSString stringWithFormat:@"<html><body>%@</body></html>", description];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.webView loadHTMLString:[self htmlFor:[textView text]] baseURL:nil];
}

@end