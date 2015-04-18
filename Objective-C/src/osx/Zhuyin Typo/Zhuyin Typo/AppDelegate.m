//
//  AppDelegate.m
//  Zhuyin Typo
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zhi-Wei Cai.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow      *w;
@property (weak) IBOutlet NSTextField   *i;
@property (weak) IBOutlet NSTextField   *o;
@property (weak) IBOutlet NSTextField   *r;
@end

@implementation AppDelegate

#pragma mark - System

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    // Shut down the application when the main window closed.
    return YES;
}

#pragma mark - Core

- (NSString *)toZhuyin {
    NSDictionary *t = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"ㄅ", @"1", @"ㄆ", @"Q", @"ㄇ", @"A", @"ㄈ", @"Z",
                       @"ㄉ", @"2", @"ㄊ", @"W", @"ㄋ", @"S", @"ㄌ", @"X",
                       @"ㄍ", @"E", @"ㄎ", @"D", @"ㄏ", @"C", @"ㄐ", @"R",
                       @"ㄑ", @"F", @"ㄒ", @"V", @"ㄓ", @"5", @"ㄔ", @"T",
                       @"ㄕ", @"G", @"ㄖ", @"B", @"ㄗ", @"Y", @"ㄘ", @"H",
                       @"ㄙ", @"N", @"ㄧ", @"U", @"ㄨ", @"J", @"ㄩ", @"M",
                       @"ㄚ", @"8", @"ㄛ", @"I", @"ㄜ", @"K", @"ㄝ", @",",
                       @"ㄞ", @"9", @"ㄟ", @"O", @"ㄠ", @"L", @"ㄡ", @".",
                       @"ㄢ", @"0", @"ㄣ", @"P", @"ㄤ", @";", @"ㄥ", @"/",
                       @"ㄦ", @"-", @"˙", @"7", @"ˊ", @"6", @"ˇ", @"3",
                       @"ˋ", @"4", nil];
    
    NSString *i = [_i.stringValue uppercaseString];
    NSString *o = @"";
    NSString *r = @"";
    
    for (NSUInteger j = 0; j < [i length]; j++) {
        NSString *c = [i substringWithRange:NSMakeRange(j, 1)];
        o = [o stringByAppendingString:(r = [t objectForKey:c]) ? r : c];
    }
    
    return o;
}

- (int)keyCode:(unichar)s {
    
    if (s == 'a')	return 0;
    if (s == 's')	return 1;
    if (s == 'd')	return 2;
    if (s == 'f')	return 3;
    if (s == 'h')	return 4;
    if (s == 'g')	return 5;
    if (s == 'z')	return 6;
    if (s == 'x')	return 7;
    if (s == 'c')	return 8;
    if (s == 'v')	return 9;
    if (s == 'b')	return 11;
    if (s == 'q')	return 12;
    if (s == 'w')	return 13;
    if (s == 'e')	return 14;
    if (s == 'r')	return 15;
    if (s == 'y')	return 16;
    if (s == 't')	return 17;
    if (s == '1')	return 18;
    if (s == '2')	return 19;
    if (s == '3')	return 20;
    if (s == '4')	return 21;
    if (s == '6')	return 22;
    if (s == '5')	return 23;
    if (s == '=')	return 24;
    if (s == '9')	return 25;
    if (s == '7')	return 26;
    if (s == '-')	return 27;
    if (s == '8')	return 28;
    if (s == '0')	return 29;
    if (s == ']')	return 30;
    if (s == 'o')	return 31;
    if (s == 'u')	return 32;
    if (s == '[')	return 33;
    if (s == 'i')	return 34;
    if (s == 'p')	return 35;
    if (s == '\r')	return 36;
    if (s == 'l')	return 37;
    if (s == 'j')	return 38;
    if (s == '\'')	return 39;
    if (s == 'k')	return 40;
    if (s == ';')	return 41;
    if (s == '\\')	return 42;
    if (s == ',')	return 43;
    if (s == '/')	return 44;
    if (s == 'n')	return 45;
    if (s == 'm')	return 46;
    if (s == '.')	return 47;
    if (s == ' ')	return 49;
    
    return -1;
}

#pragma mark - IBAction

- (IBAction)proc:(id)sender {
    [_o setStringValue:[self toZhuyin]];
}

- (IBAction)type:(id)sender {
    NSAlert *alert  = [[NSAlert alloc] init];
    [alert setAlertStyle:NSCriticalAlertStyle];
    [alert addButtonWithTitle:@"朕知道了"];
    [alert setMessageText:@"請確定現在的輸入法為注音，且大寫鎖為解除的狀態！"];
    [alert beginSheetModalForWindow:self.w completionHandler:^(NSModalResponse returnCode) {
        [_r setStringValue:@""];
        [_r becomeFirstResponder];
        NSString *i = _i.stringValue;
        for (NSUInteger j = 0; j < [i length]; j++) {
            CGEventRef e = CGEventCreateKeyboardEvent(NULL, [self keyCode:[i characterAtIndex:j]], true);
            CGEventPost(kCGSessionEventTap, e);
            CFRelease(e);
        }
    }];
}

@end
