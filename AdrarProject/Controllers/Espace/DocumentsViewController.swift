//
//  DocumentsViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
//Gestion d'envoie des documents.
class DocumentsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    var userReceived:Utilisateur?
    let picker = UIImagePickerController()
    @IBOutlet weak var lettreMotivationButton: UIButton!
    @IBOutlet weak var prescriptionPEButton: UIButton!
    @IBOutlet weak var cvButton: UIButton!
    var imageTooBig = false
    var idTypeDoc:Int?
    let imageDocValide:UIImage! = UIImage(named: "valide-doc")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let user = UserDefaults.standard.string(forKey: "utilisateur") {
            jsonToUser(user)
            if userReceived != nil {
                changeImageButton(user: userReceived!)
            }
        }
        if imageTooBig == true {
            showToast(message: "Veuillez envoyez une image de moins de 1MB", font: .systemFont(ofSize: 12))
        }
    }
    //Transformation du json en données de type Utilisateur.
    private func jsonToUser(_ userString:String){
        if let result: Data = userString.data(using: .utf8) {
            do {
                userReceived = try JSONDecoder().decode(Utilisateur.self, from: result)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    //Ouverture de la gallerie de l'utilisateur ( info.plist )
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
    //Gestion de la compression si la qualité trop importante, si vraiment trop alors renvoie nil
    func manageImageQuality(_ image: UIImage)->Data?{
        let imageCompression = image.jpegData(compressionQuality: 1)
        if imageCompression != nil {
            switch imageCompression!.count {
            case 0..<90000:
                return imageCompression
            case 90000..<120000:
                return image.jpegData(compressionQuality: 0.6)
            case 1200000..<9000000:
                return image.jpegData(compressionQuality: 0.1)
            default:
                return nil
            }
        }
        return nil
    }
    //En fonction de l'image récuperer , envoie ou non en bd puis affichage si bon dans la page
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
            let imageCompression = manageImageQuality(pickedImage)
            if imageCompression != nil{
                print("actual size of image in KB: %f ", Double(imageCompression!.count) / 1000.0)
                let imageBase64 = imageCompression!.base64EncodedString(options: .lineLength64Characters)
                print(imageBase64.count)
                if userReceived != nil && idTypeDoc != nil {
                    imageTooBig = false
                    DispatchQueue.main.async {
                        UtilisateurAPIHelper().addDocument(utilisateur: self.userReceived!, idTypeDoc: self.idTypeDoc! , base64Image: imageBase64) { (user, error) in
                            if error != nil {
                                print(error!)
                            }
                            if user != nil {
                                let userBytes = try! JSONEncoder().encode(user)
                                let userJSON = String(decoding: userBytes, as: UTF8.self)
                                UserDefaults.standard.set(userJSON, forKey: "utilisateur")
                                self.changeImageButton(user: user!)
                            }
                        }
                    }
                }
            }else{
                imageTooBig = true
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    //Changement des Images si l'user a bien un CV etc
    func changeImageButton(user:Utilisateur){
        if user.documents != nil {
            DispatchQueue.main.async {
                for document in user.documents!{
                    switch document.id_typeDocument {
                    case 2:
                        self.cvButton.setImage(self.imageDocValide, for: .normal)
                        self.cvButton.backgroundColor = Vert
                    case 3:
                        self.lettreMotivationButton.setImage(self.imageDocValide, for: .normal)
                        self.lettreMotivationButton.backgroundColor = Vert
                    case 4:
                        self.prescriptionPEButton.setImage(self.imageDocValide, for: .normal)
                        self.prescriptionPEButton.backgroundColor = Vert
                    default:
                        break
                    }
                }
            }
        }
    }
    //Verification de si les docs ont déja été envoyés
    func checkIfDocExist(_ id_typeDpc:Int)->Bool{
        if userReceived != nil {
            if userReceived?.documents != nil {
                for document in userReceived!.documents! {
                    if document.id_typeDocument == id_typeDpc {
                        switch id_typeDpc{
                        case 2:
                            cvButton.isEnabled = false
                            showToast(message: "Votre CV a déja été envoyé", font: .systemFont(ofSize: 12))
                            return true
                        case 3:
                            lettreMotivationButton.isEnabled = false
                            showToast(message: "Votre Lettre de Motivation a déja été envoyé", font: .systemFont(ofSize: 12))
                            return true
                        case 4:
                            prescriptionPEButton.isEnabled = false
                            showToast(message: "Votre Prescription Pole Emploi a déja été envoyé", font: .systemFont(ofSize: 12))
                            return true
                        default:
                            return false
                        }
                    }
                }
                return false
            }
            return false
        }
        return false
    }
    @IBAction func validerEtRetour(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    //Action qui call fonction plus haute
    @IBAction func lettreMotivationAddDocumentButton(_ sender: Any) {
        idTypeDoc = 3
        if checkIfDocExist(3) == false {
            openGallery()
        }
    }
    @IBAction func cvAddDocumentButton(_ sender: Any) {
        idTypeDoc = 2
        if checkIfDocExist(2) == false {
            openGallery()
        }
    }
    @IBAction func prescriptionPEAddDocumentButton(_ sender: Any) {
        idTypeDoc = 4
        if checkIfDocExist(4) == false {
            openGallery()
        }
    }
}
