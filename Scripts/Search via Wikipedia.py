from Foundation import *
from AppKit import *

import webbrowser
import cgi

# app-defined main entry point
def main(textView):

	# get the selected string
	term = textView.string().substringWithRange_(textView.selectedRange()).strip()

	# if its invalid, explain to the user how to use this script, and go home early
	if '\n' in term or '\r' in term or len(term) == 0:
		info = 'To search wikipedia, highlight a phrase or word and choose this script again.'
		NSRunAlertPanel('Invalid Search Phrase', info, None, None, None)
		return

	# open the user's favorite browser at the search page
	url = 'http://www.google.com/search?q=' + cgi.escape(term) + '&as_sitesearch=wikipedia.org'
	webbrowser.open(url)
