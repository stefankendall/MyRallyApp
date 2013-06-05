#import "RallyClient.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"

NSString * const TEST_USER = @"skendall@rallydev.com";
NSString * const TEST_PASSWORD = @"Password";

@implementation RallyClient

- (void)setUsername:(NSString *)username1 andPassword:(NSString *)password1 {
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:username1 password:password1];
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self)
        return nil;

    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setParameterEncoding:AFJSONParameterEncoding];

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    return self;
}

+ (RallyClient *)instance {
    static dispatch_once_t pred;
    static RallyClient *instance = nil;

    dispatch_once(&pred, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://rally1.rallydev.com/slm/webservice/v2.0"]];
    });
    return instance;
}

- (void)authorize:(void (^)())success failure:(void (^)())failure {
    [self getSecurityTokenWithSuccess:^(NSString *token) {
        securityToken = token;
        success();
    }                      andFailure:^{
        failure();
    }];
}

- (void)getActiveStoriesForUser: (NSString*) username success:(void (^)(NSArray *))success failure:(void (^)())failure {
    void (^requestSuccess)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *op, id json) {
        success([self getStoriesFromJson:json]);
    };
    void (^requestFailure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        failure();
    };

    NSMutableDictionary *params = [self authParams];
    [params setObject:@"true" forKey:@"fetch"];
    [params setObject:[NSString stringWithFormat:@"((Owner = %@) and (ScheduleState = In-Progress))", username] forKey:@"query"];
    [self getPath:@"hierarchicalrequirement" parameters:params success:requestSuccess failure:requestFailure];
}

- (NSArray *)getStoriesFromJson:(NSDictionary *)json {
    return [[json objectForKey:@"QueryResult"] objectForKey:@"Results"];
}

- (NSMutableDictionary *)authParams {
    return [@{@"key" : securityToken} mutableCopy];
}

- (void)getSecurityTokenWithSuccess:(void (^)(NSString *))successCallback andFailure:(void (^)())failureCallback {
    void (^success)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *op, id json) {
        successCallback([self getSecurityTokenFromJson:(NSDictionary *) json]);
    };
    void (^failure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        failureCallback();
    };

    [self getPath:@"security/authorize" parameters:nil success:success failure:failure];
}

- (NSString *)getSecurityTokenFromJson:(NSDictionary *)json {
    return [[json objectForKey:@"OperationResult"] objectForKey:@"SecurityToken"];
}


@end