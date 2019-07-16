//
//  InfoCoTableViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 27/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
class InfoCoTableViewController: UITableViewController {

    var infoCollective: [InformationCollective] = []
    var cellId = "mainInfoCollective"
    let segueID = "detailInfoCo"
    var utilisateurReceived:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoCollective = catchInfoCo()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        stockUser()
    }
    //Recuperation des données présente dans le cache pour avoir les infocollectives
    private func catchInfoCo() -> [InformationCollective] {
        //récuperation
        let faqJsonAfterUD = UserDefaults.standard.string(forKey: "infosCos")
        //modification des données sous formes de bytes.
        if let result: Data = faqJsonAfterUD?.data(using: .utf8) {
            do {
                //récuperation d'un tableau d'infoCollectives
                return try JSONDecoder().decode([InformationCollective].self, from: result)
            } catch {
                print(error.localizedDescription)
            }
        }
        return []
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //nombre de cellules
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoCollective.count
    }
    //affichage des cellules.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let infoCo = infoCollective[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for: indexPath) as! InfoCollectiveTableViewCell
        cell.setupCell(infoCollective[indexPath.row])
        let timestamp = infoCo.date
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+1")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: date)
        cell.dateLbl.text = strDate
        cell.lieuLbl.text = "\(infoCo.centreDeFormation.ville)"
        if utilisateurReceived != nil {
            cell.userReservation = utilisateurReceived!.ID_infoCollective
        }
        return cell
    }

    //Animation vers le détails de l'infocollective pour l'infoCollective donnée.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoCo = infoCollective[indexPath.row]
        if infoCo.complet == 0 {
             performSegue(withIdentifier: segueID ,sender: infoCollective[indexPath.row])
        }
    }
    //envoie de l'infocollective sur laquelle on clique dans InfoCoDetailViewController ( dans lequel on récuperera les info)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let controller = segue.destination as? InfoCoDetailViewController{
                controller.infoCoRecue = sender as? InformationCollective
                if utilisateurReceived?.ID_infoCollective == controller.infoCoRecue?.id {
                    controller.stateInfoCoUtilisateur = 2
                } else if utilisateurReceived?.ID_infoCollective != nil {
                    controller.stateInfoCoUtilisateur = 1
                } else {
                    controller.stateInfoCoUtilisateur = 0
                }
            }
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Liste Informations Collectives"
        navigationItem.backBarButtonItem = backItem
    }
    
    private func stockUser(){
        if let userStringify  = UserDefaults.standard.string(forKey: "utilisateur"){
            let data = userStringify.data(using: .utf8)
            utilisateurReceived = try! JSONDecoder().decode(Utilisateur.self, from: data!)
        }
    }
}

