//
//  File.swift
//  
//
//  Created by Cihan Emre Kisakurek on 18.07.24.
//

import Foundation

protocol GridCell: Equatable, Hashable, Identifiable {
    var xValue: Int { get }
    var yValue: Int { get }
    var adjacentCells: [Self] { get }
}
