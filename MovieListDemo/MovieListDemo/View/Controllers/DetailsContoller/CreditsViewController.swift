//
//  CreditsViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var collectionCredits: UICollectionView!
    
    
    var castData: CastManager?
    var crewData: CrewManager?
    
    var name: String?
    private lazy var viewModel = CreditsViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name ?? "Credits"
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        collectionCredits.register(CastCell.self)
        collectionCredits.register(CrewCell.self)
        collectionCredits.register(HeaderView.self, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader)
        viewModel.callCreditsApi()
    }
    
    func successApiResponse(_ data: Credits){
        castData = CastManager(cast: data.cast ?? [])
        crewData = CrewManager(crew: data.crew ?? [])
        
        DispatchQueue.main.async {
            self.collectionCredits.reloadData()
        }
        
    }
    
    @IBAction func buttonExpandCollepsAction(_ sender: UIButton) {
        if sender.tag == 0{
            castData?.isOpened.toggle()
        }else{
            crewData?.isOpened.toggle()
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            if let castData = castData{
                if castData.isOpened{
                    return castData.cast.count
                }else{
                    return 0
                }
            }else{
                return 0
            }
            
        }else{
            if let crewData = crewData{
                if crewData.isOpened{
                    return crewData.crew.count
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let data = castData?.cast[indexPath.item]
            let cell: CastCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupData(data)
            return cell
        }else{
            let data = crewData?.crew[indexPath.item]
            let cell: CrewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupData(data)
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        view.expandCollepsButton.tag = indexPath.section
        if indexPath.section == 0{
            view.headerTitleLabel.text = "Cast"
            if let castData = castData{
                view.upDownImage.image = UIImage(systemName: castData.isOpened ? "chevron.up" : "chevron.down")
            }else{
                view.upDownImage.image = UIImage(systemName: "chevron.down")
            }
        }else{
            view.headerTitleLabel.text = "Crew"
            if let crewData = crewData{
                view.upDownImage.image = UIImage(systemName: crewData.isOpened ? "chevron.up" : "chevron.down")
            }else{
                view.upDownImage.image = UIImage(systemName: "chevron.down")
            }
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 40)
    }
    
    
}
