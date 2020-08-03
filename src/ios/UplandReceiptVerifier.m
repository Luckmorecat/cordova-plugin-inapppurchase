//
//  UplandReceiptVerifier.m
//  Upland
//
//  Created by upland on 31.07.2020.
//

#import <Foundation/Foundation.h>
#import "UplandReceiptVerifier.h"

@implementation UplandReceiptVerifier



-(instancetype)initWithWebView:(id<CDVWebViewEngineProtocol>)webview {
    
    if ([super init] != nil) {
        
        _webView = webview;
        
    }
    
    return self;
    
}

-(void)verifyTransaction:(SKPaymentTransaction *)transaction success:(void (^)())successBlock failure:(void (^)(NSError *))failureBlock {
    
//    NSDictionary *env = [[NSProcessInfo processInfo] environment];
//
//    NSURL *url = [NSURL URLWithString:env[@"VERIFY_URL"]];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//
//    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
//    NSData *receipt = [NSData dataWithContentsOfURL:receiptUrl];
//
//    if (receipt == nil) {
//        NSLog(@"No receipt");
//    }
//
//    NSDictionary *jsonBodyDict = @{@"token": receipt, @"transaction_id": transaction.transactionIdentifier};
//
//
//    [request setURL:url];
//
//    [request setHTTPMethod:@"POST"];
//
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//
//    [request setHTTPBody:jsonBodyDict];
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//
//    configuration.timeoutIntervalForRequest = 30.0;
//    configuration.timeoutIntervalForResource = 60.0;
//
//    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
//    _session = [NSURLSession sessionWithConfiguration:configuration];
    
    [_store refreshReceipt];
    NSURL *receiptUrl = [RMStore receiptURL];
    
    [_webView evaluateJavaScript:[NSString stringWithFormat:@"alert(window._verifyIosTransaction)", [[NSData dataWithContentsOfURL:receiptUrl] base64EncodedStringWithOptions:0]] completionHandler:^(id someId, NSError *error) {
        NSLog(@"EVALUTE JAVASCRIPT WITH DATA: %@", [[NSData dataWithContentsOfURL:receiptUrl] base64EncodedStringWithOptions:0]);
        
        if (error != nil) {
            NSLog(@"EVALUTE ERROR: %ld", (long)error.code);
        }
        
    }];
    
    [_webView evaluateJavaScript:[NSString stringWithFormat:@"window._verifyIosTransaction('%@', '%@')", transaction.transactionIdentifier, [NSData dataWithContentsOfURL:receiptUrl]] completionHandler:^(id someId, NSError *error) {
        NSLog(@"EVALUTE JAVASCRIPT AND CALL SUCCESS");
        
        if (error != nil) {
            NSLog(@"EVALUTE ERROR: %ld", (long)error.code);
        }
        
    }];
    NSLog(@"EVALUTE JAVASCRIPT after");
    successBlock();
    
}

@end
