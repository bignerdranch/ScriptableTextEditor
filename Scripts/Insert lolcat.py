from Foundation import *
from AppKit import *

import urllib2

# app-defined main entry point
def main(textView):
	
	url = 'http://icanhascheezburger.files.wordpress.com/2010/02/funny-pictures-cat-is-very-comfortable.jpg'
	
	# get data
	raw_str = urllib2.urlopen(url).read()
	data = NSData.dataWithBytes_length_(raw_str, len(raw_str))
	
	# turn into a text attachment
	fw = NSFileWrapper.alloc().initRegularFileWithContents_(data)
	fw.setFilename_('lolcat.jpg')
	fw.setPreferredFilename_('lolcat.jpg')
	ta = NSTextAttachment.alloc().init()
	ta.setFileWrapper_(fw)
	ats = NSAttributedString.attributedStringWithAttachment_(ta)
	
	# insert into text view at current insertion-point
	range = textView.selectedRange()
	textView.textStorage().replaceCharactersInRange_withAttributedString_(range, ats)
