//
//  AniView.swift
//  DemoAnimation
//
//  Created by cuong on 7/28/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit
import Foundation

private var queueKey: UInt8 = 10 // We still need this boilerplate

extension UIView {
    
    var animatingQueue: Queue<AnimateItem> {
        get {
            if let associated = objc_getAssociatedObject(self, &queueKey)
                as? Queue<AnimateItem> { return associated }
            
            let associated = Queue<AnimateItem>()
            
            objc_setAssociatedObject(self, &queueKey, associated,
                                     .OBJC_ASSOCIATION_RETAIN)
            return associated
            
        }
        set {
            objc_setAssociatedObject(self, &queueKey, newValue,
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    //Mark: Function
    func animate(){
        if (animatingQueue.count > 0){
            let dequeue = self.animatingQueue.dequeue()
            let item : AnyObject = dequeue?.item as AnyObject
            let time : CGFloat = (dequeue?.animateTime)! as CGFloat
            UIView.animate(withDuration: TimeInterval(time), animations: {
                if item is CGPoint{
                    self.center = item as! CGPoint
                }
                if item is UIColor{
                    self.backgroundColor = item as? UIColor
                }
                if item is CGAffineTransform{
                    self.transform = item as! CGAffineTransform
                }
            }, completion: { (finished) in
                self.animate()
            })
            
            
        }
        
    }

}
