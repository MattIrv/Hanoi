//
//  GameScene.swift
//  Hanoi
//
//  Created by Matthew Irvine on 9/15/15.
//  Copyright (c) 2015 Matthew Irvine. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    static let baseXDistanceFraction: CGFloat = 1.0 / 5.0
    static let baseYDistanceFraction: CGFloat = 1.0 / 3.0
    static let baseHeightFraction: CGFloat = 1.0 / 50.0
    static let baseWidthFraction: CGFloat = 1.0 / 5.0
    static let baseFillColor = UIColor.brownColor()
    static let baseStrokeColor = UIColor.blackColor()
    
    var discs: Array<Disc>!
    var bases: Array<SKShapeNode>!
    
    class Disc: NSObject {
        var color: UIColor
        var size: Int
        var base: Int
        
        init(color: UIColor, size: Int) {
            self.color = color
            self.size = size
            self.base = 1
        }
    }
    
    override func didMoveToView(view: SKView) {
        self.setupBases()
        self.setupDiscs()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func initializeDiscsForCount(discCount: Int) {
        let colors = [UIColor.redColor(), UIColor.orangeColor(), UIColor.blueColor(), UIColor.purpleColor(), UIColor.cyanColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.lightGrayColor()]
        var discs = [Disc]()
        for (i, color) in colors.enumerate() {
            discs.append(Disc(color: color, size: i + 1))
        }
        self.discs = discs
    }
    
    private func setupBases() {
        let maxX = CGRectGetMaxX(self.frame)
        let maxY = CGRectGetMaxY(self.frame)
        let xPositionMultipliers: Array<CGFloat> = [1.0, 2.5, 4.0]
        
        let baseWidth = maxX * GameScene.baseWidthFraction
        let baseHeight = maxY * GameScene.baseHeightFraction
        let baseSize = CGSize(width: baseWidth, height: baseHeight)
        let baseWidthOffset = baseWidth / 2.0
        let baseYPosition = maxY * GameScene.baseYDistanceFraction
        let origins = xPositionMultipliers.map { CGPoint(x: $0 * maxX * GameScene.baseXDistanceFraction - baseWidthOffset, y: baseYPosition) }
        let baseNodes = origins.map { SKShapeNode(rect: CGRect(origin: $0, size: baseSize)) }
        baseNodes.forEach { (node) -> () in
            node.fillColor = GameScene.baseFillColor
            node.strokeColor = GameScene.baseStrokeColor
            self.addChild(node)
        }
        self.bases = baseNodes
    }
    
    private func setupDiscs() {
        
    }
}
