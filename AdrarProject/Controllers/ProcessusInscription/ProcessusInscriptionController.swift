//
//  ProcessusInscriptionController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 05/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit


class ProcessusInscriptionController: UIViewController {
    //Outlet
    @IBOutlet weak var SituationLbl: UILabel!
    @IBOutlet weak var DescriptionProcess: UITextView!
    @IBOutlet weak var MoreInformation: UIView!
    @IBOutlet weak var ButtonToinscrire: RoundButton!
    @IBOutlet weak var ContactInfoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // Sur le SegmentedControl un va rajouter un switch pour le nombre de possibilité de celui-ci, qui changera la valeur de zone de texte et cachera/montrera le button/contact.
    @IBAction func SegmentedSituation(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: SituationLbl.text = "Salarié"
        DescriptionProcess.text = "Se former tout au long de la vie est devenu aujourd’hui une nécessité pour chaque salarié souhaitant développer ses compétences, se perfectionner, acquérir de nouveaux savoirs, valider une expérience, ou favoriser une évolution professionnelle. Modules courts ou formations longues diplômantes, un Conseiller formation ADRAR vous accompagne dans votre projet de formation, en définissant le parcours le plus adapté. Pour répondre à vos besoins individuels de formation, plusieurs modes de financement s’offrent à vous."
        ButtonToinscrire.isHidden = true
        ContactInfoLbl.isHidden = false
            
        
            
        case 1: SituationLbl.text = "Demandeur d'Emploi"
        DescriptionProcess.text = "Que ce soit pour retrouver un emploi, obtenir un premier emploi, développer vos compétences, obtenir un titre, un diplôme, anticiper les changements ou changer de métier… la formation est essentielle dans une vie professionnelle. Plusieurs dispositifs existent, soit dans le cadre de dispositifs de formation financés, soit en contrat de travail proposant un accès à la formation. Que vous soyez demandeur d’emploi indemnisé ou non, de nombreux dispositifs de formation peuvent vous être financés et le cas échéant rémunérés par la Région, Pôle emploi ou l’Etat."
        ButtonToinscrire.isHidden = false
        ContactInfoLbl.isHidden = true
            
        default: break
        }
        
    }
    
    //Action pour revenir en arriere
    @IBAction func backMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

