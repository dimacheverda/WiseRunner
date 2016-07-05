//
//  WorkoutType.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 6/28/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import Foundation

enum WorkoutType: Int {
  case Bicycle = 0, Running, Swimming, Jogging
  
  static var count: Int {
    return WorkoutType.Jogging.hashValue + 1
  }
  
  private static let types = ["Bicycle", "Running", "Swimming", "Jogging"]
  
  static func typeString(atIndex index: Int) -> String {
    return types[index]
  }
  
  static func stringIndex(for string: String) -> Int {
    if let index = types.indexOf(string) {
      return index
    }

    return 0
  }
  
}
