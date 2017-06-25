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
    
    private func drawInit(){
        context = UIGraphicsGetCurrentContext()
        
    }
    
    func changeType(_ num:Int){
        typedraw = num
    }
    
    override func draw(_ rect: CGRect) {
        
        if !isInit {drawInit()}
        
//        typedraw = 2
        
        switch typedraw {
        case 1:
            randrectLine()
        case 2:
            rectLine()
        case 3:
            triLine()
        default:
            normalLine()
        }
        
    }
    
    private func normalLine(){
        for name in 1..<lines.count{
            
            if lines[name]!.count < 1 {continue}
            
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            
            let (p0x,p0y) = lines[name]![0]
            context?.move(to: CGPoint(x:p0x,y:p0y))
            
            var i = 1
            while i < lines[name]!.count {
                let (p1x,p1y) = lines[name]![i]
                context?.addLine(to: CGPoint(x:p1x,y:p1y))
                i += 1
            }
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
    }
    
    private func randrectLine(){
        for name in 1..<lines.count{
            
            if lines[name]!.count < 1 {continue}
            
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            
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
                
                print("---------")
                print(angle)
                print(p1x - p0x)
                
                if changeD {
                   
                    p0x = p0x - CGFloat(disline * sin(angle))
                    p0y = p0y + CGFloat(disline * cos(angle))
                    p1x = p1x - CGFloat(disline * sin(angle))
                    p1y = p1y + CGFloat(disline * cos(angle))
                    changeD = false
                }else{
                
                    p0x = p0x - CGFloat(disline * sin(angle + pi))
                    p0y = p0y + CGFloat(disline * cos(angle + pi))
                    p1x = p1x - CGFloat(disline * sin(angle + pi))
                    p1y = p1y + CGFloat(disline * cos(angle + pi))
                    changeD = true
                }
            
                context?.addLine(to: CGPoint(x:p0x,y:p0y))
                context?.addLine(to: CGPoint(x:p1x,y:p1y))

                i += 1
            }
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
    }
    
    private func rectLine(){
        for name in 1..<lines.count{
            
            if lines[name]!.count < 1 {continue}
            
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            
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
            
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
    }
    
    private func triLine(){
        for name in 1..<lines.count{
            
            if lines[name]!.count < 1 {continue}
            
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            
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
            
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        relines = [0:[]]
        relineCount = 0
        lineCount += 1
        line.append((point!.x,point!.y))
        lines[lineCount] = line
//        print("move=>relineCount = \(relineCount):lineCount = \(lineCount)")
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        line.append((point!.x,point!.y))
        lines[lineCount] = line
        setNeedsDisplay()
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
            print("updo=>relineCount = \(relineCount):lineCount = \(lineCount)")
            setNeedsDisplay()
        }
    }
    
    func redo(){
        if relineCount > 0{
            lineCount += 1
            lines[lineCount] = relines.removeValue(forKey: relineCount)
            relineCount -= 1
            print("redo=>relineCount = \(relineCount):lineCount = \(lineCount)")
            setNeedsDisplay()
        }
        
    }
    func clear(){
        lines = [0:[]]
        lineCount = 0
        setNeedsDisplay()
    }

  
}
