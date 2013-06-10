#import "StoryDetailViewController.h"

@implementation StoryDetailViewController

- (void)viewWillAppear: (BOOL) animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = self.story[@"FormattedID"];
}


@end