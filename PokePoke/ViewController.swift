//
//  ViewController.swift
//  PokePoke
//
//  Created by Luis Lopez on 8/8/17.
//  Copyright © 2017 Luis Lopez. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("Ready for ya")
            mapView.showsUserLocation = true

        } else {     manager.requestWhenInUseAuthorization()

            
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

