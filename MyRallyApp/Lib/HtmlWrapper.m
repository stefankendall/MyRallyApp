#import "HtmlWrapper.h"

@implementation HtmlWrapper

- (NSString *)htmlFor:(NSString *)description {
    return [NSString stringWithFormat:@"<html><body>%@</body></html>", description];
}

@end