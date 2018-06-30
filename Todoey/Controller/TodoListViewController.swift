//
//  ViewController.swift
//  Todoey
//
//  Created by Shravani on 24/06/18.
//  Copyright © 2018 Shravani. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    //creating the object context from AppDelgate class
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
         var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
//        Solution to Issue no.2 by Parag
        AppDelegate.abc = 1
      loadItems()

    }
    
    //MARK - Tableview Datasource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //intsead of using itemArray[indexPath.row] everytime we are substituting it with 'item' variable
        let item = itemArray[indexPath.row]
        
        // sets the items in array in the text property of cell
        cell.textLabel?.text = item.title
        
        //setting accesoryType as checked if done property is true and viceversa using ternary operator
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    //MARK - Tableview Delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // to remove the grey selection that appears after selection the cell
        tableView.deselectRow(at: indexPath, animated: true)
        
        //to check and uncheck the cell
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setEditing(true, animated: true)
        
        
        //calling the save method after checking and unchecking the items
        saveItems()
        
        tableView.reloadData()
    }
    
    // MARK - delete item
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            saveItems()
            tableView.reloadData()
        }
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        
        var textField = UITextField()
        // created a new alert
        let alert = UIAlertController.init(title: "Add new item", message: " ", preferredStyle: .alert )
        // added alert action
        let alertAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
            
            // Creating a new object of Item class
            let newItem = Item(context: self.context)
            
            // assigning the texfield's value to the newItem object's title property
            newItem.title = textField.text!
            newItem.done = false
            
            //apending the newItem object to the array
            self.itemArray.append(newItem)
            
            //Calling saveItem function
            self.saveItems()
            
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        
        // calling the add new item alertaction
        alert.addAction(alertAction)
        
        
        // added new textfield on the alert
        alert.addTextField { (alertTextField) in
            
            // setting placeholder for the textfiled
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Saving data
    
    func saveItems(){
        do {
            try context.save()
            tableView.reloadData()
        }
        catch {
            print("error in while \(error)")
        }
    }
    
    // Retrieving data
    
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
         itemArray =   try context.fetch(request)
        }
        catch{
            print("Error while fetching data \(error)")
        }
  }
    
}

