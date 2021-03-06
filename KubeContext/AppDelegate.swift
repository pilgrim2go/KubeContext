//
//  AppDelegate.swift
//  KubeContext
//
//  Created by Turken, Hasan on 04.10.18.
//  Copyright © 2018 Turken, Hasan. All rights reserved.
//

import Cocoa
import Yams

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
    let menuManager = MenuManager()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("kubernetes-icon"))
            //button.imagePosition = NSControl.ImagePosition.imageLeft
            //button.title = "PROD"
            //button.imageHugsTitle = false
            //button.contentTintColor = NSColor.red
            //button.action = #selector(constructMenu(_:))
        }
        
        let menu = NSMenu()
        menu.delegate = menuManager
        statusItem.menu = menu
        
        if CommandLine.arguments.contains("--uitesting") {
            prepareForTesting()
        }
    }
    
    func prepareForTesting(){
        print ("UI Testing Mode")
        bookmarksFile = "TestBookmarks.dict"
        uiTesting = true
        let fileManager = FileManager.default
        
        var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        url = url.appendingPathComponent(bookmarksFile)
        
        if fileManager.isReadableFile(atPath: url.path) {
            try? fileManager.removeItem(at: url)
        }
        let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let tempDataUrl = documentDirectory!.appendingPathComponent("TempData")
        
        testFileAsConfig = tempDataUrl.appendingPathComponent("ui-test-config.yaml")
        testFileToImport = tempDataUrl.appendingPathComponent("file-to-import.yaml")
    }
}
