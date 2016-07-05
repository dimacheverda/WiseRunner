//
//  Workout.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 7/5/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import Foundation
import RealmSwift

class Workout: Object {
  
  dynamic var startDate = NSDate()
  dynamic var distance = 0.0
  dynamic var duration = 0
  dynamic var type = 0
  let locations = List<Location>()
  
}
