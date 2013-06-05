#import "CTCustomTableViewCell.h"

@interface StoryCell : CTCustomTableViewCell
{}
@property (nonatomic, strong) NSDictionary *story;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;

- (void) setStory: (NSDictionary *) story;

@end