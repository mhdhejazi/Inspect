//
//  ViewController.swift
//  Hardware Tester
//
//  Created by Mohammad on 1/28/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp, .flagsChanged]) { event in
            self.onKeyDown(with: event)
            return event
        }
	}

	private func onKeyDown(with event: NSEvent) {
		if event.type == .flagsChanged {
			updateKeyView(for: String(event.keyCode), event: event)
		} else {
			updateKeyView(for: event.charactersIgnoringModifiers, event: event)
		}
	}

	private func updateKeyView(for keyValue: String?, event: NSEvent) {
		guard let keyValue = keyValue else { return }
		allKeyViews(rootView: view).filter({ $0.keyValue == keyValue.lowercased() }).forEach {
			$0.clicked = true
			$0.pressed = (event.type == .keyDown)
		}
		event.modifierFlags
	}

	private func allKeyViews(rootView: NSView) -> [KeyView] {
		var result = [KeyView]()
		rootView.subviews.forEach { subview in
			if let keyView = subview as? KeyView {
				result.append(keyView)
			} else {
				result.append(contentsOf: allKeyViews(rootView: subview))
			}
		}
		return result
	}
}
