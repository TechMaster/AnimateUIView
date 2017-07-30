//
//  AnimateItem.swift
//  DemoAnimation
//
//  Created by ThietTB on 7/21/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit

class AnimateItem: NSObject {

    //Mark:: Property
    var item : AnyObject
    var animateTime : CGFloat
    
    init(item : AnyObject , time : CGFloat) {
        self.item = item
        self.animateTime = time
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
