//
//  GameView.swift
//  GeoTools
//
//  Created by Glenn Crownover on 4/30/15.
//  Copyright (c) 2015 bluejava. All rights reserved.
//
//  Nothing to see here - I've commented all the template code out - may come in handy later.

import SceneKit

class GameView: SCNView {
    
//    override func mouseDown(theEvent: NSEvent) {
//        /* Called when a mouse click occurs */
//        
//        // check what nodes are clicked
//        let p = self.convertPoint(theEvent.locationInWindow, fromView: nil)
//        if let hitResults = self.hitTest(p, options: nil) {
//            // check that we clicked on at least one object
//            if hitResults.count > 0 {
//                // retrieved the first clicked object
//                let result: AnyObject = hitResults[0]
//                
//                // get its material
//                let material = result.node!.geometry!.firstMaterial!
//                
//                // highlight it
//                SCNTransaction.begin()
//                SCNTransaction.setAnimationDuration(0.5)
//                
//                // on completion - unhighlight
//                SCNTransaction.setCompletionBlock() {
//                    SCNTransaction.begin()
//                    SCNTransaction.setAnimationDuration(0.5)
//                    
//                    material.emission.contents = NSColor.blackColor()
//                    
//                    SCNTransaction.commit()
//                }
//                
//                material.emission.contents = NSColor.redColor()
//                
//                SCNTransaction.commit()
//            }
//        }
//        
//        super.mouseDown(theEvent)
//    }

}
