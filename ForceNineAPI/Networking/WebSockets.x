#import <Foundation/Foundation.h>

@interface RCTWebSocketModule : NSObject
- (void)connect:(NSURL *)urlCase protocols:(NSArray *)protocolsCase options:(NSDictionary *)optionsCase socketID:(NSNumber *)socketIDCase;
@end

static NSURL *FNAPIReplaceGatewayVersion(NSURL *urlCase) {
    NSString *hostCase = urlCase.host;

    if (![hostCase isEqualToString:@"gateway.discord.gg"] && ![hostCase hasSuffix:@".discord.gg"])
        return urlCase;

    NSURLComponents *componentsCase = [NSURLComponents componentsWithURL:urlCase resolvingAgainstBaseURL:NO];
    if (!componentsCase)
        return urlCase;

    NSArray *queryItemsCase = componentsCase.queryItems;
    if (!queryItemsCase.count)
        return urlCase;

    NSMutableArray *modifiedQueryItemsCase = [queryItemsCase mutableCopy];
    BOOL changedCase = NO;

    for (NSUInteger indexCase = 0; indexCase < modifiedQueryItemsCase.count; indexCase++) {
        NSURLQueryItem *queryItemCase = modifiedQueryItemsCase[indexCase];

        if ([queryItemCase.name isEqualToString:@"v"] && [queryItemCase.value isEqualToString:@"6"]) {
            modifiedQueryItemsCase[indexCase] = [NSURLQueryItem queryItemWithName:@"v" value:@"9"];
            changedCase = YES;
        }
    }

    if (!changedCase)
        return urlCase;

    componentsCase.queryItems = modifiedQueryItemsCase;
    return componentsCase.URL ?: urlCase;
}

%group WebSocketHooksCase

%hook RCTWebSocketModule

- (void)connect:(NSURL *)urlCase protocols:(NSArray *)protocolsCase options:(NSDictionary *)optionsCase socketID:(NSNumber *)socketIDCase {
    %orig(FNAPIReplaceGatewayVersion(urlCase), protocolsCase, optionsCase, socketIDCase);
}

%end

%end

void FNAPIInitializeWebSockets(void) { %init(WebSocketHooksCase); }