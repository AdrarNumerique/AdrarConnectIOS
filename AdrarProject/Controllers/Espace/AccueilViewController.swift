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
    let etapeInfoPerso = "Suite à votre inscription vous pouvez maintenant suivre notre processus de recrutement. Veuillez ajouter vos informations personnelles."
    let etapeDoc = "Vous avez bien rempli vos informations personnelles. Veuillez ajouter vos documents."
    let etapeValidDoc = "Vous avez bien rempli vos informations personnelles. En attente de validation par notre équipe."
    let etapeInfoCo = "Votre dossier a bien été validé. Vous pouvez vous inscrire à une information collective."
    let etapeRappelInfoCo = "Votre inscription a bien été prise en compte. Vous êtes inscrit à une information collective."
    let etapeFinal = "Merci d'avoir utilisé Adrar Connect"
    
    @IBOutlet weak var dossierLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var descTextProgression: UILabel!
    @IBOutlet weak var button1: BoutonAvancement!
    @IBOutlet weak var button2: BoutonAvancement!
    @IBOutlet weak var button3: BoutonAvancement!
    @IBOutlet weak var button4: BoutonAvancement!
    @IBOutlet weak var button5: BoutonAvancement!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if UserDefaults.standard.string(forKey: "utilisateur") != nil {
            userReceived = UtilisateurAPIHelper().getUserDefautForKeyUtilisateur()
            changeTextAndProgressView()
        }
    }
    //En fonction de l'avancement inscription on change la progressBar et le texte.
    private func changeTextAndProgressView(){
        if userReceived?.ID_avancementInscription != nil {
            switch userReceived?.ID_avancementInscription{
            case 1:
                descTextProgression.text = etapeInfoPerso
                progressView.progress = 0.1
                button1.backgroundColor = Vert
            case 2:
                descTextProgression.text = etapeDoc
                progressView.progress = 0.3
                button1.backgroundColor = Vert
                button2.backgroundColor = Vert
                if userReceived != nil, userReceived?.documents != nil {
                    var cvOk:Bool = false
                    var prescriptionPEOk:Bool = false
                    for document in userReceived!.documents! {
                        if document.id_typeDocument == 2 {
                            cvOk = true
                        }
                        if document.id_typeDocument == 4 {
                            prescriptionPEOk = true
                        }
                    }
                    if cvOk , prescriptionPEOk {
                        descTextProgression.text = etapeValidDoc
                    }
                }
            case 3:
                dossierLbl.text = "Dossier Validé"
                descTextProgression.text = etapeInfoCo
                progressView.progress = 0.5
                button1.backgroundColor = Vert
                button2.backgroundColor = Vert
                button3.backgroundColor = Vert
            case 4:
                dossierLbl.text = "Dossier Validé"
                descTextProgression.text = etapeRappelInfoCo
                progressView.progress = 0.7
                button1.backgroundColor = Vert
                button2.backgroundColor = Vert
                button3.backgroundColor = Vert
                button4.backgroundColor = Vert
            case 5:
                dossierLbl.text = "Dossier Validé"
                descTextProgression.text = etapeFinal
                progressView.progress = 0.9
                button1.backgroundColor = Vert
                button2.backgroundColor = Vert
                button3.backgroundColor = Vert
                button4.backgroundColor = Vert
                button5.backgroundColor = Vert
            default:
                return
            }
        }
        
    }
    //Retour
    @IBAction func goToProcessusView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProcessusInscription", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Process")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func progressBarInscriptionInfoCoBtn(_ sender: Any) {
    }
    @IBAction func progressBarParticipationInfoCoBtn(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
