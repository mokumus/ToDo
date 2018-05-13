//
//  Item.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 13.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import Foundation

class Item: Codable{
	var title : String = ""
	var done : Bool = false
	
	init(title : String){
		self.title = title
	}
	
	func setTitle(title : String){
		self.title = title
	}
	
	func setDone(done : Bool){
		self.done = done
	}
}
