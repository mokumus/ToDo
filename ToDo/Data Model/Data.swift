//
//  Data.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 19.06.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object{
	@objc dynamic var name : String = ""
	@objc dynamic var age : Int = 0
}
