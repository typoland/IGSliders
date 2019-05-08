import Cocoa


struct HyperCube<T:Numeric> {
    
    enum MVArrayError:Error {
        case cannotRemoveLastAxis
        case axisNumberTooHigh(axisNr:Int)
    }
    
    public var axesNr: Int {
        return Int(log2(Double(_vertices.count)))
    }
    
    public var egdesForAxis: Int {
        return 1 << (axesNr - 1)
    }
    
    private var _vertices:[T]
    private var _edges:[T]
    
    init (_ number: T) {
        _vertices = [number]
        _edges = []
    }
    
    mutating func addAxis() {
        _vertices = _vertices + _vertices
        _vertices = (0 ..< _vertices.count).map {$0 as! T}
    }
    
    mutating func removeLastAxis() throws {
        guard _vertices.count > 1 else {
            throw MVArrayError.cannotRemoveLastAxis
        }
        _vertices = Array(_vertices[0...(_vertices.count-1)/2])
    }
    
    
    func indexesFor(_ axisIndex:Int) throws -> [Int]  {
        guard axisIndex < axesNr else {
            throw MVArrayError.axisNumberTooHigh(axisNr: axisIndex)
        }
        var indexes:Array<Int> = []
        for i in 0..._vertices.count - 1 {
            if i & 1<<axisIndex != 0 {
                indexes.append(i)
            }
        }
        return indexes
    }
    
    
    
    mutating func removeAxis(_ axisIndex: Int) throws {
        guard let indexes = try? indexesFor(axisIndex) else {return}
        for i in indexes.reversed() {
            _vertices.remove(at: i)
        }
    }

    
    
    func edgeVertices(_ axis:Int, edge:Int) -> (Int, Int) {
        
        let dim = axesNr
        
        let mask = (1<<(dim-1)) - 1 // przykrywa numer verteksu <?>
        let axisVertexNr = edge & mask // edgeNr & mask // 0...4, 8, 16 numer verteksu na ścianie
        
        let rightMask = (1<<(axis))-1
        let leftMask = (1<<dim) - 1 ^ rightMask
        
        let left = (axisVertexNr << 1) & leftMask //(przesuwamy prawe
        let right = axisVertexNr & rightMask
        
        let b = left | (1<<axis) | right
        let a = b ^ 1<<axis
        
        return (a, b)
    }
}

extension HyperCube: CustomStringConvertible{
    var description: String {
        return "\(axesNr) axes, \(egdesForAxis) edges for axis, \(_vertices.count) vertices"
    }
}


var m = HyperCube(Int(1))
m.addAxis()
m
m.addAxis()
m
m.addAxis()
m
m.addAxis()
m
try m.removeAxis(3)
m
//
for axisNr in 0 ..< m.axesNr  {
    for edgeNr in 0 ..< m.egdesForAxis {
        print (axisNr, edgeNr, m.edgeVertices(axisNr, edge: edgeNr))
    }
    print()
}
