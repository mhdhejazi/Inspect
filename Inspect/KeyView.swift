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
	private static let defaultColor = DynamicColor(
		lightModeColor: NSColor(deviceWhite: 0.82, alpha: 1),
		darkModeColor: NSColor(deviceWhite: 0.33, alpha: 1)
	)
	private static let pressedColor = DynamicColor(
		lightModeColor: NSColor(deviceHue: 0.4, saturation: 0.55, brightness: 0.88, alpha: 1),
		darkModeColor: NSColor(deviceHue: 0.4, saturation: 0.78, brightness: 0.7, alpha: 1)
	)
	private static let clickedColor1 = DynamicColor(
		lightModeColor: NSColor(deviceHue: 0.59, saturation: 0.4, brightness: 0.95, alpha: 1),
		darkModeColor: NSColor(deviceHue: 0.59, saturation: 0.68, brightness: 0.8, alpha: 1)
	)
	private static let clickedColor2 = DynamicColor(
		lightModeColor: NSColor(deviceHue: 0.6, saturation: 0.45, brightness: 0.9, alpha: 1),
		darkModeColor: NSColor(deviceHue: 0.6, saturation: 0.77, brightness: 0.65, alpha: 1)
	)
	private static let textColor = DynamicColor(
		lightModeColor: NSColor(deviceWhite: 0, alpha: 0.75),
		darkModeColor: NSColor(deviceWhite: 1, alpha: 0.75)
	)

	private var textLabel: NSTextField!
	private var textLabelWidthConstraint: NSLayoutConstraint?
	private var textLabelHeightConstraint: NSLayoutConstraint?

	@IBInspectable var keyLabel: String? {
		didSet {
			textLabel.stringValue = keyLabel ?? "<?>"
		}
	}
	@IBInspectable var keyCode: Int = -1

	var key: Key { Key(code: keyCode) }

	private(set) var clicked: Bool = false
	var pressed: Bool = false {
		didSet {
			clicked = true
			updateView()
		}
	}
	var keyColor: NSColor {
		if pressed { return Self.pressedColor.color }
		if clicked { return key.isModifier ? Self.clickedColor2.color : Self.clickedColor1.color }
		return Self.defaultColor.color
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
		self.layer?.backgroundColor = Self.defaultColor.color.cgColor
		self.layer?.cornerRadius = 5

		textLabel = NSTextField()
		textLabel.isEditable = false
		textLabel.isBezeled = false
		textLabel.drawsBackground = false
		textLabel.alignment = .center
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
		let fontSizeFactor: CGFloat = (keyLabel?.count ?? 0 > 1) ? 0.25 : 0.35
		let fontSize = max(self.frame.height * fontSizeFactor, 12)
		textLabel.font = NSFont.systemFont(ofSize: fontSize, weight: .light)
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
		textLabel.textColor = Self.textColor.color
	}
}
