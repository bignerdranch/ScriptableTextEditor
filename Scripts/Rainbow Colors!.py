from Foundation import *
from AppKit import *

import random


# app-defined main entry point
def main(textView):
	
	# get some pretty looking colors
	colors = getColors()
	
	# force the text view to use rich text
	textView.setRichText_(YES)
	
	# set the text color for the entire contents
	attr_name = NSForegroundColorAttributeName
	
	for i in xrange(textView.string().length()):
		color = random.choice(colors)
		range = NSMakeRange(i, 1)
		textView.textStorage().addAttribute_value_range_(attr_name, color, range)


def getColors():
	colors = None
	
	color_list = NSColorList.colorListNamed_('Crayons')
	
	if color_list is None:
		color_list = NSColorList.colorListNamed_('Apple')
	
	if color_list is None:
		color_list = NSColorList.availableColorLists().lastObject()
	
	if color_list is None:
		color_names = ['red', 'orange', 'blue', 'green', 'purple', 'yellow']
		colors = [getattr(NSColor, color_name + 'Color', None)() for color_name in color_names]
	else:
		colors = [color_list.colorWithKey_(color_key) for color_key in color_list.allKeys()]
	
	return colors
