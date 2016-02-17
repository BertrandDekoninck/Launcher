#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
// #include <stdio.h>
// #include <stdlib.h>

#import "launcher.h"


int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool;
  pool = [NSAutoreleasePool new];
  [NSApplication sharedApplication];

  [NSApp setDelegate: [MyDelegate new]];

  if (argc == 2)
    {
      NSString *app_name = [NSString stringWithUTF8String: argv[1]];
      [MyDelegate  setPath: app_name];
    }

  [MyDelegate dealloc];
  [pool drain];

  return NSApplicationMain (argc, argv);
}
