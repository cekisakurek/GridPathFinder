//
//  GridPathFinder.swift
//
//
//  Created by Cihan Emre Kisakurek on 16.07.24.
//


// Returns empty Array if no path is found

public func shortestPath<CellType: GridCell, GridType: Grid>(from start: CellType, to end: CellType, in grid: GridType) -> [CellType] {
    
    let h = grid.distance(from: start as! GridType.Cell, destination: end as! GridType.Cell)
    
    var openSet = [CellType: Double]()
    openSet[start] = h
    
    var cameFrom = [CellType: CellType]()
    
    var gScores = [CellType.ID: Double]()
    gScores[start.id] = 0
        
    while !openSet.isEmpty {
        let current = openSet.min(by: { $0.value < $1.value })!
        
        if current.key == end {
            let path = reconstructPath(current: current.key, map: cameFrom)
            return path
        }
        openSet.removeValue(forKey: current.key)
        
        for neighbor in current.key.adjacentCells {
            let d = grid.moveCostFrom(cell: current.key as! GridType.Cell , to: neighbor as! GridType.Cell)
            if d == Double.infinity {
                continue
            }
            let gScore = gScores[current.key.id]! + d
            if gScore < gScores[neighbor.id] ?? Double.infinity {
                cameFrom[neighbor] = current.key
                gScores[neighbor.id] = gScore
                if openSet[neighbor] == nil {
                    let fScore = gScore + grid.distance(from: current.key as! GridType.Cell, destination: end as! GridType.Cell)
                    openSet[neighbor] = fScore
                    
                }
            }
        }
       
    }
    
    return []
}

private func reconstructPath<CellType: GridCell>(current: CellType, map: [CellType: CellType]) -> [CellType] {
    var path = [CellType]()
    path.append(current)
    var current = current
    while let next = map[current] {
        current = next
        path.append(current)
    }
    return path.reversed()
}
