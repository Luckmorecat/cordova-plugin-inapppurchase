//
//  UplandReceiptVerifier.m
//  Upland
//
//  Created by upland on 31.07.2020.
//

#import <Foundation/Foundation.h>
#import "UplandAnalytic.h"

@implementation UplandAnalytic



-(instancetype)initWithWebView:(id<CDVWebViewEngineProtocol>)webview {
    
    if ([super init] != nil) {
        
        _webView = webview;
        
    }
    
    return self;
    
}

-(void)failTransaction:(SKPaymentTransaction *)transaction error:(NSError *)err {
   
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {

}

- (void)didDeferTransaction:(SKPaymentTransaction *)transaction {

}

-(void)verifyTransaction:(SKPaymentTransaction *)transaction success:(void (^)())successBlock failure:(void (^)(NSError *))failureBlock {    
    [_store refreshReceipt];
    NSURL *receiptUrl = [RMStore receiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
 
    [_webView evaluateJavaScript:[NSString stringWithFormat:@"window._verifyIosTransaction('%@', '%@')", transaction.transactionIdentifier, [receiptData base64EncodedStringWithOptions:0]] completionHandler:^(id someId, NSError *error) { 
        if (error != nil) {
            NSLog(@"EVALUTE ERROR: %ld", (long)error.code);
        }
        
    }];
   
    successBlock();
    
}

@end
