//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 10.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
	}

	//MARK - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as UITableViewCell
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	//MARK - Tableview Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		//print(itemArray[indexPath.row])
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		toggleCheckMark(cell: tableView.cellForRow(at: indexPath)!)
		

	}
	
	func toggleCheckMark(cell: UITableViewCell){
		if cell.accessoryType == .checkmark{
			cell.accessoryType = .none
		}
		else{
			cell.accessoryType = .checkmark
		}
	}

}

