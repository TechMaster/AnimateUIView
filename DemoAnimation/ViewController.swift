//
//  ViewController.swift
//  DemoAnimation
//
//  Created by ThietTB on 7/17/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var disk: UIView! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.disk = UIView(frame: CGRect(x: 10, y: 100, width: 100, height: 24))
        self.disk.backgroundColor = UIColor.blue
        self.view.addSubview(self.disk)
        
        // Add to queue
        self.disk.animatingQueue.enqueue(AnimateItem(item: CGPoint(x: 200, y: 200) as CGPoint as AnyObject, time: 2))
        self.disk.animatingQueue.enqueue(AnimateItem(item: UIColor.red as UIColor as AnyObject, time: 2))
        self.disk.animatingQueue.enqueue(AnimateItem(item: CGAffineTransform(rotationAngle: CGFloat.pi/2) as CGAffineTransform as AnyObject, time: 2))
        self.disk.animatingQueue.enqueue(AnimateItem(item: CGPoint(x: 200, y: 400) as CGPoint as AnyObject, time: 1))

        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.disk.animate()
    }

    
}









