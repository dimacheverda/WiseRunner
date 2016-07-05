//
//  WorkoutCell.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 6/28/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
  
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var averageSpeedLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(with workout: Workout) {
    typeLabel.text = "Running"
    timeLabel.text = "\(workout.duration) secs"
    distanceLabel.text = "\(workout.distance) m"
    averageSpeedLabel.text = "average speed"
  }
  
}
