//
//  StringHelpers.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 7/6/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import Foundation

extension String {
  static func fromSeconds(seconds: Int) -> String {
    let minutes = seconds / 60
    let seconds = seconds % 60

    return String(format: "%dm %ds", minutes, seconds)
  }
}
