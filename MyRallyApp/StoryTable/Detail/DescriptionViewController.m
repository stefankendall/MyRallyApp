#import "DescriptionViewController.h"

@implementation DescriptionViewController

- (id)initWithStory:(NSMutableDictionary *)story1 {
    if (self = [super initWithText:story1[@"Description"]]) {
        self.story = story1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Description"];
    [self.textView setDelegate:self];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *description = [textView text];
    [self.story setObject:description forKey:@"Description"];
}

@end