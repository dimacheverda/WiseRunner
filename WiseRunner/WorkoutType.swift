//
//  WorkoutType.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 6/28/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import Foundation

enum WorkoutType: Int {
  case Bicycle = 1, Running, Swimming, Jogging
  
  static var count: Int {
    return WorkoutType.Jogging.hashValue + 1
  }
  
  static func typeString(atIndex index: Int) -> String {
    return ["Bicycle", "Running", "Swimming", "Jogging"][index]
  }
  
}
