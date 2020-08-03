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

- (NSString *)getReceipt {
    NSURL *receiptUrl = [RMStore receiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    
    return [receiptData base64EncodedStringWithOptions:0];
}

-(void)verifyTransaction:(SKPaymentTransaction *)transaction success:(void (^)())successBlock failure:(void (^)(NSError *))failureBlock {    
    NSString *receipt = [self getReceipt];
 
    [_webView evaluateJavaScript:[NSString stringWithFormat:@"window._verifyIosTransaction('%@', '%@')", transaction.transactionIdentifier, receipt] completionHandler:^(id someId, NSError *error) {
        if (error != nil) {
            NSLog(@"EVALUTE ERROR: %ld", (long)error.code);
        }
        
    }];
   
    successBlock();
    
}

@end
