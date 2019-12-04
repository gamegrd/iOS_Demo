//
//  EventMonitor.swift
//  PopoverDemo
//
//  Created by 5km on 2018/6/29.
//  Copyright © 2018年 5km. All rights reserved.
//

import Cocoa

class EventMonitor {
    var mask: NSEvent.EventTypeMask
    var handler : (NSEvent?) -> ()
    var monitor: Any?
    
    init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> ()){
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    func start(){
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
    
}
