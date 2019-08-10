//
//  InformationsSuppViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.

import UIKit
//InformationPerso
class InformationsSuppViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var checkedDev:Bool = false
    var checkedRes:Bool = false
    var userReceived:Utilisateur?
    var imageTooBig = false
    let picker = UIImagePickerController()
    var ddnFormat:String?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nomTF: UITextField!
    @IBOutlet weak var prenomTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var dateNaissanceTF: UITextField!
    @IBOutlet weak var numeroTelTF: UITextField!
    @IBOutlet weak var numeroPETF: UITextField!
    @IBOutlet weak var nomDeVoieTF: UITextField!
    @IBOutlet weak var numeroDeVoieTF: UITextField!
    @IBOutlet weak var complementAdresseTF: UITextField!
    @IBOutlet weak var villeTF: UITextField!
    @IBOutlet weak var codePostalTF: UITextField!
    @IBOutlet weak var devBtn: UIButton!
    @IBOutlet weak var resBtn: UIButton!
    @IBOutlet weak var imageUser: UIImageView!
    
    //Le delegate permet de pouvoir traiter le clavier sur ses textfields
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.isUserInteractionEnabled = false
        self.prenomTF.delegate = self
        self.nomTF.delegate = self
        self.emailTF.delegate = self
        self.dateNaissanceTF.delegate = self
        self.numeroTelTF.delegate = self
        self.numeroPETF.delegate = self
        self.nomDeVoieTF.delegate = self
        self.numeroDeVoieTF.delegate = self
        self.complementAdresseTF.delegate = self
        self.villeTF.delegate = self
        self.codePostalTF.delegate = self
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let user = UserDefaults.standard.string(forKey: "utilisateur") {
            jsonToUser(user)
        }
        if imageTooBig == true {
            showToast(message: "Veuillez envoyez une image de moins de 1MB", font: .systemFont(ofSize: 12))
        }
    }
    @objc func adjustForKeyboard(notification: Notification)
    {
        // 1
        let userInfo = notification.userInfo!
        
        // 2
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        // 3
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        // 4
        // let selectedRange = scrollView.selectedRange
        // scrollView.scrollRangeToVisible(selectedRange)
    }
    
    //Transformation du json en données de type Utilisateur.
    private func jsonToUser(_ userString:String){
        if let result: Data = userString.data(using: .utf8) {
            do {
                userReceived = try JSONDecoder().decode(Utilisateur.self, from: result)
                if userReceived != nil {
                    injectInfo(userReceived!)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //On affiche les données récuperer dans chaques textfield.
    private func injectInfo(_ user:Utilisateur){
        nomTF.text = user.nom
        prenomTF.text = user.prenom
        emailTF.text = user.email
        if user.ddn != nil {
            let timestamp = user.ddn!
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd-MM-yyyy"
            ddnFormat = dateFormatter.string(from: date)
            dateNaissanceTF.text = ddnFormat
        }
        if user.telephone != nil {
            numeroTelTF.text = user.telephone
        }
        if user.numeroPe != nil {
            numeroPETF.text = user.numeroPe
        }
        if user.numeroVoie != nil {
            numeroDeVoieTF.text = user.numeroVoie
        }
        if user.adresse != nil {
            nomDeVoieTF.text = user.adresse
        }
        if user.complementAdresse != nil {
            complementAdresseTF.text = user.complementAdresse
        }
        if user.ville != nil {
            villeTF.text = user.ville
        }
        if user.cp != nil {
            codePostalTF.text = user.cp
        }
        if user.dev == 1 {
            checkedDev = true
            devBtn.setImage(checkBoxRemplie, for: .normal)
        } else {
            checkedDev = false
            devBtn.setImage(checkBoxVide, for: .normal)
        }
        if user.reseau == 1 {
            checkedRes = true
            resBtn.setImage(checkBoxRemplie, for: .normal)
        } else {
            checkedRes = false
            resBtn.setImage(checkBoxVide, for: .normal)
        }
        if user.documents != nil {
            for document in user.documents! {
                if document.id_typeDocument == 1 {
                    let imageBase64 = document.base64
                    let dataDecoded : Data = Data(base64Encoded: imageBase64, options: .ignoreUnknownCharacters)!
                    let image = UIImage(data:dataDecoded)
                    imageUser.image = image
                }
            }
        }
    }
    
    //Gestion du clique sur les checkBox
    @IBAction func changeImageDev(_ sender: UIButton) {
        if self.checkedDev == false{
            sender.setImage(checkBoxRemplie, for: .normal)
            self.checkedDev = true
        } else {
            sender.setImage(checkBoxVide, for: .normal)
            self.checkedDev = false
        }
    }
    
    @IBAction func changeImageReseau(_ sender: UIButton) {
        if self.checkedRes == false {
            sender.setImage(checkBoxRemplie, for: .normal)
            self.checkedRes = true
        } else {
            sender.setImage(checkBoxVide, for: .normal)
            self.checkedRes = false
        }
    }
    //Requete avec l'utilisateur mit a jour avec les textfields
    private func updateUser(){
        if userReceived != nil {
            DispatchQueue.main.async {
                UtilisateurAPIHelper().update(utilisateur: self.userReceived!) { (user, erreur) in
                    if erreur != nil {
                        print(erreur!)
                    }
                    if user != nil {
                        let userBytes = try! JSONEncoder().encode(user)
                        let userJSON = String(decoding: userBytes, as: UTF8.self)
                        UserDefaults.standard.set(userJSON, forKey: "utilisateur")
                    }
                }
            }
        }
    }
    
    private func updateUserReceived(){
        var ddn:Int? = nil
        if let ddnUser = dateNaissanceTF.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat="dd-MM-yyyy"
            dateFormatter.locale = Locale.current
            let date = dateFormatter.date(from: ddnUser)
            if date != nil {
                let dateStamp = date!.timeIntervalSince1970
                let dateSt:Int = Int(dateStamp)
                ddn = dateSt
            } else {
                showToast(message: "Mauvais Format pour votre Date de Naissance", font: .systemFont(ofSize: 12))
            }
        }
        var tel:String? = nil
        if let telUser = numeroTelTF.text, !telUser.isEmpty{
            tel = telUser
        }
        var numVoie:String? = nil
        if let numVoieUser = numeroDeVoieTF.text, !numVoieUser.isEmpty{
            numVoie = numVoieUser
        }
        var numPE:String? = nil
        if let numPEUser = numeroPETF.text, !numPEUser.isEmpty{
            numPE = numPEUser
        }
        var adresse:String? = nil
        if let adresseUser = nomDeVoieTF.text, !adresseUser.isEmpty{
            adresse = adresseUser
        }
        var complAdresse:String? = nil
        if let complAdresseUser = complementAdresseTF.text, !complAdresseUser.isEmpty{
            complAdresse = complAdresseUser
        }
        var cp:String? = nil
        if let cpUser = codePostalTF.text, !cpUser.isEmpty{
            cp = cpUser
        }
        var ville:String? = nil
        if let villeUser = villeTF.text, !villeUser.isEmpty{
            ville = villeUser
        }
        var dev:Int = 0
        if checkedDev == true {
            dev = 1
        }
        var res:Int = 0
        if checkedRes == true {
            res = 1
        }
        let newUser = Utilisateur(id: userReceived!.id, nom: nomTF.text!, prenom: prenomTF.text!, ddn: ddn, email: emailTF.text!, telephone: tel, numeroPe: numPE ,mdp:nil, numeroVoie: numVoie, adresse: adresse, complementAdresse: complAdresse, cp: cp, ville: ville, dev: dev, reseau:res, admin: nil, idSessionConnexion: userReceived?.idSessionConnexion, ID_infoCollective: userReceived?.ID_infoCollective, ID_avancementInscription: userReceived?.ID_avancementInscription,documents: userReceived?.documents)
        userReceived = newUser
    }
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
            imageUser.contentMode = .scaleAspectFill
            let imageCompression = manageImageQuality(pickedImage)
            if imageCompression != nil{
                //print("actual size of image in KB: %f ", Double(imageCompression!.count) / 1000.0)
                let imageBase64 = imageCompression!.base64EncodedString(options: .lineLength64Characters)
                if userReceived != nil {
                    imageTooBig = false
                    DispatchQueue.main.async {
                        UtilisateurAPIHelper().addDocument(utilisateur: self.userReceived!, idTypeDoc: 1, base64Image: imageBase64) { (user, error) in
                            if error != nil {
                                print(error!)
                            }
                            if user != nil {
                                let userBytes = try! JSONEncoder().encode(user)
                                let userJSON = String(decoding: userBytes, as: UTF8.self)
                                UserDefaults.standard.set(userJSON, forKey: "utilisateur")
                                DispatchQueue.main.async {
                                    self.imageUser.image = pickedImage
                                    picker.dismiss(animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
            }else{
                imageTooBig = true
                picker.dismiss(animated: true, completion: nil)
            }
        } else {
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    func manageImageQuality(_ image: UIImage)->Data?{
        let imageCompression = image.jpegData(compressionQuality: 1)
        if imageCompression != nil {
            switch imageCompression!.count {
            case 0..<900000:
                return imageCompression
            case 900000..<1200000:
                return image.jpegData(compressionQuality: 0.6)
            case 1200000..<9000000:
                return image.jpegData(compressionQuality: 0.1)
            default:
                return nil
            }
        }
        return nil
    }
    @IBAction func addUserProfilPictu(_ sender: Any) {
        openGallery()
    }
    //Post les nouvelles informations
    @IBAction func ValiderInfoSupp(_ sender: Any) {
       
        updateUserReceived()
        updateUser()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
