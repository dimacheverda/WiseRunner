//
//  WorkoutHistoryTableViewController.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 6/28/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import UIKit

class WorkoutHistoryTableViewController: UITableViewController {
  
  private let startWorkoutSegueIdentifier = "Start Workout"
  
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
    let nibName = String(WorkoutCell)
    let nib = UINib(nibName: nibName, bundle: nil)
    self.tableView.registerNib(nib, forCellReuseIdentifier: nibName)
  }
  
  // MARK: - Actions
  
  @IBAction func startWorkoutButtonPressed(sender: AnyObject) {
    presentAlertViewController()
  }
  
  private func presentAlertViewController() {
    let alertVC = UIAlertController(title: "Choose workout type", message: nil, preferredStyle: .ActionSheet)
    
    for type in 0..<WorkoutType.count {
      let action = UIAlertAction(title: WorkoutType.typeString(atIndex: type), style: .Default, handler: { (action) in
        self.alertActionHandler(action)
      })
      
      alertVC.addAction(action)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    alertVC.addAction(cancelAction)
    
    presentViewController(alertVC, animated: true, completion: nil)
  }
  
  private func alertActionHandler(action: UIAlertAction) {
    self.performSegueWithIdentifier(startWorkoutSegueIdentifier, sender: self);
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == startWorkoutSegueIdentifier {
      
    }
  }
}

// MARK: - Table view data source

extension WorkoutHistoryTableViewController {
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(String(WorkoutCell), forIndexPath: indexPath) as! WorkoutCell
    
    return cell
  }

}

// MARK: - Table view delegate

extension WorkoutHistoryTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
  }
  
}
