//
//  Extensions.swift
//  Inspect
//
//  Created by Mohammad on 2/4/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa

class DynamicColor {
	let lightModeColor: NSColor
	let darkModeColor: NSColor

	var color: NSColor {
		if #available(OSX 10.14, *), NSApp.effectiveAppearance.name == .darkAqua {
			return darkModeColor
		}

		return lightModeColor
	}

	init(lightModeColor: NSColor, darkModeColor: NSColor) {
		self.lightModeColor = lightModeColor
		self.darkModeColor = darkModeColor
	}
}
