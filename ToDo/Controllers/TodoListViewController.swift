//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 10.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

	var itemArray = [Item]()
	var selectedCategory : Category?{
		didSet{
			loadItems()//loads all items
		}
	}
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	//MARK: - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as UITableViewCell
	
		let item = itemArray[indexPath.row]
		
		cell.textLabel?.text = item.title
		
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	//MARK: - Tableview Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		//print(itemArray[indexPath.row])
		//itemArray[indexPath.row].setValue("Completed", forKey: "title")
		//context.delete(itemArray[indexPath.row])
		//itemArray.remove(at: indexPath.row)
		
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		tableView.reloadData()
		saveItems()
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK: - Add New Items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
	
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		var textField = UITextField()
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			// What will happen when addItem is clicked on UIAlert
			if textField.text?.count != 0 {
				
				let newItem = Item(context: self.context)
				newItem.title = textField.text!
				newItem.done = false
				newItem.parentCategory = self.selectedCategory
				
				self.itemArray.append(newItem)
				self.saveItems()
			}
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: - Model Manuplation Methods
	func saveItems(){
		do{
			try context.save()
		}catch{
			print("Error saving context \(error)")
		}
	}
	
	func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
		
		let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
		
		if let additionalPredicate = predicate {
			request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
		}else{
			request.predicate = categoryPredicate
		}

	
		do{
			itemArray = try context.fetch(request)
		} catch{
			print("Error fetching data from context \(error)")
		}
	
		tableView.reloadData()
	}
}

//MARK: - Search Bar Methods
extension TodoListViewController: UISearchBarDelegate{
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let request : NSFetchRequest<Item> = Item.fetchRequest()
		
		let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
		request.predicate = predicate
		
		let sortDescriptr = NSSortDescriptor(key: "title", ascending: true)
		request.sortDescriptors = [sortDescriptr]
		
		loadItems(with: request,predicate: predicate) //loads searched items
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text?.count == 0{
			loadItems()
			
			DispatchQueue.main.async {
				searchBar.resignFirstResponder() //dismisses keyboard
			}
		}
	}
}

