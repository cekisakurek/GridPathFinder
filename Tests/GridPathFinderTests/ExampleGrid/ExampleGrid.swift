//
//  File.swift
//  
//
//  Created by Cihan Emre Kisakurek on 16.07.24.
//

import Foundation
@testable import GridPathFinder

struct TestGrid: Grid {
    var cells: [TestGridCell] {
        var temp = [TestGridCell]()
        let rowCount = 5000
        let columnCount = 5000
        for i in 0..<columnCount {
            for j in 0..<rowCount {
                let cell = TestGridCell(xValue: i, yValue: j)
                temp.append(cell)
            }
        }
        return temp
    }
    
    func moveCostFrom(cell: TestGridCell, to: TestGridCell) -> Double {
        return 1.0
    }
}

struct TestGridCell: GridCell {
    var id: String { "\(xValue)-\(yValue)" }
    
    var adjacentCells: [TestGridCell] {
        [
            TestGridCell(xValue: max(xValue - 1, 0), yValue: max(yValue - 1, 0)),
            TestGridCell(xValue: xValue, yValue: max(yValue - 1, 0)),
            TestGridCell(xValue: xValue + 1, yValue: max(yValue - 1, 0)),
            TestGridCell(xValue: max(xValue - 1, 0), yValue: yValue),
            TestGridCell(xValue: max(xValue - 1, 0), yValue: yValue + 1),
            TestGridCell(xValue: xValue + 1, yValue: yValue),
            TestGridCell(xValue: xValue, yValue: yValue + 1),
            TestGridCell(xValue: xValue + 1, yValue: yValue + 1)
        ]
    }
    
    let xValue: Int
    
    let yValue: Int
    
    var isWalkable: Bool = true
    
    var title: String = ""
}

extension TestGrid {
    func distance(from fromCell: TestGridCell, destination targetCell: TestGridCell) -> Double {
        return 0
    }
}


