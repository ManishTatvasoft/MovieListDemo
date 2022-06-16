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

    @IBOutlet private weak var collectionVisited: UICollectionView!
    
    private var arrayMovies = [Movie]()
    var delegate: RecentlyVisitedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionVisited.register(MovieCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(_ data: [Movie]) {
        arrayMovies = data
        DispatchQueue.main.async { [weak self] in
            self?.collectionVisited.reloadData()
        }
    }
}

extension RecentlyVisitedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let result = arrayMovies[indexPath.row]
        var movie = Movie()
        movie.movieName = result.movieName
        movie.movieID = result.movieID
        movie.posterPath = result.posterPath
        movie.genre = result.genre
        movie.time = "\(Date())"
        DatabaseManager.shared.checkAndInserData(movie)
        delegate?.getMovieResult(with: result.movieID, result.genre)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellValue: CGFloat = 4
        let collectionWidth = collectionView.bounds.width
        let specing = (cellValue * ((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0))
        let leftRightInset = (((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset.left ?? 0.0))
        let width = (collectionWidth - specing - leftRightInset) / cellValue
        let height = width * 1.6 - (((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0))
        return CGSize(width: width, height: height)
    }
}
