//
//  InfoCollectiveTableViewCell.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 05/07/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import EventKit
//Gestion cellules des infocollectives.
class InfoCollectiveTableViewCell: UITableViewCell {
    
    var infoCo:InformationCollective!
    var userReservation: Bool! = false
    let store = EKEventStore()
    
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var lieuLbl: UILabel!
    @IBOutlet weak var etatInfoCo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //En fonction de ce que l'on récupere on change l'affichage complet ou non.
    func setupCell(_ infoCo: InformationCollective){
        self.infoCo = infoCo
        clipsToBounds = true
        descView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        descView.layer.cornerRadius = frame.height/20
        if infoCo.complet == 1 {
            descView.backgroundColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0.2666666667, alpha: 1)
            etatInfoCo.text = "Complet"
        }
        if userReservation {
            descView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            etatInfoCo.text = "Vous êtes inscrit à cette session \n"
            if infoCo.complet == 1 {
                etatInfoCo.text = "Vous êtes inscrit à cette session \n Complet"
                etatInfoCo.textColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
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
    
    @IBAction func addToCalendarBtn(_ sender: Any) {
        let date = Date(timeIntervalSince1970: TimeInterval(infoCo?.date ?? 0))
        if infoCo.complet == 0 {
            eventCalendar(with: "Information Collective à l'ADRAR", forDate:date , toDate: date)
        }
    }
}
