#import "RallyClientTests.h"
#import "RallyClient.h"

@interface RallyClientTests ()

@property(nonatomic, copy) void(^failureCallback)();
@end

@implementation RallyClientTests

- (void)setUp {
    self.failureCallback = ^{
        done = YES;
        STFail(@"Callback failed");
    };

    done = NO;
    RallyClient *client = [RallyClient instance];
    [client setUsername:TEST_USER andPassword:TEST_PASSWORD];
}

- (void)testCanRetrieveActiveStories {
    [self waitForAuth];
    [[RallyClient instance] getActiveStoriesForUser:TEST_USER success:^(NSArray *stories) {
        done = YES;
        STAssertTrue( [stories count] > 0, @"");
        NSDictionary *story = stories[0];
        NSLog(@"%@", story);
        NSDictionary *owner = [story objectForKey:@"Owner"];
        STAssertNotNil(owner, @"");
        NSString *name = [owner objectForKey:@"_refObjectName"];
        STAssertTrue( [name isEqualToString:@"Stefan"], [NSString stringWithFormat:@"%@", owner]);

        NSString *scheduleState = [story objectForKey:@"ScheduleState"];
        STAssertFalse([scheduleState isEqualToString:@"Closed"], @"");
        STAssertFalse([scheduleState isEqualToString:@"Released"], @"");
    }                                       failure:self.failureCallback];
    [self waitForCompletion:5];
}

- (void)waitForAuth {
    [[RallyClient instance] authorize:^{
        done = YES;
    }                         failure:self.failureCallback];
    [self waitForCompletion:5];
    done = NO;
}

- (void)testGetsSecurityToken {
    __block NSString *token;
    [[RallyClient instance] getSecurityTokenWithSuccess:^(NSString *token1) {
        token = token1;
        done = YES;
    }                                        andFailure:self.failureCallback];
    [self waitForCompletion:5];
    STAssertNotNil(token, @"");
    STAssertFalse([token isEqualToString:@""], @"");
}

- (void)testAuthorizesSuccessfully {
    __block BOOL success = NO;
    [[RallyClient instance] authorize:^{
        done = YES;
        success = YES;
    }                         failure:self.failureCallback];

    [self waitForCompletion:5];
    STAssertTrue(success, @"");
}

- (void)testCanUpdateStories {
    [self waitForAuth];
    RallyClient *client = [RallyClient instance];
    [client getActiveStoriesForUser:TEST_USER success:^(NSArray *stories) {
        NSDictionary *story = stories[0];
        STAssertNotNil(story, @"");

        NSString *newValue = [NSString stringWithFormat:@"%@%d", @"changed", arc4random_uniform(1000)];
        [client updateStory:story withValues:@{@"Description": newValue} withSuccess:^(id json){
            [client getActiveStoriesForUser:TEST_USER success:^(NSArray *stories) {
                done = YES;
                NSDictionary *story = stories[0];
                STAssertEqualObjects([story objectForKey:@"Description"], newValue, @"");

            }                       failure:self.failureCallback];
        }        andFailure:self.failureCallback];
    }                       failure:self.failureCallback];


    [self waitForCompletion:10];
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