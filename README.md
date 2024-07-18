# GridPathFinder
A* search algorithm implementation in Swift for finding shortest path in a grid.

## Installation
Add this package as a dependency.

## Examples


```swift
struct MyGrid: Grid {
    var cells: [TestGridCell]
    
    // Cost function implementation
    func moveCostFrom(cell: TestGridCell, to: TestGridCell) -> Double {
        return 1.0
    }
}
```

```swift
struct TestGridCell: GridCell {
    var id: String { "\(xValue)-\(yValue)" }
    
    var adjacentCells: [TestGridCell]
    
    let xValue: Int
    
    let yValue: Int
    
    var isWalkable: Bool = true
    
    var title: String = ""
}
```

If you want to change the default heuristics function you can do with 
 
```swift
extension MyGrid {
    
    func distance(from fromCell: Cell, destination targetCell: Cell) -> Double {
        ...
    }
}
```
