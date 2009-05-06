//
//  pbstuff.mm
//
//  Created by Allan Odgaard on 2005-10-11.
//  Copyright (c) 2005 MacroMates. All rights reserved.
//

// Compile instructions:
//   g++ -Os -Wall -arch ppc -arch i386 -funsigned-char -o ~/bin/pbcopy -framework AppKit pbstuff.mm
//   ln -s pbcopy ~/bin/pbpaste # create symbolic link for pbpaste

#import <AppKit/AppKit.h>
#import <libgen.h>
#import <algorithm>
#import <string>

int main (int argc, char const* argv[])
{
	NSAutoreleasePool* pool = [NSAutoreleasePool new];
	if(strcmp("pbcopy", basename(strdup(argv[0]))) == 0)
	{
		std::string str;
		char buf[1024];
		while(size_t len = read(STDIN_FILENO, buf, sizeof(buf)))
			std::copy(buf, buf + len, back_inserter(str));

		NSPasteboard* pboard = [NSPasteboard generalPasteboard];
		[pboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
		[pboard setString:[NSString stringWithUTF8String:str.c_str()] forType:NSStringPboardType];
	}
	else
	{
		NSPasteboard* pboard = [NSPasteboard generalPasteboard];
		NSString* type = [pboard availableTypeFromArray:[NSArray arrayWithObject:NSStringPboardType]];
		NSString* str = [type isEqual:NSStringPboardType] ? [pboard stringForType:type] : @"";

		char const* cStr = [str UTF8String];
		write(STDOUT_FILENO, cStr, strlen(cStr));
	}
	[pool release];
	return 0;
}
