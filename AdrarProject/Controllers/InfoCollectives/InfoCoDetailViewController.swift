//
//  InfoCoDetailViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 05/07/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import MapKit
//Détail des infoco avec une MAP
class InfoCoDetailViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapInfoCo: MKMapView!
    @IBOutlet weak var containerDescInfoCo: UIView!
    @IBOutlet weak var dateDetailLbl: UILabel!
    @IBOutlet weak var adresseLbl: UILabel!
    @IBOutlet weak var villeLbl: UILabel!
    
    var infoCoRecue: InformationCollective?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let infoCo = infoCoRecue else { return }
        
        let timestamp = infoCo.date
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+1")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: date)
        
        dateDetailLbl.text = "\(strDate)"
        adresseLbl.text = "\(infoCo.centreDeFormation.numeroVoie) \(infoCo.centreDeFormation.adresse)\(infoCo.centreDeFormation.complementAdresse ?? "")"
        villeLbl.text = "\(infoCo.centreDeFormation.cp) \(infoCo.centreDeFormation.ville)"
        containerDescInfoCo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        if let latitudeAnnotation = Double(infoCo.centreDeFormation.coordoneeX!), let longitudeAnnotation = Double(infoCo.centreDeFormation.coordoneeY!){
            mapInfoCo.delegate = self
            let locationBase = CLLocation(latitude: latitudeAnnotation, longitude: longitudeAnnotation)
            let meters: CLLocationDistance = 5000
            let coordinRegion = MKCoordinateRegion(center: locationBase.coordinate, latitudinalMeters: meters, longitudinalMeters: meters)
            self.mapInfoCo.setRegion(coordinRegion, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeAnnotation, longitude:longitudeAnnotation)
            annotation.title = "\(infoCo.centreDeFormation.cp) \(infoCo.centreDeFormation.ville)"
            annotation.subtitle = "\(infoCo.centreDeFormation.numeroVoie) \(infoCo.centreDeFormation.adresse)\(infoCo.centreDeFormation.complementAdresse ?? "")"
            
            mapInfoCo.addAnnotation(annotation)
        }else {
            mapInfoCo.isHidden = true
        }
    }
    
    // a voir
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let annotationImage = UIImage(named: "adrar")
        annotationView!.image = annotationImage
        annotationView!.frame.size = CGSize(width: 25, height: 30)
        
        return annotationView
    }

}
