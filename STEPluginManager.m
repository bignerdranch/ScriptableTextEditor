//
//  ATEPluginManager.m
//  AwesomeTextEditor
//
//  Created by Steven Degutis on 3/24/10.
//  Copyright 2010 Big Nerd Ranch, Inc. All rights reserved.
//

#import "STEPluginManager.h"

#import <Python/Python.h>


@interface NSObject (PythonPluginInterface)

- (BOOL) loadModuleAtPath:(NSString*)path
			 functionName:(NSString*)funcName
				arguments:(NSArray*)args;

@end



@implementation STEPluginManager

+ (STEPluginManager*) sharedManager {
	static dispatch_once_t pred;
	static STEPluginManager *sharedManager;
	dispatch_once(&pred, ^{
		sharedManager = [[STEPluginManager alloc] init];
	});
	return sharedManager;
}

- (BOOL) setupPythonEnvironment {
	// if deja-vu'ing, skip the rest
	if (Py_IsInitialized())
		return YES;
	
	// just in case /usr/bin/ is not in the user's path, although it should be
	Py_SetProgramName("/usr/bin/python");
	
	// set up the basic python environment.
	Py_Initialize();
	
	// get path to our python entrypoint
	NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"STEPluginExecutor" ofType:@"py"];
	
	// load the main script into the python runtime
	FILE *mainFile = fopen([scriptPath UTF8String], "r");
	return (PyRun_SimpleFileEx(mainFile, (char *)[[scriptPath lastPathComponent] UTF8String], 1) == 0);
}

// returns YES on success
- (BOOL) loadScriptAtPath:(NSString*)scriptPath runFunction:(NSString*)functionName withArguments:(NSArray*)arguments {
	Class STEPluginExecutor = NSClassFromString(@"STEPluginExecutor");
	id executor = [[[STEPluginExecutor alloc] init] autorelease];
	
	BOOL success = [executor loadModuleAtPath:scriptPath
								 functionName:functionName
									arguments:arguments];
	
	return success;
}

@end
