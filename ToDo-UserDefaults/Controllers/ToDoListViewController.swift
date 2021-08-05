//
//  ViewController.swift
//  ToDo-UserDefaults
//
//  Created by C. Jordan Ball III on 8/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Balance Checkbook", "Pay Bills", "File Taxes"];

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath);
        cell.textLabel?.text = itemArray[indexPath.row];
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        tableView.cellForRow(at: indexPath)?.accessoryType =
            tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark;
    };
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "ADD IT", message: "This is what we should add", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens on clicke of button
            if let myVar = alert.textFields![0].text {
                if myVar != "" {
                    self.itemArray.append(myVar);
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item";
        }
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil);
    }
    
}

