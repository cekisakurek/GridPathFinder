//
//  File.swift
//  
//
//  Created by Cihan Emre Kisakurek on 16.07.24.
//

import Foundation

public protocol Grid {
    associatedtype Cell
    
    // Cost function calculation.
    // Return Double.infinity for unreachable cells
    // The weight of the edge from current to neighbor
    func moveCostFrom(cell: Cell, to: Cell) -> Double
    
    // estimates the cost to reach goal from node n
    func distance(from fromCell: Cell, destination targetCell: Cell) -> Double
    
    var cells: [Cell] { get }
}

extension Grid {

    // Default heuristics implementation.
    func distance(from fromCell: any GridCell, destination targetCell: any GridCell) -> Double {
        
        // http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
        // When D = 1 and D2 = 1, this is called the Chebyshev distance.
        // When D = 1 and D2 = sqrt(2), this is called the octile distance.
        let D: Double = 1.0
        let D2: Double = sqrt(2)
        
        let dx: Double = Double(abs(fromCell.xValue - targetCell.xValue))
        let dy: Double = Double(abs(fromCell.yValue - targetCell.yValue))
        return D * (dx + dy) + (D2 - 2 * D) * min(dx, dy)
    }
}
