/*
* AccessoryIndicator
*
* Created by Jeremy Fox on 3/1/16.
* Copyright (c) 2016 Jeremy Fox. All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

import UIKit

class AccessoryIndicator: UIControl {
    
    var accessoryColor: UIColor?
    var highlightColor: UIColor?
    fileprivate var facing: Direction?

    enum Direction {
        case left, right //, Up, Down
    }

    override var isHighlighted: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    class func withColor(_ color: UIColor, facing: Direction, size: CGSize) -> AccessoryIndicator {
        let acc = AccessoryIndicator(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        acc.facing = facing
        acc.accessoryColor = color
        return acc
    }
    
    override func draw(_ rect: CGRect) {
        let y = bounds.midY
        let R = rect.height
        let ctxt = UIGraphicsGetCurrentContext()
        if let _facing = facing {
            switch _facing {
            case .left:
                let x = bounds.minX
                ctxt?.move(to: CGPoint(x: x+R, y: y+R))
                ctxt?.addLine(to: CGPoint(x: x+(R/2), y: y))
                ctxt?.addLine(to: CGPoint(x: x+R, y: y-R))
            case .right:
                let x = bounds.maxX
                ctxt?.move(to: CGPoint(x: x-R, y: y-R))
                ctxt?.addLine(to: CGPoint(x: x-(R/2), y: y))
                ctxt?.addLine(to: CGPoint(x: x-R, y: y+R))
            }
        } else {
            let x = bounds.maxX
            ctxt?.move(to: CGPoint(x: x+R, y: y+R))
            ctxt?.addLine(to: CGPoint(x: x+(R/2), y: y))
            ctxt?.addLine(to: CGPoint(x: x+R, y: y-R))
        }
        
        ctxt?.setLineCap(.square)
        ctxt?.setLineJoin(.miter)
        ctxt?.setLineWidth(1)
        if isHighlighted {
            currentHighlightColor().setStroke()
        } else {
            currentAccessoryColor().setStroke()
        }
        ctxt?.strokePath()
    }
    
    fileprivate func currentAccessoryColor() -> UIColor {
        var color = UIColor.black
        if let _accessoryColor = accessoryColor {
            color = _accessoryColor
        }
        return color
    }
    
    fileprivate func currentHighlightColor() -> UIColor {
        var color = UIColor.white
        if let _highlightColor = highlightColor {
            color = _highlightColor
        }
        return color
    }
    
    override var intrinsicContentSize : CGSize {
        return frame.size
    }
    
    override var alignmentRectInsets : UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}

