//
//  ViewController.swift
//  Todoey
//
//  Created by Shravani on 24/06/18.
//  Copyright © 2018 Shravani. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray : [String] = []
    
    //using user default to save the coredata of the app
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrieving the data after the app loads
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
        }
    }

   
    
    //MARK - Tableview Datasource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        // sets the items in array in the text property of cell
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
     //MARK - Tableview Delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      // to remove the grey selection that appears after selection the cell
         tableView.deselectRow(at: indexPath, animated: true)
      
     
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        // to add checkmarks to the cells
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
        }
        else{
            cell?.accessoryType = .checkmark
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        var textField = UITextField()
        
        // created a new alert
        let alert = UIAlertController.init(title: "Add new item", message: " ", preferredStyle: .alert )
        
        // added alert action
        let alertAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
            
            self.itemArray.append(textField.text!)
            
            //setting the itemarray in userdefaults
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()

        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        
        // calling the add new item alertaction
        alert.addAction(alertAction)
      
        
        // added new textfield on the alert
        alert.addTextField { (newItem) in
            
        // setting placeholder for the textfiled
        newItem.placeholder = "Create new item"
            
        // assigned the value of newitem textfield to the textfield varialble created under this function, to access the local newitem variable
            textField = newItem
            
        }
        present(alert, animated: true, completion: nil)
    }

    

}

