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
	private var textLabel: NSTextField!
	private var textLabelWidthConstraint: NSLayoutConstraint?
	private var textLabelHeightConstraint: NSLayoutConstraint?

	@IBInspectable var label: String? {
		didSet {
			textLabel.stringValue = label ?? "?"
		}
	}

	@IBInspectable var value: String?

	var keyValue: String? {
		guard let value = value else { return nil }
		if value.starts(with: "0x") {
			guard let number = Int(value.dropFirst(2), radix: 16),
				let scalar = Unicode.Scalar(number) else { return nil }
			return String(scalar)
		} else {
			return value.lowercased()
		}
	}

	var pressed: Bool = false { didSet { updateView() } }
	var clicked: Bool = false { didSet { updateView() } }
	var keyColor: NSColor {
		pressed ? NSColor(deviceRed: 0.15, green: 0.75, blue: 0.40, alpha: 1)
			: (clicked ? NSColor(deviceRed: 0.25, green: 0.50, blue: 0.85, alpha: 1) : NSColor.darkGray)
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
		self.layer?.backgroundColor = NSColor.darkGray.cgColor
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
		self.layer?.cornerRadius = 5
	}

	override func layout() {
		super.layout()

		let fontSizeFactor: CGFloat = (label?.count ?? 0 > 1) ? 0.25 : 0.4
		let fontSize = max(self.frame.height * fontSizeFactor, 13)
		textLabel.font = NSFont.systemFont(ofSize: fontSize, weight: .thin)
		textLabel.sizeToFit()

		if let constraint = textLabelWidthConstraint {
			constraint.constant = textLabel.frame.width
		} else {
			textLabelWidthConstraint = textLabel.widthAnchor.constraint(equalToConstant: textLabel.frame.width)
			textLabelWidthConstraint?.isActive = true
		}

		if let constraint = textLabelHeightConstraint {
			constraint.constant = textLabel.frame.height
		} else {
			textLabelHeightConstraint = textLabel.heightAnchor.constraint(equalToConstant: textLabel.frame.height)
			textLabelHeightConstraint?.isActive = true
		}
	}

	private func updateView() {
		self.layer?.backgroundColor = keyColor.cgColor
	}
}
