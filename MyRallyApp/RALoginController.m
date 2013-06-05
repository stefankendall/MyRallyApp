#import "RALoginController.h"
#import "StoriesViewController.h"

@implementation RALoginController

- (IBAction)loginTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    StoriesViewController *storiesViewController = [storyboard instantiateViewControllerWithIdentifier:@"myStories"];
    [self.navigationController pushViewController:storiesViewController animated:YES];
}

@end