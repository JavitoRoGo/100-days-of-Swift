//
//  ViewController.swift
//  Project22
//
//  Created by Javier Rodríguez Gómez on 19/11/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var firstLocation = false
    let circleDistance = UIView()

    @IBOutlet weak var distanceReading: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        circleDistance.layer.borderColor = UIColor.black.cgColor
        circleDistance.layer.borderWidth = 1
        view.addSubview(circleDistance)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            let scale: CGFloat
            switch distance {
            case .immediate:
                self.showAlert()
                self.view.backgroundColor = .green
                self.distanceReading.text = "RIGHT HERE"
                scale = 1
                self.circleDistance.frame.origin = CGPoint(x: 79, y: 320)
                self.circleDistance.layer.cornerRadius = 128 * scale
                self.circleDistance.frame.size = CGSize(width: (256 * scale), height: (256 * scale))
            case .near:
                self.showAlert()
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                scale = 0.5
                self.circleDistance.frame.origin = CGPoint(x: 143, y: 384)
                self.circleDistance.layer.cornerRadius = 128 * scale
                self.circleDistance.frame.size = CGSize(width: (256 * scale), height: (256 * scale))
            case .far:
                self.showAlert()
                self.view.backgroundColor = .red
                self.distanceReading.text = "FAR"
                scale = 0.25
                self.circleDistance.frame.origin = CGPoint(x: 175, y: 416)
                self.circleDistance.layer.cornerRadius = 128 * scale
                self.circleDistance.frame.size = CGSize(width: (256 * scale), height: (256 * scale))
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                scale = 0.001
                self.circleDistance.frame.origin = self.view.center
                self.circleDistance.layer.cornerRadius = 128 * scale
                self.circleDistance.frame.size = CGSize(width: (256 * scale), height: (256 * scale))
                self.firstLocation = false
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
    func showAlert() {
        if firstLocation == false {
            let ac = UIAlertController(title: "Your beacon has been detected!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
        }
        firstLocation = true
    }
}

