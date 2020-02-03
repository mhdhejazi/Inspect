//
//  ViewController.swift
//  Hardware Tester
//
//  Created by Mohammad on 1/28/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa
import Carbon

class KeyboardController: NSViewController {
	@IBOutlet var stackExtra: NSStackView!

	private var eventMonitor: Any?

	deinit {
		if let monitor = eventMonitor {
			NSEvent.removeMonitor(monitor)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		eventMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp, .flagsChanged]) { [unowned self] event in
            self.onKeyDown(with: event)
            return event
        }
	}

	private func onKeyDown(with event: NSEvent) {
		var keyViews = allKeyViews().filter({ $0.keyCode == event.keyCode })
		if keyViews.isEmpty {
			let keyView = addKeyView(for: event)
			keyViews.append(keyView)
		}

		keyViews.forEach { keyView in
			if event.type == .flagsChanged, let flag = keyView.key.modifierFlag {
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

	private func addKeyView(for event: NSEvent) -> KeyView {
		let keyView = KeyView(frame: .zero)
		keyView.keyLabel = Key(code: Int(event.keyCode)).name ?? event.charactersIgnoringModifiers
		keyView.keyCode = Int(event.keyCode)
		stackExtra.addView(keyView, in: .leading)
		stackExtra.isHidden = false

		keyView.widthAnchor.constraint(lessThanOrEqualTo: keyView.heightAnchor).isActive = true
		if stackExtra.arrangedSubviews.count > 1 {
			let firstKeyView = stackExtra.arrangedSubviews[0]
			keyView.widthAnchor.constraint(equalTo: firstKeyView.widthAnchor).isActive = true
		}

		keyView.needsLayout = true

		return keyView
	}
}
