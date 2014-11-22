//
//  AppDelegate.swift
//  ProgrammaticExample
//
//  Created by Anna Dickinson on 11/22/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let initialViewController = ProgrammaticViewController(nibName: "ProgrammaticViewController", bundle: nil)

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

