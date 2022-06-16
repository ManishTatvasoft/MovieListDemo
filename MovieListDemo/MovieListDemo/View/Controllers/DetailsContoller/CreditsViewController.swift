//
//  CreditsViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class CreditsViewController: BaseViewController {

    @IBOutlet private weak var collectionCredits: UICollectionView!
    
    var castCrewData: CastCrewManager?
    var name: String?
    private lazy var viewModel = CreditsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name ?? "Credits"
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView() {
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
            if isSuccess {
                guard let data = credits else {
                    self.showValidationMessage(withMessage: String.Title.dataNotFound)
                    return
                }
                self.castCrewData = CastCrewManager(cast: CastCrewManager.CastManager(castData: data.cast ?? []), crew: CastCrewManager.CrewManager(crewData: data.crew ?? []))
                
                DispatchQueue.main.async {
                    self.collectionCredits.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.showValidationMessage(withMessage: errorMessage)
                }
            }
        }
    }
    
    @IBAction func buttonExpandCollepsAction(_ sender: UIButton) {
        if sender.tag == 0 {
            castCrewData?.cast.isOpened.toggle()
//            if castCrewData?.cast.isOpened{
//                (self.collectionCredits.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
//            } else {
//                (self.collectionCredits.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
//            }
            
        } else {
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

extension CreditsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let castCrewData = castCrewData else {
            return 0
        }
        return Mirror(reflecting: castCrewData).children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if let cast = castCrewData?.cast {
                if cast.isOpened{
                    return cast.castData.count
                } else {
                    return 0
                }
            } else {
                return 0
            }
            
        } else {
            if let crew = castCrewData?.crew {
                if crew.isOpened{
                    return crew.crewData.count
                } else {
                    return 0
                }
            } else {
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
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView
        if let view = view {
            view.expandCollepsButton.tag = indexPath.section
            if indexPath.section == 0 {
                view.headerTitleLabel.text = AppConstants.castHeader
                if let castData = castCrewData?.cast {
                    view.upDownImage.image = (castData.isOpened ? UIImage.universalImage("chevron.up") : UIImage.universalImage("chevron.down"))
                } else {
                    view.upDownImage.image = UIImage.universalImage("chevron.down")
                }
            } else {
                view.headerTitleLabel.text = AppConstants.crewHeader
                if let crewData = castCrewData?.crew {
                    view.upDownImage.image = (crewData.isOpened ? UIImage.universalImage("chevron.up") : UIImage.universalImage("chevron.down"))
                } else {
                    view.upDownImage.image =  UIImage.universalImage("chevron.down")
                }
            }
            return view
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellValue: CGFloat = 3
        let collectioViewWidth = collectionView.bounds.width
        let specing = ( cellValue * ((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0))
        let leftAndRightInset = (((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset.left ?? 0.0))
        
        let width = (collectioViewWidth - specing - leftAndRightInset) / cellValue
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section{
        case 0:
            if let isOpened = castCrewData?.cast.isOpened, isOpened {
                return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            } else {
                return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            }
        case 1:
            if let isOpened = castCrewData?.crew.isOpened, isOpened {
                return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            } else {
                return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            }
        default:
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        }
        
    }
}
