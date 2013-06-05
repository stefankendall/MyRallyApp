#import "StoryCell.h"

@implementation StoryCell
@synthesize nameLabel, descriptionWebView, story;

- (void)setStory:(NSDictionary *)story1 {
    story = story1;
    [nameLabel setText:[story objectForKey:@"Name"]];
    [self setupDescription: [story objectForKey:@"Description"]];
}

- (void)setupDescription:(NSString *)descriptionHtml {
    NSString *html = [NSString stringWithFormat: @"<html><body>%@</body></html>", descriptionHtml];
    [descriptionWebView loadHTMLString:html baseURL:nil];
}

@end