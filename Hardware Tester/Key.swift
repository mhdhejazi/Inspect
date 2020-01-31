//
//  Key.swift
//  Hardware Tester
//
//  Created by Mohammad on 1/31/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa
import Carbon.HIToolbox.Events

class Key {
	let code: Int

	init(code: Int) {
		self.code = code
	}

	var isModifier: Bool {
		switch code {
		case kVK_CapsLock: return true
		case kVK_Shift, kVK_RightShift: return true
		case kVK_Control, kVK_RightControl: return true
		case kVK_Option, kVK_RightOption: return true
		case kVK_Command, kVK_RightCommand: return true
		case kVK_Function: return true
		case kVK_Help: return true
		default: return false
		}
	}

	var modifierFlag: NSEvent.ModifierFlags? {
		switch code {
		case kVK_CapsLock: return .capsLock
		case kVK_Shift, kVK_RightShift: return .shift
		case kVK_Control, kVK_RightControl: return .control
		case kVK_Option, kVK_RightOption: return .option
		case kVK_Command, kVK_RightCommand: return .command
		case kVK_Function: return .function
		case kVK_Help: return .help
		default: return nil
		}
	}

	var name: String? {
		switch code {
		case kVK_ANSI_KeypadClear: return "⌧"
		case kVK_ANSI_KeypadEnter: return "⌤"
		case kVK_CapsLock: return "⇪"
		case kVK_Command: return "⌘"
		case kVK_Control: return "⌃"
		case kVK_Option: return "⌥"
		case kVK_Shift: return "⇧"
		case kVK_RightCommand: return "⌘"
		case kVK_RightControl: return "⌃"
		case kVK_RightOption: return "⌥"
		case kVK_RightShift: return "⇧"
		case kVK_Delete: return "⌫"
		case kVK_ForwardDelete: return "⌦"
		case kVK_Escape: return "esc"
		case kVK_Function: return "fn"
		case kVK_Help: return "help"
		case kVK_PageUp: return "↑"
		case kVK_PageDown: return "↓"
		case kVK_Home: return "home"
		case kVK_End: return "end"
		case kVK_Mute: return "mute"
		case kVK_Return: return "⏎"
		case kVK_LeftArrow: return "◀︎"
		case kVK_RightArrow: return "▶︎"
		case kVK_UpArrow: return "▲"
		case kVK_DownArrow: return "▼"
		case kVK_Space: return "␣"
		case kVK_Tab: return "⇥"
		case kVK_VolumeDown: return "vol-"
		case kVK_VolumeUp: return "vol+"
		case kVK_F1: return "F1"
		case kVK_F2: return "F2"
		case kVK_F3: return "F3"
		case kVK_F4: return "F4"
		case kVK_F5: return "F5"
		case kVK_F6: return "F6"
		case kVK_F7: return "F7"
		case kVK_F8: return "F8"
		case kVK_F9: return "F9"
		case kVK_F10: return "F10"
		case kVK_F11: return "F11"
		case kVK_F12: return "F12"
		case kVK_F13: return "F13"
		case kVK_F14: return "F14"
		case kVK_F15: return "F15"
		case kVK_F16: return "F16"
		case kVK_F17: return "F17"
		case kVK_F18: return "F18"
		case kVK_F19: return "F19"
		case kVK_F20: return "F20"
		default: return nil
		}
	}
}
