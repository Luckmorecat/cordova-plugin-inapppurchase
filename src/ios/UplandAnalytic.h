//
//  UplandReceiptVerifier.h
//  Upland
//
//  Created by upland on 31.07.2020.
//

#import "RMStore.h"
#import <Foundation/Foundation.h>
#import <Cordova/CDVWebViewEngineProtocol.h>


@interface UplandAnalytic : NSObject<RMStoreObserver>;

@property (nonatomic, weak) id <CDVWebViewEngineProtocol> webView;

@property (nonatomic, weak) RMStore *store;

- (instancetype)initWithWebView:(id <CDVWebViewEngineProtocol>)webview;

- (void)runCode:(NSString *)code;

@end
