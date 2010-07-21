//
//  LWETXAuthViewProtocol.h
//  jFlash
//
//  Created by Rendy Pranata on 21/07/10.
//  Copyright 2010 CRUX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWETwitterOAuth;

// RENDY: please define this protocol.  What does it do??
@protocol LWETXAuthViewProtocol

- (void)setAuthEngine:(LWETwitterOAuth *)authEngine;
- (void)didFailAuthentication:(NSError *)error;

@end
