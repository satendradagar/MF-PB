//
//  MPDeviceConfigurationViewController.m
//  MedFolio Pillbox Setup
//
//  Created by Satendra Personal on 30/11/14.
//  Copyright (c) 2014 CoreBits Software Solutions Pvt. Ltd(corebitss.com). All rights reserved.
//

#import "MPDeviceConfigurationViewController.h"

@interface MPDeviceConfigurationViewController ()

@property (weak) IBOutlet NSTextField *connectivityMessage;
@property (weak) IBOutlet NSTextField *pipeReadWriteError;
@property (weak) IBOutlet NSTextField *pipeReadWriteMessage;
@property (weak) IBOutlet NSTextField *setupMessages;

@end

@implementation MPDeviceConfigurationViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    MPDeviceCommunication *deviceComm = [MPDeviceCommunication sharedInstance];

    deviceComm.deviceProductId = 11894;
    deviceComm.deviceVendorId = 8888;//Motorola
//    deviceComm.deviceProductId = 5131;
//    deviceComm.deviceVendorId = 4817;//Huawei
//
//    deviceComm.deviceProductId = 4779;
//    deviceComm.deviceVendorId = 1452;//Apple
//    deviceComm.deviceProductId = 12;
//    deviceComm.deviceVendorId = 1240;//PillBox
//
    [MPDeviceCommunication sharedInstance].deviceCommunicationDelegate = self;
    // Do view setup here.
}

- (void)deviceDidReceiveDebugMessage:(NSString *)message
{
    self.setupMessages.stringValue = message;
}

- (void)deviceDidFailSetup:(NSError *)error
{
    self.connectivityMessage.stringValue = [error domain];
    self.connectivityMessage.textColor = [NSColor blueColor];

}

- (void)deviceDidConnected
{
    self.connectivityMessage.stringValue = @"Device Connected";
    self.connectivityMessage.textColor = [NSColor greenColor];

}

- (void)deviceDidDisconnected
{
    self.connectivityMessage.stringValue = @"Device disconnected";
    self.connectivityMessage.textColor = [NSColor redColor];
}

- (void)deviceCommunicationDidFailedWriteMessage:(NSError *)error
{
    self.pipeReadWriteError.stringValue = [error domain];
}

- (void)deviceCommunicationDidFailedReadMessage:(NSError *)error
{
    self.pipeReadWriteError.stringValue = [error domain];

}

- (void)deviceCommunicationDidWriteMessage:(NSString *)message
{
    self.pipeReadWriteMessage.stringValue = message;

}

- (void)deviceCommunicationdidReadMessage:(NSString *)message
{
    self.pipeReadWriteMessage.stringValue = message;

}

- (IBAction)didTappedConnect:(id)sender {
    [[MPDeviceCommunication sharedInstance] setupDevice];
}

- (IBAction)didTappedSendMsg:(id)sender {
    [[MPDeviceCommunication sharedInstance] writeMessage:@"$$$"];
}

- (IBAction)didTappedReadMessage:(id)sender {
    [[MPDeviceCommunication sharedInstance] readMessage];
}
@end
