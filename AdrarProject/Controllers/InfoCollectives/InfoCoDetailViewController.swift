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

    
    @IBOutlet weak var boutonActionInfoCo: UIButton!
    @IBOutlet weak var mapInfoCo: MKMapView!
    @IBOutlet weak var containerDescInfoCo: UIView!
    @IBOutlet weak var dateDetailLbl: UILabel!
    @IBOutlet weak var adresseLbl: UILabel!
    @IBOutlet weak var villeLbl: UILabel!
    //3 etats: l'utilisateur n'est pas inscrit du tout(0) , l'utilisateur est inscrit à l'info co sur laquelle il a cliqué(2), l'utilisateur est inscrit à une infoCo ( qui n'est pas celle sur laquelle il a cliqué)  (1)
    var stateInfoCoUtilisateur:Int?
    var idSessionConnexion: String?
    var infoCoRecue: InformationCollective?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let infoCo = infoCoRecue else { return }
        
        idSessionConnexion = UserDefaults.standard.string(forKey: "idSession")
        let timestamp = infoCo.date
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+1")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: date)
        
        dateDetailLbl.text = "\(strDate)"
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
    
    override func viewWillAppear(_ animated: Bool) {
        changeInterfaceWithStateInfoCoWithUser()
    }
    func changeInterfaceWithStateInfoCoWithUser(){
        if stateInfoCoUtilisateur == 1 {
            boutonActionInfoCo.setTitleColor(.orange, for: .normal)
            boutonActionInfoCo.setTitle("Modification de l'inscription du pour celle du ", for: .normal)
        } else if stateInfoCoUtilisateur == 2 {
            boutonActionInfoCo.setTitleColor(.red, for: .normal)
            boutonActionInfoCo.setTitle("Suppression de l'inscription l'Information Collective du ", for: .normal)
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
    @IBAction func inscriptionInfoCo(_ sender: Any) {
        if infoCoRecue != nil && idSessionConnexion != nil{
            if stateInfoCoUtilisateur == 2 {
                print("rentre compl")
                UtilisateurAPIHelper().deleteInfoCo(idSessionCo: self.idSessionConnexion!) { (utilisateur, erreur) in
                    if erreur != nil {
                        print("erreur")
                        print(erreur!)
                    }
                    if utilisateur != nil {
                        print("utilisateur")
//                        let utilisateurBytes = try! JSONEncoder().encode(utilisateur)
//                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
//                        UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
                    }
                }
                dismiss(animated: true, completion: nil)
            }else{
                UtilisateurAPIHelper().updateInfoCo(idInfoCo: self.infoCoRecue!.id,idSessionCo: self.idSessionConnexion!){ (utilisateur, erreur) in
                    if erreur != nil {
                        print(erreur!)
                    }
                    if utilisateur != nil {
                        let utilisateurBytes = try! JSONEncoder().encode(utilisateur)
                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
                        UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
                    }
                }
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
