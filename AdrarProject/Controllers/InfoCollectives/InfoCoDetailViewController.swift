//
//  InfoCoDetailViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 05/07/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import MapKit
import EventKit
//Détail des infoco avec une MAP
class InfoCoDetailViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var boutonActionInfoCo: UIButton!
    @IBOutlet weak var mapInfoCo: MKMapView!
    @IBOutlet weak var containerDescInfoCo: UIView!
    @IBOutlet weak var dateDetailLbl: UILabel!
    @IBOutlet weak var adresseLbl: UILabel!
    @IBOutlet weak var villeLbl: UILabel!
    let store = EKEventStore()
    //3 etats: l'utilisateur n'est pas inscrit du tout(0), l'utilisateur est inscrit à une infoCo (qui n'est pas celle sur laquelle il a cliqué)  (1), l'utilisateur est inscrit à l'info co sur laquelle il a cliqué(2)
    var stateInfoCoUtilisateur:Int?
    var idSessionConnexion: String?
    var infoCoRecue: InformationCollective?
    var dateInfoCo:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let infoCo = infoCoRecue else { return }
        injectDate(infoCo)
        createAnnotation(infoCo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeInterfaceWithStateInfoCoWithUser()
    }
    
    //Date recuperer puis formatter afin d'injecter dans un Label
    func injectDate(_ infoCo:InformationCollective){
        idSessionConnexion = UserDefaults.standard.string(forKey: "idSession")
        let timestamp = infoCo.date
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+1")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm" //EEEE d MMMM yyyy HH' h 'mm
        dateInfoCo = dateFormatter.string(from: date)
        dateDetailLbl.text = dateInfoCo
        containerDescInfoCo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    //Création de l'Annotation qui doit être afficher pour le centre de Formation qui reçoit l'infoCo
    func createAnnotation(_ infoCo:InformationCollective){
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
   
    //En fonction de si l'utilisateur est sur son infoCo ou non pas le meme affichage
    func changeInterfaceWithStateInfoCoWithUser(){
        if stateInfoCoUtilisateur == 1 {
            boutonActionInfoCo.setTitleColor(.orange, for: .normal)
            boutonActionInfoCo.setTitle("Modification de votre inscription à votre information collective par celle du \(dateInfoCo)", for: .normal)
        } else if stateInfoCoUtilisateur == 2 {
            calendarButton.isHidden = false
            boutonActionInfoCo.setTitleColor(.red, for: .normal)
            boutonActionInfoCo.setTitle("Suppression de l'inscription à l'Information Collective", for: .normal)
        }
    }
    
    // Gestion de la carte
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
    //Requete pour l'inscription ou la supression à une infoCO
    @IBAction func inscriptionInfoCo(_ sender: Any) {
        if infoCoRecue != nil && idSessionConnexion != nil{
            if stateInfoCoUtilisateur == 2 {
                UtilisateurAPIHelper().deleteInfoCo(idSessionCo: self.idSessionConnexion!) { (utilisateur, erreur) in
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
    
    func eventCalendar(with title:String, forDate eventStartDate:Date, toDate eventEndDate:Date) {
        store.requestAccess(to: .event) { (succes, error) in
            if error == nil {
                let event = EKEvent.init(eventStore: self.store)
                event.title = title
                event.calendar = self.store.defaultCalendarForNewEvents
                event.startDate = eventStartDate
                event.endDate = eventEndDate
                
                let alarm = EKAlarm.init(absoluteDate: Date.init(timeInterval: -3600, since: event.startDate))
                event.addAlarm(alarm)
                
                do{
                    try self.store.save(event, span: .thisEvent)
                    
                } catch let error as NSError {
                    print("Impossible de sauvegarder à cause de l'erreur :\(error)")
                }
            } else {
                print("Erreur = \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func calendarBtn(_ sender: Any) {
        let date = Date(timeIntervalSince1970: TimeInterval(infoCoRecue?.date ?? 0))
        if infoCoRecue?.complet == 0 {
            eventCalendar(with: "Information Collective à l'ADRAR", forDate:date , toDate: date)
            showToast(message: "Evenement rajouté dans votre calendrier", font: .systemFont(ofSize: 12))
        }
    }
}
