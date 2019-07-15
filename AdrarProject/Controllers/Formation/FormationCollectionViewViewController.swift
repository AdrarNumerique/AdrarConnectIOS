//
//  FormationControllerWithTableViewViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class FormationCollectionViewViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var formations : [Formation] = []
    private let segueID = "detailFormation"
    private var cellId = "mainFormation"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formations = catchFormation()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    //Récuperation d'un json qu'on transforme en tableau de formation.
    private func catchFormation() -> [Formation] {
        let formationsJsonAfterUD = UserDefaults.standard.string(forKey: "formations")
        if let result: Data = formationsJsonAfterUD?.data(using: .utf8) {
            do {
                print(result)
                return try JSONDecoder().decode([Formation].self, from: result)
            } catch {
                print(error.localizedDescription)
            }
        }
        return formations
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Nombre de cellule
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return formations.count
    }
    //Gestion de l'affichage des cellules dans la collectionView.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberCellInRows = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let espaceTotal = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(numberCellInRows - 1)
        let taille = Int((collectionView.bounds.width - espaceTotal)/CGFloat(numberCellInRows))
        return CGSize(width: taille, height: taille)
    }
    //Envoie de cellules.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let formation = formations[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FormationCollectionViewCell{
            cell.intituleFormation.text = formation.intitule
            return cell
        }
        return UICollectionViewCell()
    }
    
    //Quand on clique sur une cellule on envoie les données de la formation en question.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         performSegue(withIdentifier: segueID ,sender: formations[indexPath.row])
    }
    //Préparation de page formationDetail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let controller = segue.destination as? FormationDetailController {
                controller.formationRecue = sender as? Formation
            }
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Les Formations"
        backItem.tintColor = Jaune
        navigationItem.backBarButtonItem = backItem
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


