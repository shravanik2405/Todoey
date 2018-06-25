//
//  ViewController.swift
//  Todoey
//
//  Created by Shravani on 24/06/18.
//  Copyright © 2018 Shravani. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    let itemArray = ["First cell","Two cell","Three cell"]

    
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
       //  print(itemArray[indexPath.row])
        
      // to remove the grey selection that appears after selection the cell
         tableView.deselectRow(at: indexPath, animated: true)
      
     // to add checkmarks to the cells
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
        }
        else{
            cell?.accessoryType = .checkmark
        }
    }

}

