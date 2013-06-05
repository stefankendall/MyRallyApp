#import "StoryTableDelegate.h"

@implementation StoryTableDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *viewToPreventBlankRows = [UIView new];
    return viewToPreventBlankRows;
}

@end