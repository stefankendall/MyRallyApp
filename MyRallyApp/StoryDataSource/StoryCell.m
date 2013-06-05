#import "StoryCell.h"

@implementation StoryCell
@synthesize nameLabel;

- (void)setStory:(NSDictionary *)story {
    [nameLabel setText:[story objectForKey:@"Name"]];
}

@end