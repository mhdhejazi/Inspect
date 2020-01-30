//
//  KeyView.swift
//  Hardware Tester
//
//  Created by Mohammad on 1/29/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa

@IBDesignable
class KeyView: NSView {
	private static let defaultColor = NSColor.darkGray
	private static let pressedColor = NSColor(deviceRed: 0.15, green: 0.70, blue: 0.40, alpha: 1)
	private static let clickedColor1 = NSColor(deviceRed: 0.25, green: 0.50, blue: 0.80, alpha: 1)
	private static let clickedColor2 = NSColor(deviceRed: 0.15, green: 0.35, blue: 0.65, alpha: 1)

	private var textLabel: NSTextField!
	private var textLabelWidthConstraint: NSLayoutConstraint?
	private var textLabelHeightConstraint: NSLayoutConstraint?

	@IBInspectable var keyLabel: String? {
		didSet {
			textLabel.stringValue = keyLabel ?? "?"
		}
	}
	@IBInspectable var keyCode: Int = -1

	var modifierKey: ModifierKey? { ModifierKey(rawValue: keyCode) }
	var isModifierKey: Bool { modifierKey != nil }

	private(set) var clicked: Bool = false
	var pressed: Bool = false {
		didSet {
			clicked = true
			updateView()
		}
	}
	var keyColor: NSColor {
		if pressed { return Self.pressedColor }
		if clicked { return isModifierKey ? Self.clickedColor2 : Self.clickedColor1 }
		return Self.defaultColor
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		initializeView()
	}

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)

		initializeView()
	}

	private func initializeView() {
		self.wantsLayer = true
		self.layer?.backgroundColor = Self.defaultColor.cgColor
		self.layer?.cornerRadius = 5

		textLabel = NSTextField()
		textLabel.isEditable = false
		textLabel.isBezeled = false
		textLabel.drawsBackground = false
		textLabel.alignment = .center
		textLabel.textColor = NSColor.white
		self.addSubview(textLabel)

		textLabel.translatesAutoresizingMaskIntoConstraints = false
		textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
	}

	override func prepareForInterfaceBuilder() {
		self.layer?.backgroundColor = NSColor.darkGray.cgColor
		self.layer?.cornerRadius = 6
	}

	override func layout() {
		let fontSizeFactor: CGFloat = (keyLabel?.count ?? 0 > 1) ? 0.25 : 0.4
		let fontSize = max(self.frame.height * fontSizeFactor, 12)
		textLabel.font = NSFont.systemFont(ofSize: fontSize, weight: .thin)
		let labelSize = textLabel.sizeThatFits(.zero)

		if let constraint = textLabelWidthConstraint {
			constraint.constant = labelSize.width
		} else {
			textLabelWidthConstraint = textLabel.widthAnchor.constraint(equalToConstant: labelSize.width)
			textLabelWidthConstraint?.isActive = true
		}

		if let constraint = textLabelHeightConstraint {
			constraint.constant = labelSize.height
		} else {
			textLabelHeightConstraint = textLabel.heightAnchor.constraint(equalToConstant: labelSize.height)
			textLabelHeightConstraint?.isActive = true
		}

		super.layout()
	}

	private func updateView() {
		self.layer?.backgroundColor = keyColor.cgColor
	}
}

enum ModifierKey: Int {
	case capsLock = 57
	case shiftLeft = 56
	case shiftRight = 60
	case controlLeft = 59
	case optionLeft = 58
	case optionRight = 61
	case commandLeft = 55
	case commandRight = 54
	case function = 63

	var flag: NSEvent.ModifierFlags {
		switch self {
		case .capsLock: return .capsLock
		case .shiftLeft: return .shift
		case .shiftRight: return .shift
		case .controlLeft: return .control
		case .optionLeft: return .option
		case .optionRight: return .option
		case .commandLeft: return .command
		case .commandRight: return .command
		case .function: return .function
		}
	}
}
