//
//  Swiper.swift
//  ToDo-Realm
//
//  Created by C. Jordan Ball III on 8/16/21.
//

import UIKit
import SwipeCellKit


class Swiper: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    //Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell;
                
        cell.delegate = self;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil };
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.updateModel(at: indexPath);
            
            print("Delete Cell");

        }
        
        deleteAction.image = UIImage(named: "delete-icon");
        print("Swipe Me!");
        return [deleteAction];
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions();
        options.expansionStyle = .destructive;
        return options;
    }
    
    func updateModel(at indexPath: IndexPath) {
        print("Update Me");
    }
}
