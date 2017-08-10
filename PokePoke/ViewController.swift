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
    
    var updateCount = 0
    
    var manager = CLLocationManager()
    
    var pokemons : [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = getAllPokemon()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("Ready for ya")
            mapView.showsUserLocation = true
            
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                // spawn a pokemon
               
                if let coord = self.manager.location?.coordinate{
                    let anno = MKPointAnnotation()
                    anno.coordinate = coord
                    let randoLat = (Double(arc4random_uniform(200)) - 100.0) / 500000.0
                    
                    let randoLon = (Double(arc4random_uniform(200)) - 100.0) / 500000.0
                    anno.coordinate.latitude += randoLat
                    anno.coordinate.latitude += randoLon
                    self.mapView.addAnnotation(anno)
                }
            })

        } else {     manager.requestWhenInUseAuthorization()

            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]){
            
            if updateCount < 3 {
            
            
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            
                self.mapView.setRegion(region, animated: false)
                updateCount += 1} else {
                manager.stopUpdatingLocation()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func centerTapped(_ sender: Any) {
        
        if let coord = manager.location?.coordinate{
        let region = MKCoordinateRegionMakeWithDistance(coord, 200, 200)
        
        self.mapView.setRegion(region, animated: true)
        }
    }

}

