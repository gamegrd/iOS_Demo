//
//  TilingViewForImage.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/19.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit


let sideLength: CGFloat = 640.0
let fileName = "windingRoad"

class TilingViewForImage: UIView {
    
    let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String
     
     override class var layerClass : AnyClass {
       return TiledLayer.self
     }
    

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      guard let layer = self.layer as? TiledLayer else { return nil }
      layer.contentsScale = UIScreen.main.scale
      layer.tileSize = CGSize(width: sideLength, height: sideLength)
    }
    
    override func draw(_ rect: CGRect) {
      let firstColumn = Int(rect.minX / sideLength)
      let lastColumn = Int(rect.maxX / sideLength)
      let firstRow = Int(rect.minY / sideLength)
      let lastRow = Int(rect.maxY / sideLength)
      
      for row in firstRow...lastRow {
        for column in firstColumn...lastColumn {
          if let tile = imageForTileAtColumn(column, row: row) {
            let x = sideLength * CGFloat(column)
            let y = sideLength * CGFloat(row)
            let point = CGPoint(x: x, y: y)
            let size = CGSize(width: sideLength, height: sideLength)
            var tileRect = CGRect(origin: point, size: size)
            tileRect = bounds.intersection(tileRect)
            tile.draw(in: tileRect)
          }
        }
      }
    }
    
    func imageForTileAtColumn(_ column: Int, row: Int) -> UIImage? {
      let filePath = "\(cachesPath)/\(fileName)_\(column)_\(row)"
      return UIImage(contentsOfFile: filePath)
    }
    
}
