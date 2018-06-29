//
//  AppDelegate.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 10.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		do{
			_ = try Realm()
		}catch{
			print("Error initializing the Realm \(error)")
		}
		
		return true
	}
}
