//
//  ViewController.swift
//  ToDo-UserDefaults
//
//  Created by C. Jordan Ball III on 8/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Balance Checkbook", "Pay Bills", "File Taxes"];

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
    
    
}

