from Foundation import *
from AppKit import *

# app-defined main entry point
def main(textView):
	
	# get the text lines as a list
	lines = textView.textStorage().string().split('\n')
	
	# sort by alphabetical order
	lines.sort()
	
	# re-set the text contents to the newly arranged list
	new_string = '\n'.join(lines)
	textView.textStorage().mutableString().setString_(new_string)
