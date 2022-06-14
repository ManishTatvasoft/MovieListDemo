//
//  CreditsViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class CreditsViewController: BaseViewController {

    @IBOutlet private weak var collectionCredits: UICollectionView!
    
    
//    var castData: CastManager?
//    var crewData: CrewManager?
    
    var castCrewData: CastCrewManager?
    
    var name: String?
    private lazy var viewModel = CreditsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name ?? "Credits"
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        collectionCredits.register(CastAndCrewCell.self)
        collectionCredits.register(HeaderView.self, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader)
        self.startLoading()
        viewModel.callCreditsApi { [weak self] credits, isSuccess, errorMessage in
            guard let self = self else{
                self?.stopLoading()
                self?.showValidationMessage(withMessage: String.Title.dataNotFound)
                return
            }
            self.stopLoading()
            if isSuccess{
                guard let data = credits else {
                    self.showValidationMessage(withMessage: String.Title.dataNotFound)
                    return
                }
                self.castCrewData = CastCrewManager(cast: CastManager(castData: data.cast ?? []), crew: CrewManager(crewData: data.crew ?? []))
                
                DispatchQueue.main.async {
                    self.collectionCredits.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.showValidationMessage(withMessage: errorMessage)
                }
            }
        }
    }
    
    @IBAction func buttonExpandCollepsAction(_ sender: UIButton) {
        if sender.tag == 0{
            castCrewData?.cast.isOpened.toggle()
        }else{
            castCrewData?.crew.isOpened.toggle()
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            self.collectionCredits.reloadSections(IndexSet(integer: sender.tag))
            self.collectionCredits.layoutIfNeeded()
            self.view.layoutIfNeeded()
        } completion: { isSuccess in
            print(isSuccess)
        }
    }
    
    
}

extension CreditsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let castCrewData = castCrewData else {
            return 0
        }
        return Mirror(reflecting: castCrewData).children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            if let cast = castCrewData?.cast{
                if cast.isOpened{
                    return cast.castData.count
                }else{
                    return 0
                }
            }else{
                return 0
            }
            
        }else{
            if let crew = castCrewData?.crew{
                if crew.isOpened{
                    return crew.crewData.count
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CastAndCrewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupData(castCrewData, index: indexPath.item, isCast: (indexPath.section == 0))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        view.expandCollepsButton.tag = indexPath.section
        if indexPath.section == 0{
            view.headerTitleLabel.text = "Cast"
            if let castData = castCrewData?.cast{
                view.upDownImage.image = (castData.isOpened ? UIImage.universalImage("chevron.up") : UIImage.universalImage("chevron.down"))
            }else{
                view.upDownImage.image = UIImage.universalImage("chevron.down")
            }
        }else{
            view.headerTitleLabel.text = "Crew"
            if let crewData = castCrewData?.crew{
                view.upDownImage.image = (crewData.isOpened ? UIImage.universalImage("chevron.up") : UIImage.universalImage("chevron.down"))
            }else{
                view.upDownImage.image =  UIImage.universalImage("chevron.down")
            }
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - (((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset.right ?? 0.0) / 1.5)
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 40)
    }
}
