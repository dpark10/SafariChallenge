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
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.variablewebView.scrollView.delegate = self;
    self.urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self loadRequestWithString:@"http://www.google.com"];
}

- (void)loadRequestWithString:(NSString *)string {
    if ([string hasPrefix:@"http://"]) {
        NSURL *url = [NSURL URLWithString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.variablewebView loadRequest:request];
        self.urlTextField.text = string;
    }
    else
    {
        NSString *stringWithPrefix = [@"http://" stringByAppendingString:string];
        NSURL *url = [NSURL URLWithString:stringWithPrefix];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.variablewebView loadRequest:request];
        self.urlTextField.text = stringWithPrefix;
    }
    
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
    self.forwardButton.enabled = self.variablewebView.canGoForward;
    NSString *pageTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationController.navigationBar.topItem.title = pageTitle;

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
    [self.spinner stopAnimating];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [_variablewebView reload];
}
- (IBAction)onPlusButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Features"
                                                                   message:@"Coming Soon!"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y <= 0.0){
        [self.urlTextField setBackgroundColor:[UIColor whiteColor]];
        [self.urlTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [self.urlTextField setTextColor:[UIColor blackColor]];
    } else {
        [self.urlTextField setBackgroundColor:[UIColor clearColor]];
        [self.urlTextField setBorderStyle:UITextBorderStyleNone];
        [self.urlTextField setTextColor:[UIColor clearColor]];

    }

}

@end
