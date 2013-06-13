#import "BWLongTextViewController.h"

@interface DescriptionViewController : BWLongTextViewController <UITextViewDelegate> {}

- (id)initWithStory: (NSMutableDictionary *) story1;

@property (nonatomic, strong) NSMutableDictionary *story;

@end