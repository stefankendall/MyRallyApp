#import "StoriesViewController.h"
#import "StoryDataSource.h"

@implementation StoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    storiesDataSource = [StoryDataSource new];
    [storiesTable setDataSource:storiesDataSource];
}


@end