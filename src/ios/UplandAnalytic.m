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

- (NSString *)getReceipt {
    NSURL *receiptUrl = [RMStore receiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    
    return [receiptData base64EncodedStringWithOptions:0];
}


- (void)storePaymentTransactionDeferred:(NSNotification *)notification {
NSLog(@"Upland obs defered");
    NSString *code = [NSString stringWithFormat:@"window._cordovaIos.storeDeffered('%@', '%@')", notification.rm_transaction.transactionIdentifier, notification.rm_productIdentifier];
    
    [self runCode:code];
    
}

-(void)storePaymentTransactionFailed:(NSNotification *)notification {
    NSLog(@"Upland obs failed");
    NSString *code = [NSString stringWithFormat:@"window._cordovaIos.storeFailed('%@', '%@', '%ld')", notification.rm_transaction.transactionIdentifier, notification.rm_productIdentifier, (long)notification.rm_storeError.code];
    
    [self runCode:code];
}

- (void)storePaymentTransactionFinished:(NSNotification *)notification {
    NSLog(@"Upland obs finish");
    NSString *receipt = [self getReceipt];
    NSString *code = [NSString stringWithFormat:@"window._cordovaIos.storePurchased('%@', '%@', '%@')", notification.rm_transaction.transactionIdentifier, receipt, notification.rm_productIdentifier];
    
    [self runCode:code];
}

- (void)storeRestoreTransactionsFinished:(NSNotification *)notification {
    NSLog(@"Upland obs restore finished");
    NSString *code = [NSString stringWithFormat:@"window._cordovaIos.storeRestoreSuccess('%@', '%@')", notification.rm_transaction.transactionIdentifier, notification.rm_productIdentifier];
    
    [self runCode:code];
}

- (void)storeRestoreTransactionsFailed:(NSNotification *)notification {
    NSLog(@"Upland obs restore failed");
    NSString *code = [NSString stringWithFormat:@"window._cordovaIos.storeRestoredFail('%@', '%@', '%ld')", notification.rm_productIdentifier,  notification.rm_transaction.transactionIdentifier, (long)notification.rm_storeError.code];
    
    [self runCode:code];
}

- (void)storeOtherStateOfTransaction:(NSNotification *)notification {
    NSLog(@"Upland obs other state %ld", notification.rm_transaction.transactionState);
    NSString *code = [NSString stringWithFormat:@"window._cordovaIos.storeOtherState('%@', '%ld', '%@')", notification.rm_transaction.transactionIdentifier,  (long)notification.rm_transaction.transactionState, notification.rm_productIdentifier];
    
    [self runCode:code];
}

-(void)runCode:(NSString *)code {
    [_webView evaluateJavaScript:code completionHandler:nil];
}

@end
