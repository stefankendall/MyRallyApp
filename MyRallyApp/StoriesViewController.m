#import "StoriesViewController.h"
#import "StoryDataSource.h"
#import "RallyClient.h"
#import "UIScrollView+SVPullToRefresh.h"

@implementation StoriesViewController

@synthesize loadingIndicator;

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    storiesDataSource = [StoryDataSource new];
    [storiesTable setDataSource:storiesDataSource];
    [storiesTable setDelegate:storiesDataSource];

    [storiesTable addPullToRefreshWithActionHandler:^{
        [self authorizeAndRetrieveStories];
    }];

    [loadingIndicator startAnimating];
    [self authorizeAndRetrieveStories];
}

- (void)authorizeAndRetrieveStories {
    RallyClient *client = [RallyClient instance];
    [client setUsername:@"skendall@rallydev.com" andPassword:@"Password"];
    [client authorize:^{
        [self retrieveStories];
    }         failure:^{
        [NSException raise:@"Could not auth. Handle this." format:@""];
    }];
}

- (void)retrieveStories {
    RallyClient *client = [RallyClient instance];
    [client getActiveStoriesForUser:@"skendall@rallydev.com" success:^(NSArray *stories) {
        [self populateWithStories:stories];
    }                       failure:^{
        [NSException raise:@"Could not get stories. Handle this." format:@""];
    }];
}

- (void)populateWithStories:(NSArray *)stories {
    storiesDataSource.stories = stories;
    [storiesTable reloadData];

    [loadingIndicator stopAnimating];
    [storiesTable.pullToRefreshView stopAnimating];
}


@end