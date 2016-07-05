//
//  Location.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 7/5/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
  
  dynamic var latitude = 0.0
  dynamic var longitude = 0.0
  dynamic var timestamp = NSDate()
  dynamic var speed = 0.0
  
}
