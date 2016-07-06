//
//  WorkoutHistoryTableViewController.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 6/28/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import UIKit
import RealmSwift

class WorkoutHistoryTableViewController: UITableViewController {
  
  private let startWorkoutSegueIdentifier = "Start Workout"
  private let showInfoSegueIdentifier = "Show Info"
  
  private let rowHeight: CGFloat = 125.0
  private var selectedWorkoutType = WorkoutType.Bicycle
  private var selectedWorkout: Workout?
  
  var workouts: Results<Workout>?
  
  // MARK: - ViewController Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    
    fetchWorkout()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Setup
  
  private func setupTableView() {
    let nibName = String(WorkoutCell)
    let nib = UINib(nibName: nibName, bundle: nil)
    tableView.registerNib(nib, forCellReuseIdentifier: nibName)
    tableView.rowHeight = rowHeight
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
    self.performSegueWithIdentifier(startWorkoutSegueIdentifier, sender: self)
    
    if let title = action.title {
      self.selectedWorkoutType = WorkoutType(rawValue: WorkoutType.stringIndex(for: title))!
    }
  }
  
  // MARK: - Navigations
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier != nil else {
      return
    }
    
    switch segue.identifier! {
    case startWorkoutSegueIdentifier:
      let navVC = segue.destinationViewController as! UINavigationController
      let destVC = navVC.viewControllers.first as! WorkoutViewController
      destVC.type = selectedWorkoutType
    case showInfoSegueIdentifier:
      let destVC = segue.destinationViewController as! WorkoutInfoViewController
      destVC.workout = selectedWorkout
    default:
      print("Unknown segue identifier")
    }
  }
  
  // MARK: - Private
  
  private func fetchWorkout() {
    do {
      workouts = try Realm().objects(Workout.self)
    } catch {
      print("Something went wrong during fetching from Realm")
    }
  }
  
}

// MARK: - Table view data source

extension WorkoutHistoryTableViewController {
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if workouts != nil {
      return workouts!.count
    }
    
    return 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(String(WorkoutCell), forIndexPath: indexPath) as! WorkoutCell
    
    if let workout = workouts?[indexPath.row] {
      cell.configure(with: workout)
    }
    
    return cell
  }

}

// MARK: - Table view delegate

extension WorkoutHistoryTableViewController {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let workout = workouts?[indexPath.row] {
      selectedWorkout = workout
      performSegueWithIdentifier(showInfoSegueIdentifier, sender: self)
    }
  }
  
}
