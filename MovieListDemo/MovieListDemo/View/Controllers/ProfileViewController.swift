//
//  ProfileViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        tableView.register(NameCell.self)
        tableView.register(FavouriteCell.self)
        tableView.register(SignoutCell.self)
        tableView.register(RecommandAndListCell.self)
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell: NameCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case 1:
            let cell: FavouriteCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case 2:
            let cell: RecommandAndListCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = "Recommendations"
            return cell
        case 3:
            let cell: RecommandAndListCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = "Created Lists"
            return cell
        default:
            let cell: SignoutCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}
