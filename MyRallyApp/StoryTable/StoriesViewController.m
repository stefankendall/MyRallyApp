#import "StoriesViewController.h"
#import "StoryDataSource.h"
#import "RallyClient.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "StoryCell.h"
#import "StoryDetailViewController.h"
#import "StoryDivider.h"
#import "StoryStore.h"

@interface StoriesViewController ()
@end

@implementation StoriesViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    storiesDataSource = [StoryDataSource new];
    [storiesTable setDataSource:storiesDataSource];
    [storiesTable setDelegate:self];

    [storiesTable addPullToRefreshWithActionHandler:^{
        [self authorizeAndRetrieveStories];
    }];

    [self.loadingIndicator startAnimating];
    [self authorizeAndRetrieveStories];
}

- (void)authorizeAndRetrieveStories {
    RallyClient *client = [RallyClient instance];
    [client authorize:^{
        [self retrieveStories];
    }         failure:^{
        [NSException raise:@"Could not auth. Handle this." format:@""];
    }];
}

- (void)retrieveStories {
    RallyClient *client = [RallyClient instance];
    [client getActiveStoriesForUser:client.username success:^(NSArray *stories) {
        [self populateWithStories:stories];
    }                       failure:^{
        [NSException raise:@"Could not get stories. Handle this." format:@""];
    }];
}

- (void)populateWithStories:(NSArray *)stories {
    [[StoryStore instance] setStoriesByScheduleState:[[StoryDivider new] storiesByScheduleState:stories]];
    [storiesTable reloadData];

    [self.loadingIndicator stopAnimating];
    [storiesTable.pullToRefreshView stopAnimating];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *viewToPreventBlankRows = [UIView new];
    return viewToPreventBlankRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = (StoryCell *) [storiesDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell bounds].size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *scheduleState = ([[StoryStore instance] getOrderedScheduleStates])[(NSUInteger) [indexPath section]];
    self.storyInDetail = [[StoryStore instance] storiesByScheduleState][scheduleState][(NSUInteger) [indexPath row]];

    [self performSegueWithIdentifier:@"storyDetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"storyDetailSegue"]) {
        StoryDetailViewController *controller = [segue destinationViewController];
        [controller setStory:self.storyInDetail];
    }
}


@end