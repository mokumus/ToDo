//
//  SwipeTableTableViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 2.07.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit
import SwipeCellKit


class SwipeTableTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.backgroundColor = UIColor.white
		
		let gold = UIColor(displayP3Red: 1.0, green: CGFloat(215.0/255.0), blue: 0, alpha: 1.0)
		let orange = UIColor(displayP3Red: 1.0, green: CGFloat(165.0/255.0), blue: 0, alpha: 1.0)
		setTableViewBackgroundGradient(sender: self,gold,orange)
	}

	//TableView Data Source Methods
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
		cell.delegate = self
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }
		
		let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
			// handle action by updating model with deletion
			//print("Delete cell")
			self.updateModel(at: indexPath)
		}
		
		// customize the action appearance
		deleteAction.image = UIImage(named: "delete-icon")
		
		return [deleteAction]
	}
	
	
	func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
		var options = SwipeOptions()
		options.expansionStyle = .destructive
	
		return options
	}


	func updateModel(at indexPath: IndexPath){
		//Update our data model
	}
	
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.backgroundColor = UIColor.clear
	}
	
	func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
		
		let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
		let gradientLocations = [0.0,1.0]
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = gradientBackgroundColors
		gradientLayer.locations = gradientLocations as [NSNumber]
		
		gradientLayer.frame = sender.tableView.bounds
		let backgroundView = UIView(frame: sender.tableView.bounds)
		backgroundView.layer.insertSublayer(gradientLayer, at: 0)
		sender.tableView.backgroundView = backgroundView
	}
}
