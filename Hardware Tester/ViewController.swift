//
//  ViewController.swift
//  Hardware Tester
//
//  Created by Mohammad on 1/28/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa
import Carbon

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp, .flagsChanged]) { event in
            self.onKeyDown(with: event)
            return event
        }
	}

	private func onKeyDown(with event: NSEvent) {
		allKeyViews().filter({ $0.keyCode == event.keyCode }).forEach { keyView in
			if event.type == .flagsChanged, let flag = keyView.modifierKey?.flag {
				keyView.pressed = event.modifierFlags.contains(flag)
			} else {
				keyView.pressed = (event.type == .keyDown)
			}
		}
	}

	private func allKeyViews(rootView: NSView? = nil) -> [KeyView] {
		var result = [KeyView]()
		(rootView ?? view).subviews.forEach { subview in
			if let keyView = subview as? KeyView {
				result.append(keyView)
			} else {
				result.append(contentsOf: allKeyViews(rootView: subview))
			}
		}
		return result
	}
}
