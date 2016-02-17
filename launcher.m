#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>

#import "launcher.h"


@implementation MyDelegate 
NSTask* task;
BOOL isRunning;
NSString* app_name;

-(id) init
{
 
  task=nil;
  isRunning=NO;
  app_name=nil;
  self = [super init];
  return self;
}

- (void) dealloc
{
   [super dealloc];
}


+(void) setPath: (NSString*) path
{
  app_name = [[NSString alloc] initWithString: path];
}

- (void)createTask: (NSString*) app_name
{
  if (app_name == nil)
    {
      NSLog(@"createTask : pas de chemin d'éxécutable");
    }
  else if (isRunning == NO)
    {
      task = [[NSTask alloc] init];
      task.launchPath= app_name;
      [task launch];
      isRunning = YES;
    }
  else if (isRunning == YES)
    {
      NSRunAlertPanel(@"Error", @"Program already launched", @"Close panel", @"",@"");
    }
}

- (void) launchApp: (id)sender
{
  [self createTask: app_name];
};

- (void) terminateApp: (id)sender
{
  if ([task isRunning])
    {
      [task terminate];
      isRunning=NO;
      [task release];
    }
}

//- (void) terminateLauncher: (id) sender
//{
// terminateApp: sender;
//  [super terminate: sender];
//}

-(void) createMenu
{
  // Create menus and submenus
  NSMenu *menu;
  menu = AUTORELEASE ([NSMenu new]);
  NSMenuItem *menuItem;
  [menu addItemWithTitle: @"Launch app"
		  action: @selector (launchApp:) 
	   keyEquivalent: @"t"];

  [menu addItemWithTitle: @"Quit app"
		  action: @selector (terminateApp:) 
	   keyEquivalent: @"w"];

  
  [menu addItemWithTitle: @"Quitter"
		  action: @selector (terminate:)
    	   keyEquivalent:@"q"];

  // Submenu Info
  NSMenu *infoMenu;
  infoMenu = AUTORELEASE ([NSMenu new]);

  [infoMenu addItemWithTitle: @"A propos..."
  		      action: @selector (orderFrontStandardInfoPanel:)
  	       keyEquivalent: @"i"];

  [infoMenu addItemWithTitle: @"Aide..."
  		      action: @selector (orderFrontHelpPanel:)
  	       keyEquivalent:@"?"];
  
  menuItem = [menu addItemWithTitle: @"Informations"
  			     action:NULL
  		      keyEquivalent: @""];

  [menu setSubmenu: infoMenu forItem:menuItem];
   

  [NSApp setMainMenu: menu];
}


- (void) applicationWillFinishLaunching:(NSNotification *)not

{
  [self createMenu];
  [self createTask: app_name];
}

- (void) applicationDidFinishLaunching: (NSNotification *)not
{
 
}
@end


