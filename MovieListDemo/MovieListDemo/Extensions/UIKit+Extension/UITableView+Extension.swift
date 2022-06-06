//
//  UITableView+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

extension UITableView {
    final  func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        register(UINib.init(nibName: String(describing: T.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: T.self))
    }
    final func dequeueCellFromNIB<T: UITableViewCell>(_: T.Type) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T{
            return cell
        }else{
            register(T.self)
            return dequeueCellFromNIB(T.self)
        }
    }
}


extension UITableViewCell: Reusable {}
extension UITableView {
    /// Registers a `UITableViewCell` using it's own `reuseIdentifier`. The `UITableViewCell` must be created using
    /// a `.xib` file with the same name, otherwise it will crash.
    func register<Cell: UITableViewCell>(_: Cell.Type) {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = .zero
        }
        self.register(Cell.nib, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    /// Dequeues a `UITableViewCell` and casts it to the expected type at the call site.
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue a \(String(describing: Cell.self)) cell.")
        }
        return cell
    }
}


