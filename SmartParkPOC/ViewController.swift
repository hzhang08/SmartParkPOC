//
//  ViewController.swift
//  SmartParkPOC
//
//  Created by Change to ur account when u use on 8/27/15.
//  Copyright (c) 2015 com.hong. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView : GMSMapView?
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView!.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions(0x01), context: nil)
        // Do any additional setup after loading the view, typically from a nib.
        
//        var camera = GMSCameraPosition.cameraWithLatitude(37.5483, longitude: -121.9886, zoom: 16)
//        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera);
//        mapView.myLocationEnabled = true
        
//        var myLocation = mapView.myLocation
//        var myLocationCoordinates = myLocation.coordinate
//        var myLocationCamera = GMSCameraPosition.cameraWithTarget(myLocationCoordinates, zoom: 16)
//        
//        mapView.camera = myLocationCamera
        
        //self.view = mapView
        
//        var marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(37.5483, -121.9886)
//        marker.title = "Fremont"
//        marker.snippet = "California"
//        marker.map = mapView
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func click(sender : UIResponder?)
    {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        locationManager!.requestAlwaysAuthorization()
        
        locationManager!.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if( status != CLAuthorizationStatus.NotDetermined )
        {
            dispatch_async(dispatch_get_main_queue()){
                self.enableMyLocation()
                
                self.locationManager!.delegate = nil
                self.locationManager = nil
            }
        }
        
    }
    
    func enableMyLocation(){
        
        var status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedAlways
        {
            mapView!.myLocationEnabled = true
            mapView!.setNeedsDisplay()
        }
        
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "myLocation" && object.isKindOfClass(GMSMapView)
        {
            self.mapView!.animateToCameraPosition(GMSCameraPosition.cameraWithTarget(self.mapView!.myLocation.coordinate, zoom: 16))
        }
        
    }
}

