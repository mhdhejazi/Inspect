//
//  AppDelegate.swift
//  Hardware Tester
//
//  Created by Mohammad on 1/28/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import Cocoa

import FirebaseCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions" : true])
		FirebaseApp.configure()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		true
	}
}

