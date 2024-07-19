//
//  GridPathFinder.swift
//
//
//  Created by Cihan Emre Kisakurek on 16.07.24.
//


// Returns empty Array if no path is found

struct QueueItem<CellType: GridCell>: Equatable, Comparable {
    static func < (lhs: QueueItem<CellType>, rhs: QueueItem<CellType>) -> Bool {
        if lhs == rhs {
            return lhs.score < rhs.score
        } else {
            return false
        }
    }
    
    static func == (lhs: QueueItem, rhs: QueueItem) -> Bool {
        lhs.cell.xValue == rhs.cell.xValue && lhs.cell.yValue == rhs.cell.yValue
//
    }
    
    let cell: CellType
    let score: Double
}


public func shortestPath<CellType: GridCell, GridType: Grid>(from start: CellType, to end: CellType, in grid: GridType) -> [CellType] {
    
    let h = grid.distance(from: start as! GridType.Cell, destination: end as! GridType.Cell)
    
    let startingQueueItem = QueueItem(cell: start, score: h)
    
    var openSet = PriorityQueue(ascending: true, startingValues: [startingQueueItem])
    var openIds = Set<CellType.ID>()
    openIds.insert(start.id)
        
    var cameFrom = [CellType: CellType]()
    
    var gScores = [CellType.ID: Double]()
    gScores[start.id] = 0
        
    while !openSet.isEmpty {
        let current = openSet.pop()
        
        
        guard let current else { continue }
        
        openIds.remove(current.cell.id)
        
        if current == QueueItem(cell: end, score: 0) {
            let path = reconstructPath(current: current.cell, map: cameFrom)
            return path
        }
        
        for neighbor in current.cell.adjacentCells {
            let d = grid.moveCostFrom(cell: current.cell as! GridType.Cell , to: neighbor as! GridType.Cell)
            if d == Double.infinity {
                continue
            }
            let gScore = gScores[current.cell.id ]! + d
            if gScore < gScores[neighbor.id ] ?? Double.infinity {
                cameFrom[neighbor] = current.cell
                gScores[neighbor.id] = gScore
                
                let fScore = gScore + grid.distance(from: current.cell as! GridType.Cell, destination: end as! GridType.Cell)
                let queueItem = QueueItem(cell: neighbor, score: fScore)
                if !openIds.contains(queueItem.cell.id) {
                    openSet.push(queueItem)
                    openIds.insert(queueItem.cell.id)
                }
            }
        }
    }
    return []
}
import Foundation
private func reconstructPath<CellType: GridCell>(current: CellType, map: [CellType: CellType]) -> [CellType] {
    let methodStart = Date()
    var path = [CellType]()
    path.append(current)
    var current = current
    while let next = map[current] {
        current = next
        path.append(current)
    }
    let methodFinish = Date()
    let executionTime = methodFinish.timeIntervalSince(methodStart)
    print("Perf time: \(executionTime)")
    return path.reversed()
}
