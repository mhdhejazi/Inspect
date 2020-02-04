//
//  ViewController.swift
//  Hardware Tester
//
//  Created by Mohammad on 1/28/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa
import Carbon
import Carbon.HIToolbox.Events

class ScreenController: NSViewController {
	private let colors: [NSColor] = [
		.red,
		.green,
		.blue,
		.white,
		.black,
		.yellow,
		.cyan,
		.magenta
	]
	private var currentColorIndex = -1
	private var currentColor: NSColor { colors[currentColorIndex] }
	private var eventMonitor: Any?

	deinit {
		if let monitor = eventMonitor {
			NSEvent.removeMonitor(monitor)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.wantsLayer = true

		eventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [unowned self] event in
			self.onKeyDown(with: event)
            return event
        }

		useNextColor()
	}

	override func viewWillAppear() {
		super.viewWillAppear()

		self.view.window?.toggleFullScreen(nil)
	}

	private func onKeyDown(with event: NSEvent) {
		super.keyUp(with: event)

		if let key = event.specialKey {
			switch key {
			case .leftArrow, .downArrow:
				usePreviousColor()

			case .rightArrow, .upArrow, .enter, .carriageReturn:
				useNextColor()

			default:
				break
			}
		}

		if event.keyCode == kVK_Space {
			useNextColor()
		}

		if event.keyCode == kVK_Escape {
			self.view.window?.performClose(nil)
		}
	}

	private func changeColor(indexChange: Int) {
		currentColorIndex = (currentColorIndex + indexChange + colors.count) % colors.count
		self.view.layer?.backgroundColor = currentColor.cgColor
	}

	private func useNextColor() {
		changeColor(indexChange: +1)
	}

	private func usePreviousColor() {
		changeColor(indexChange: -1)
	}
}
