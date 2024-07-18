import XCTest
@testable import GridPathFinder

final class GridPathFinderTests: XCTestCase {
   
    func testDiagonal() throws {
        let methodStart = Date()
        let grid = TestGrid()
        
        let firstCell = grid.cells.first!
        let endCell = grid.cells.last!
        
        let path = GridPathFinder.shortestPath(from: firstCell, to: endCell, in: grid)
    
        XCTAssertGreaterThan(path.count, 0)
        for (index, item) in path.enumerated() {
            XCTAssertEqual(firstCell.xValue + index, item.xValue)
            XCTAssertEqual(firstCell.yValue + index, item.yValue)
        }
        
        let methodFinish = Date()
        let executionTime = methodFinish.timeIntervalSince(methodStart)
        print("Perf time: \(executionTime)")
 
    }
    
    func testMeasureDiagonal() async throws {
        self.measure(metrics: [XCTMemoryMetric(), XCTClockMetric()]) {
            try? testDiagonal()
        }
    }
}
