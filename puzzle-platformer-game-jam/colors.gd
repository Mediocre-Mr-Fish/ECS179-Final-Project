class_name Colors
extends Node

enum FilterColors {
	GREEN,
	RED,
	BLUE,
}

var colorDict = {
	"GREEN":Color(0.549, 0.918, 0.412, 1.0),
	"RED":Color(0.953, 0.243, 0.435, 1.0),
	"BLUE":Color(0.0, 0.455, 0.882, 1.0),
}

func getColorFromEnum(colorEnum:FilterColors)->Color:
	var colorAsString = FilterColors.keys()[colorEnum]
	return colorDict[colorAsString]
