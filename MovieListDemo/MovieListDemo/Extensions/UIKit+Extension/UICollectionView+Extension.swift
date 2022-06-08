//
//  UICollectionView+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit
extension UICollectionViewCell: Reusable {}

extension UICollectionReusableView: Reusable {}

extension UICollectionView {
    /// Registers a `UICollectionViewCell` using it's own `reuseIdentifier`. The `UICollectionViewCell` must be created using
    /// a `.xib` file with the same name, otherwise it will crash.
    func register<Cell: UICollectionViewCell>(_: Cell.Type) {
        self.register(Cell.nib, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func register<Cell: UICollectionReusableView>(_: Cell.Type, viewForSupplementaryElementOfKind kind: String) {
        self.register(Cell.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: Cell.reuseIdentifier)
    }
    
    /// Dequeues a `UICollectionViewCell` and casts it to the expected type at the call site.
    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue a \(String(describing: Cell.self)) cell.")
        }
        return cell
    }
}
