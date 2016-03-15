//
//  ViewController.m
//  SafariChallenge
//
//  Created by dp on 3/15/16.
//  Copyright © 2016 Dan Park. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *variablewebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestWithString:@"http://www.google.com"];
}

- (void)loadRequestWithString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.variablewebView loadRequest:request];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadRequestWithString:textField.text];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
    self.backButton.enabled = self.variablewebView.canGoBack;

}

- (IBAction)onBackButtonPressed:(id)sender {
    if ([_variablewebView canGoBack]) {
        [_variablewebView goBack];
    }
}

- (IBAction)onForwardButtonPressed:(id)sender {
    if ([_variablewebView canGoForward]) {
        [_variablewebView goForward];
    }
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [_variablewebView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [_variablewebView reload];
}

@end
