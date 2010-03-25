from Foundation import *
from AppKit import *

# app-defined main entry point
def main(textView):
	
	# get word count using AppKit's own functionality
	word_count = textView.textStorage().words().count()
	
	# run an alert panel showing the word count in a nice, formatted way
	words_str = 'There are %d words in this document' % word_count
	NSRunAlertPanel('Words in Document', words_str, None, None, None)
