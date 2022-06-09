//
//  RecentlyVisitedCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

protocol RecentlyVisitedCellDelegate{
    func getMovieResult(with movieID: String,_ genre: String)
}

class RecentlyVisitedCell: UITableViewCell {

    @IBOutlet weak var collectionVisited: UICollectionView!
    
    var arrayMovies = [Movie]()
    var delegate : RecentlyVisitedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionVisited.register(MovieCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(_ data: [Movie]){
        arrayMovies = data
        DispatchQueue.main.async {
            self.collectionVisited.reloadData()
        }
    }
}

extension RecentlyVisitedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = arrayMovies[indexPath.row]
        let cell: MovieCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupData(data.posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = arrayMovies[indexPath.row]
        delegate?.getMovieResult(with: data.movieID, data.genre)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
