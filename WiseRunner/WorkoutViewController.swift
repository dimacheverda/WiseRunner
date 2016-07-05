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
  
  var workoutSession = WorkoutSession()
  var timer: NSTimer!
  
  var needToRecenterMapView = true
  
  // MARK: - ViewController Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    startWorkoutSession()
    setupTimer()
    setupMapView()
    
  }
  
  // MARK: - Setup
  
  func setupMapView() {
    mapView.delegate = self
    mapView.mapType = .Standard
    mapView.showsUserLocation = true
  }

  func startWorkoutSession() {
    workoutSession.startWorkout()
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
    workoutSession.endWorkout()
    timer.invalidate()
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func recenterButtonPressed(sender: AnyObject) {
    needToRecenterMapView = true
  }
  
  func timerTick() {
    workoutSession.duration += 1
    
    timeLabel.text = "\(workoutSession.duration) seconds"
    distanceLabel.text = String(format: "%.1f meters", workoutSession.distance)
    if let lastLocation = workoutSession.locations.last {
      speedLabel.text = String(format: "%.1f mps", lastLocation.speed)
    }
  }
  
  // MARK: - Private
  
  private func centerMapView(at location: MKUserLocation) {
    let span = 0.005
    mapView.setRegion(MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(span, span)), animated: true)
  }

  private func polyline(for locations: [CLLocation]) -> MKPolyline {
    var coordinates: [CLLocationCoordinate2D] = []
    
    for location in locations {
      coordinates.append(location.coordinate)
    }
    
    return MKPolyline(coordinates: &coordinates, count: coordinates.count)
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
  
  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    
    if let polyline = overlay as? MKPolyline {
      let polylineRenderer = MKPolylineRenderer(overlay: polyline)
      polylineRenderer.strokeColor = UIColor.blueColor()
      polylineRenderer.lineWidth = 3
      
      return polylineRenderer
    }
  
    let renderer = MKOverlayRenderer(overlay: overlay)
    
    return renderer
  }
  
}
