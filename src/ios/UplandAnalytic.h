//
//  UplandReceiptVerifier.h
//  Upland
//
//  Created by upland on 31.07.2020.
//

#import "RMStore.h"
#import <Foundation/Foundation.h>
#import <Cordova/CDVWebViewEngineProtocol.h>


@interface UplandAnalytic : NSObject<RMStoreReceiptVerifier>;

@property (nonatomic, weak) id <CDVWebViewEngineProtocol> webView;

@property (nonatomic, weak) RMStore *store;

- (instancetype)initWithWebView:(id <CDVWebViewEngineProtocol>)webview;

- (void)verifyTransaction:(SKPaymentTransaction *)transaction success:(void (^)(void))successBlock failure:(void (^)(NSError *))failureBlock;

- (void)failTransaction:(SKPaymentTransaction *)transaction error:(NSError *)err;

- (void)restoreTransaction:(SKPaymentTransaction *)transaction;

- (void)didDeferTransaction:(SKPaymentTransaction *)transaction;

@end
