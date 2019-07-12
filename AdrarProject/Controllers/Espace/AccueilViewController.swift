//
//  AccueilViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
//Espace accessible uniquement après authentification ( connexion/inscription )
class AccueilViewController: UIViewController {

    // Etapes, rajouter lien pour le processus d'inscription.
    var userReceived:Utilisateur?
    let etapeInfoPerso = "Suite à votre inscription vous pouvez maintenant suivre notre processus de recrutement. Veuillez ajouter vos informations personnelles"
    let etapeDoc = "Vous avez bien rempli vos informations personnelles. Veuillez ajouter vos documents."
    let etapeValidDoc = "Vous avez bien rempli vos informations personnelles. En attente de validation par notre équipe"
    let etapeInfoCo = "Votre dossier a bien été validé. Vous pouvez vous inscrire à une information collective"
    let etapeRappelInfoCo = "Votre inscription a bien été prise en compte. Vous êtes inscrit à la session de :" // + infoCoDate
    let etapeFinal = "Merci d'avoir utilisé Adrar Connect"
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var descTextProgression: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        changeTextAndProgressView()
    }
    //En fonction de l'avancement inscription on change la progressBar et le texte.
    private func changeTextAndProgressView(){
        switch  userReceived?.ID_avancementInscription{
        case 1:
            descTextProgression.text = etapeInfoPerso
            progressView.progress = 0.1
        case 2:
            descTextProgression.text = etapeDoc
            progressView.progress = 0.3
        case 3:
            descTextProgression.text = etapeValidDoc
            progressView.progress = 0.5
        case 4:
            descTextProgression.text = etapeInfoCo
            progressView.progress = 0.7
        case 5:
            descTextProgression.text = etapeRappelInfoCo
            progressView.progress = 0.9
        default:
            return
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
