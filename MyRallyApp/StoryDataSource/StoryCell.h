#import "CTCustomTableViewCell.h"

@interface StoryCell : CTCustomTableViewCell
{}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void) setStory: (NSDictionary *) story;

@end