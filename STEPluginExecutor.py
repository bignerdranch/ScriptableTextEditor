#
#  main.py
#  AwesomeTextEditor
#
#  Created by Steven Degutis on 3/24/10.
#  Copyright (c) 2010 Big Nerd Ranch, Inc. All rights reserved.
#

from Foundation import *
from AppKit import *

import imp

class STEPluginExecutor(NSObject):
	@classmethod
	def loadModuleAtPath_functionName_arguments_(self, path, func, args):
		
		f = open(path)
		try:
			mod = imp.load_module('plugin', f, path, (".py", "r", imp.PY_SOURCE))
			realfunc = getattr(mod, func, None)
			if realfunc is not None:
				realfunc(*tuple(args))
		except Exception as e:
			NSRunAlertPanel('Script Error', '%s' % e, None, None, None)
		finally:
			f.close()
			return NO
		
		return YES
