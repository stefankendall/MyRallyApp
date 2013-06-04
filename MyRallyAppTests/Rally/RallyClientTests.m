#import "RallyClientTests.h"
#import "RallyClient.h"

@implementation RallyClientTests

- (void)setUp {
    done = NO;
    RallyClient *client = [RallyClient instance];
    [client setUsername:@"skendall@rallydev.com" andPassword:@"Password"];
}

- (void)testCanRetrieveActiveStories {
    [self waitForAuth];
    [[RallyClient instance] getActiveStories:^(NSArray *stories) {
        done = YES;
        STAssertTrue( [stories count] > 0, @"");
        NSDictionary * story = stories[0];
        NSDictionary *owner = [story objectForKey:@"Owner"];
        STAssertNotNil(owner, @"");
    }                                failure:^{
        done = YES;
        STFail(@"Could not get stories");
    }];
    [self waitForCompletion:5];
}

- (void)waitForAuth {
    [[RallyClient instance] authorize:^{
        done = YES;
    }                         failure:^{
        STFail(@"Auth failed");
    }];
    [self waitForCompletion:5];
    done = NO;
}

- (void)testGetsSecurityToken {
    __block NSString *token;
    [[RallyClient instance] getSecurityTokenWithSuccess:^(NSString *token1) {
        token = token1;
        done = YES;
    }                                        andFailure:^{
        done = YES;
    }];
    [self waitForCompletion:5];
    STAssertNotNil(token, @"");
    STAssertFalse([token isEqualToString:@""], @"");
}

- (void)testAuthorizesSuccessfully {
    __block BOOL success = NO;
    [[RallyClient instance] authorize:^{
        done = YES;
        success = YES;
    }                         failure:^{
    }];

    [self waitForCompletion:5];
    STAssertTrue(success, @"");
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];

    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if ([timeoutDate timeIntervalSinceNow] < 0.0) {
            STFail(@"Operation timed out");
            break;
        }
    } while (!done);

    return done;
}

@end