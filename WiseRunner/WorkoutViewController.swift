//
//  WorkoutViewController.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 7/4/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import UIKit
import MapKit

class WorkoutViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var speedLabel: UILabel!
  
  var distance: CLLocationDistance = 0.0
  var seconds: Int = 0
  let locationManager = CLLocationManager()
  var locations: [CLLocation] = []
  var timer: NSTimer!
  
  var needToRecenterMapView = true
  
  // MARK: - ViewController Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLocationUpdates()
    setupTimer()
    setupMapView()
    
  }
  
  deinit {
    timer.invalidate()
  }
  
  // MARK: - Setup
  
  func setupMapView() {
    mapView.delegate = self
    mapView.mapType = .Standard
    mapView.showsUserLocation = true
  }

  func setupLocationUpdates() {
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.activityType = .Fitness
    locationManager.distanceFilter = 10
    locationManager.startUpdatingLocation()
  }
  
  func setupTimer() {
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                                                   target: self,
                                                   selector: #selector(WorkoutViewController.timerTick),
                                                   userInfo: nil,
                                                   repeats: true)
  }
  
  // MARK: - Actions
  
  @IBAction func endWorkoutButtonPressed(sender: AnyObject) {
    
  }
  
  @IBAction func recenterButtonPressed(sender: AnyObject) {
    needToRecenterMapView = true
  }
  
  func timerTick() {
    seconds += 1
    
    timeLabel.text = "\(seconds) seconds"
    distanceLabel.text = String(format: "%.1f meters", distance)
    if let lastLocation = locations.last {
      speedLabel.text = String(format: "%.1f mps", lastLocation.speed)
    }
  }
  
  private func centerMapView(at location: MKUserLocation) {
    let span = 0.005
    mapView.setRegion(MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(span, span)), animated: true)
  }
  
}

extension WorkoutViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("CLLocation's: \(locations)")
    
    for location in locations {
      if location.horizontalAccuracy < 20 {
        
        if self.locations.count > 0 {
          distance += self.locations.last!.distanceFromLocation(location)
          print("Distance: \(distance)")
        }
        
        self.locations.append(location)
      }
    }
  }
  
}

extension WorkoutViewController: MKMapViewDelegate {
  
  func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
    guard needToRecenterMapView == true else {
      return
    }
    
    centerMapView(at: userLocation)
    needToRecenterMapView = false
  }
  
}
