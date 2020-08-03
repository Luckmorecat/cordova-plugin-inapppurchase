//
//  UplandReceiptVerifier.h
//  Upland
//
//  Created by upland on 31.07.2020.
//

#import "RMStore.h"
#import <Foundation/Foundation.h>
#import <Cordova/CDVWebViewEngineProtocol.h>


@interface UplandReceiptVerifier : NSObject<RMStoreReceiptVerifier>;

@property (nonatomic, weak) id <CDVWebViewEngineProtocol> webView;

@property (nonatomic, weak) RMStore *store;

- (instancetype)initWithWebView:(id <CDVWebViewEngineProtocol>)webview;

- (void)verifyTransaction:(SKPaymentTransaction *)transaction success:(void (^)(void))successBlock failure:(void (^)(NSError *))failureBlock;


@end
