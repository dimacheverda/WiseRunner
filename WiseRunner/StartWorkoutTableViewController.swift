//
//  StartWorkoutTableViewController.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 6/28/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import UIKit

class StartWorkoutTableViewController: UITableViewController {
  
  // MARK: - ViewController Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Setup
  
  func setupTableView() {
    let nibName = String(WorkoutTypeCell)
    let nib = UINib(nibName: nibName, bundle: nil)
    self.tableView.registerNib(nib, forCellReuseIdentifier: nibName)
  }
  
  // MARK: - Actions
  
  @IBAction func startWorkoutButtonPressed(sender: AnyObject) {
    self.performSegueWithIdentifier("Start Workout", sender: self);
  }
  
}

// MARK: - Table view data source

extension StartWorkoutTableViewController {
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return WorkoutType.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(String(WorkoutTypeCell), forIndexPath: indexPath) as! WorkoutTypeCell
    
    cell.typeLabel.text = WorkoutType.typeString(atIndex: indexPath.row)
    
    return cell
  }

}

// MARK: - Table view delegate

extension StartWorkoutTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    for cell in tableView.visibleCells {
      cell.accessoryType = .None
    }
    
    let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
    selectedCell?.accessoryType = (selectedCell?.accessoryType == .Checkmark)
      ? .None
      : .Checkmark
  }
  
}
