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
	fileWrapper = NSFileWrapper.alloc().initRegularFileWithContents_(data)
	fileWrapper.setFilename_('lolcat.jpg')
	fileWrapper.setPreferredFilename_('lolcat.jpg')
	textAttachment = NSTextAttachment.alloc().init()
	textAttachment.setFileWrapper_(fileWrapper)
	attrString = NSAttributedString.attributedStringWithAttachment_(textAttachment)

	# insert into text view at current insertion-point
	r = textView.selectedRange()
	textView.textStorage().replaceCharactersInRange_withAttributedString_(r, attrString)
