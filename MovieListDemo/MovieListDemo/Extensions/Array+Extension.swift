//
//  Array+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 20/06/22.
//

import Foundation

extension Array{
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
