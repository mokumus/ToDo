//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Muhammed Okumuş on 13.05.2018.
//  Copyright © 2018 Muhammed Okumuş. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableTableViewController {

	let realm = try! Realm()

	var categories: Results<Category>?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.rowHeight = 65.0
		
		loadCategories()
    }
	
	//MARK: - TableView Datasource Methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
		return cell
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories?.count ?? 1
	}
	
	//MARK: - TableView Delegete Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! TodoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categories?[indexPath.row]

		}
	}
	
	//MARK: - Model Manuplation Methods
	
	func save(category : Category){
		do{
			try realm.write {
				realm.add(category)
			}
		}catch{
			print("Error saving context \(error)")
		}
	}
	
	func loadCategories(){
		categories = realm.objects(Category.self)
		
		tableView.reloadData()
	}
	//Mark: - Delete Data From Swipe
	
	override func updateModel(at indexPath: IndexPath) {

		if let categoryToBeDeleted = self.categories?[indexPath.row]{
			do{
				try self.realm.write {
					self.realm.delete(categoryToBeDeleted)
					print("Category deleted")
				}
			}catch{
				print("Error when deleting  category, \(error)")
			}
		}
	}
	
	
	//MARK: - Add New Categories

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		
		var textField = UITextField()
		
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			
			// What will happen when addCategory is clicked on UIAlert
			if textField.text?.count != 0 {
				
				let newCategory = Category()
				newCategory.name = textField.text!
				
				//self.categories.append(newCategory)
				
				self.save(category : newCategory)
			}
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new category"
			textField = alertTextField
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}

