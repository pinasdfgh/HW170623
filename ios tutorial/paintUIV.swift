//
//  paintUIV.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/24.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class paintUIV: UIView {
    
    private var context:CGContext?
    private var isInit:Bool = false
    private var lines:[Int:Array<(CGFloat,CGFloat)>] = [0:[]]
    private var line:Array<(CGFloat,CGFloat)> = []
    private var lineCount = 0
    private var relines:[Int:Array<(CGFloat,CGFloat)>] = [0:[]]
    private var relineCount = 0
    private var typedraw:Int = 0
    private var proplines:[Int:Int] = [0:0]
    private var pepole = UIImage(named: "pepole.jpg")
    private var pepoleW:CGFloat?
    private var pepoleH:CGFloat?
    private var viewW:CGFloat?
    private var viewH:CGFloat?
    private var pepole2 = UIImage(named: "volleyball1.png")
    private var pepole2W:CGFloat?
    private var pepole2H:CGFloat?
    private var dx:CGFloat = 2
    private var dy:CGFloat = 2
    private var px:CGFloat?
    private var py:CGFloat?
    
    private func drawInit(_ rect:CGRect){
        isInit = true
        context = UIGraphicsGetCurrentContext()
        pepoleW = pepole?.size.width
        pepoleH = pepole?.size.height
        pepole2W = pepole2?.size.width
        pepole2H = pepole2?.size.height
        viewW = rect.size.width
        viewH = rect.size.height
        px = 0
        py = 0
        print(px)
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: {(timer) in
                self.drawimg()
            })
        } else {
            Timer.scheduledTimer(timeInterval: 0.02,
                                 target: self,
                                 selector: #selector(cdrawimg),
                                 userInfo: nil,
                                 repeats: true)
        }
    }
    
    @objc private func cdrawimg(){
        move()
        setNeedsDisplay()
    }
    
    
    @objc private func drawimg(){
        move()
        setNeedsDisplay()
    }
    
    private func move(){
        if px! < 0 || px! > viewW! - pepole2W!/10 {
            dx *= -1
        }
        if py! < 0 || py! > viewH! - pepole2H!/10 {
            dy *= -1
        }
        
        px! += dx
        py! += dy
    }
    
    func changeType(_ num:Int){
        typedraw = num
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        relines = [0:[]]
        relineCount = 0
        lineCount += 1
        line.append((point!.x,point!.y))
        lines[lineCount] = line
        proplines[lineCount] = typedraw
        //        print("move=>relineCount = \(relineCount):lineCount = \(lineCount)")
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        line.append((point!.x,point!.y))
        lines[lineCount] = line
//        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        line.append((point!.x,point!.y))
        lines[lineCount] = line
        line = []
        
    }
    
    func updo(){
        if lineCount > 0 {
            relineCount += 1
            relines[relineCount] = lines.removeValue(forKey: lineCount)
            lineCount -= 1
//            setNeedsDisplay()
        }
    }
    
    func redo(){
        if relineCount > 0{
            lineCount += 1
            lines[lineCount] = relines.removeValue(forKey: relineCount)
            relineCount -= 1
//            setNeedsDisplay()
        }
        
    }
    func clear(){
        lines = [0:[]]
        lineCount = 0
//        setNeedsDisplay()
    }

    
    override func draw(_ rect: CGRect) {
        
        if !isInit {drawInit(rect)}
        
        pepole?.draw(in: CGRect(x: 0, y: 0, width:pepoleW!/3 , height: pepoleH!/3))
        pepole2?.draw(in: CGRect(x: px!, y: py!, width:pepole2W!/10 , height: pepole2H!/10))
        
        for name in 1..<lines.count{
            
            if lines[name]!.count < 1 {continue}
            
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            
        
            let typedrawTemp:Int = proplines[name] ?? 0
            
            switch typedrawTemp {
            case 1:
                randrectLine(name)
            case 2:
                rectLine(name)
            case 3:
                triLine(name)
            default:
                normalLine(name)
                
            }
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
        
    }
    
    private func normalLine(_ name:Int){
        let (p0x,p0y) = lines[name]![0]
        
        context?.move(to: CGPoint(x:p0x,y:p0y))
        
        var i = 1
        while i < lines[name]!.count {
            let (p1x,p1y) = lines[name]![i]
            context?.addLine(to: CGPoint(x:p1x,y:p1y))
            i += 1
        }
        
    }
    
    private func randrectLine(_ name:Int){
        
        var distance:Double = 0
        var angle:Double = 0
        var disline:Double = 10
        var changeD = true
        var pi:Double = M_PI
        
        let (p0x,p0y) = lines[name]![0]
        
        context?.move(to: CGPoint(x:p0x,y:p0y))
        
        var i = 1
        while i < lines[name]!.count {
            var (p0x,p0y) = lines[name]![i - 1]
            var (p1x,p1y) = lines[name]![i]
            
            let xdis = pow(Double(p1x - p0x), 2)
            let ydis = pow(Double(p1y - p0y), 2)
            distance = sqrt(xdis + ydis)
            angle = acos(Double(p1x - p0x)/distance)
            if p1y - p0y < 0{
                angle = 2*pi - angle
            }
            
            if changeD {
               
                p0x = p0x - CGFloat(disline * sin(angle))
                p0y = p0y + CGFloat(disline * cos(angle))
                p1x = p1x - CGFloat(disline * sin(angle))
                p1y = p1y + CGFloat(disline * cos(angle))
                
            }else{
            
                p0x = p0x - CGFloat(disline * sin(angle + pi))
                p0y = p0y + CGFloat(disline * cos(angle + pi))
                p1x = p1x - CGFloat(disline * sin(angle + pi))
                p1y = p1y + CGFloat(disline * cos(angle + pi))
            }
            
            if i > 1{
                changeD = !changeD
            }
            
        
            context?.addLine(to: CGPoint(x:p0x,y:p0y))
            context?.addLine(to: CGPoint(x:p1x,y:p1y))

            i += 1
        }
        
    }
    private func rectLine(_ name:Int){
        
 //-------------angle calculate ---------------
        var distance:Double = 0         // two point distance
        var angle:Double = 0            // two point to x-axis angle
        var totaldistance:Double = 0    // toltal path distance
        
        var changeD = true
        let pi:Double = M_PI
        
        var rectdis:Double = 20         //rect path peroid
        var disline:Double = 10         //rect path amplify
        
        let (p0x,p0y) = lines[name]![0]
        context?.move(to: CGPoint(x:p0x,y:p0y))
        
        var i = 1
        while i < lines[name]!.count {
            
            var (p0x,p0y) = lines[name]![i - 1]
            var (p1x,p1y) = lines[name]![i]
//------------------------angle calculating-----------------------------------
            var xdis = pow(Double(p1x - p0x), 2)
            var ydis = pow(Double(p1y - p0y), 2)
            distance = sqrt(xdis + ydis)
            angle = acos(Double(p1x - p0x)/distance)
            
            // angle move along negative y case
            
            if p1y - p0y < 0{
                angle = 2*pi - angle
            }

//----------------------- cut path base on rectdis(rect path peroid) ---------------
            while distance  > rectdis - totaldistance {
                let reduceDis:Double = rectdis - totaldistance
                var (newp1x,newp1y) = (p0x + CGFloat(reduceDis * cos(angle)),p0y + CGFloat(reduceDis*sin(angle)))
                var (np1x,np1y) = (newp1x,newp1y)
                
                if changeD {
                    p0x = p0x - CGFloat(disline * sin(angle))
                    p0y = p0y + CGFloat(disline * cos(angle))
                    np1x = newp1x - CGFloat(disline * sin(angle))
                    np1y = newp1y + CGFloat(disline * cos(angle))
                }else{
                    p0x = p0x - CGFloat(disline * sin(angle + pi))
                    p0y = p0y + CGFloat(disline * cos(angle + pi))
                    np1x = newp1x - CGFloat(disline * sin(angle + pi))
                    np1y = newp1y + CGFloat(disline * cos(angle + pi))
                    
                }
                context?.addLine(to: CGPoint(x:p0x,y:p0y))
                context?.addLine(to: CGPoint(x:np1x,y:np1y))
                changeD = !changeD
                //pass last position to final draw
                (p0x,p0y) = (newp1x,newp1y)
                distance -= reduceDis
                totaldistance = 0
            }
            
            //redundant path culcalate
            xdis = pow(Double(p1x - p0x), 2)
            ydis = pow(Double(p1y - p0y), 2)
            distance = sqrt(xdis + ydis)
            
            totaldistance += distance
            
            
            if changeD {
                p0x = p0x - CGFloat(disline * sin(angle))
                p0y = p0y + CGFloat(disline * cos(angle))
                p1x = p1x - CGFloat(disline * sin(angle))
                p1y = p1y + CGFloat(disline * cos(angle))

            }else{
                p0x = p0x - CGFloat(disline * sin(angle + pi))
                p0y = p0y + CGFloat(disline * cos(angle + pi))
                p1x = p1x - CGFloat(disline * sin(angle + pi))
                p1y = p1y + CGFloat(disline * cos(angle + pi))

            }
            
            context?.addLine(to: CGPoint(x:p0x,y:p0y))
            context?.addLine(to: CGPoint(x:p1x,y:p1y))
            
            i += 1
        }
        
    }
    
    private func triLine(_ name:Int){
            
        //-------------angle calculate ---------------
        var distance:Double = 0         // two point distance
        var angle:Double = 0            // two point to x-axis angle
        var totaldistance:Double = 0    // toltal path distance
        
        var changeD = true
        let pi:Double = M_PI
        
        var tridis:Double = 5         //tri path peroid
        var disline:Double = 5         //tri path amplify
        
        let (p0x,p0y) = lines[name]![0]
        context?.move(to: CGPoint(x:p0x,y:p0y))
        
        var i = 1
        while i < lines[name]!.count {
            
            var (p0x,p0y) = lines[name]![i - 1]
            var (p1x,p1y) = lines[name]![i]
            //------------------------angle calculating-----------------------------------
            var xdis = pow(Double(p1x - p0x), 2)
            var ydis = pow(Double(p1y - p0y), 2)
            distance = sqrt(xdis + ydis)
            angle = acos(Double(p1x - p0x)/distance)
            
            // angle move along negative y case
            
            if p1y - p0y < 0{
                angle = 2*pi - angle
            }
            
            //----------------------- cut path base on tridis(tri path peroid) ---------------
            while distance  > tridis - totaldistance {
                let reduceDis:Double = tridis - totaldistance
                var (newp1x,newp1y) = (p0x + CGFloat(reduceDis * cos(angle)),p0y + CGFloat(reduceDis*sin(angle)))
                var (np1x,np1y) = (newp1x,newp1y)
                
                if changeD {
                    p0x = p0x - CGFloat(disline * sin(angle))
                    p0y = p0y + CGFloat(disline * cos(angle))
                    np1x = (newp1x - CGFloat(disline * sin(angle)) + p0x)/2
                    np1y = (newp1y + CGFloat(disline * cos(angle)) + p0y)/2
                }else{
                    p0x = p0x - CGFloat(disline * sin(angle + pi))
                    p0y = p0y + CGFloat(disline * cos(angle + pi))
                    np1x = (newp1x - CGFloat(disline * sin(angle + pi)) + p0x)/2
                    np1y = (newp1y + CGFloat(disline * cos(angle + pi)) + p0y)/2
                    
                }
//                    context?.addLine(to: CGPoint(x:p0x,y:p0y))
                context?.addLine(to: CGPoint(x:np1x,y:np1y))
                changeD = !changeD
                //pass last position to final draw
                (p0x,p0y) = (newp1x,newp1y)
                distance -= reduceDis
                totaldistance = 0
            }
            
            //redundant path culcalate
            xdis = pow(Double(p1x - p0x), 2)
            ydis = pow(Double(p1y - p0y), 2)
            distance = sqrt(xdis + ydis)
            
            totaldistance += distance
            
            
            i += 1
        }
        
    }
    
    
    
    
   
  
}
