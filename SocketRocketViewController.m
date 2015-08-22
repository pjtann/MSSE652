//
//  SocketRocketViewController.m
//  msse652
//
//  Created by PT on 8/18/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "SocketRocketViewController.h"
//#import <SocketRocket/SRWebSocket.h>
#import "SRWebSocket.h"
//#import <QuartzCore/QuartzCore.h>





@interface SocketRocketViewController() <SRWebSocketDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *sendMessageActionButton;
@property (nonatomic, weak) IBOutlet UIButton *closeConnectionActionButton;

@end

@implementation SocketRocketViewController

SRWebSocket *_webSocket;



-(void) viewDidLoad{
    
    [super viewDidLoad];

}

-(void) viewDidAppear:(BOOL)animated{
    
    _scrollView.contentSize=CGSizeMake(282,328);

}


-(void) createConnection{
    //_webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.regisscis.net:8080"]]];
    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://echo.websocket.org/"]]];
    
    //_webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:9000/chat"]]];
    
    //_webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/opiate/SimpleWebSocketServer:8080"]]];
    
    //_webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://github.com:8080/opiate/SimpleWebSocketServer"]]];
    
    _webSocket.delegate = self;
    
    //self.title = @"Opening socket connection...";
    self.rocketStatusLabel.text = @"Opening socket connection...";
    [_webSocket open];
    
}

-(void) webSocketDidOpen: (SRWebSocket *) webSocket{
    
    NSLog(@"WebSocket Connected");
    //self.title = @"Connected!";
    self.rocketStatusLabel.text = @"Connection Is Open";
    self.sendRocketMessageTextField.hidden = NO;
}

-(void) webSocket:(SRWebSocket *) webSocket didFailWithError:(NSError *) error{
    NSLog(@"WebSocket FAILED with error: %@", error);
    //self.title = @"Connection Failed!";
    self.rocketStatusLabel.text = @"Connection Failed!";
    webSocket = nil;
    
}

-(void)webSocket:(SRWebSocket *) webSocket didReceiveMessage:(id)message{
    NSString *msg = (NSString *) message;
    
    //NSLog(@"Recieved msg: %@", message);
    NSLog(@"\n \t Msg value from recieve method; used to set text view: \n \t %@", msg);
    
    // TO DO - display the message to teh user
    
    NSString *displayMsg = (NSString *) displayMsg;
    displayMsg = @"The Return Message is: \n";
    
    displayMsg = [displayMsg stringByAppendingString: msg];
    
    
    self.recieveRocketMessageTextView.text = displayMsg;
    self.rocketStatusLabel.text = @"Message Recieved";
    self.recieveRocketMessageTextView.hidden = NO;
}

-(void) webSocket:(SRWebSocket *) webSocket didCloseWithCode:(NSInteger)code reason:(NSString *) reason wasClean:(BOOL)wasClean{
    NSLog(@"WebSocket closed");
    //self.title = @"Connection Closed";
    webSocket = nil;
    self.rocketStatusLabel.text = @"Connection Is Closed";
    
}

-(void) sendMessage: (NSString *) message{
    [_webSocket send:message];
    self.rocketStatusLabel.text = @"Sending Message";
    self.sendRocketMessageTextField.text = nil;
   
    
}

-(void) disconnect{
    [_webSocket close];
    _webSocket = nil;
    
}

- (IBAction)openConnectionActionButton:(id)sender {
    [self createConnection];    
    
}

- (IBAction)sendMessageActionButton:(id)sender {
    
    [self sendMessage:_sendRocketMessageTextField.text];
}
- (IBAction)closeConnectionActionButton:(id)sender {
    [self disconnect];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}



@end
