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
    static let discCornerRadius: CGFloat = 5.0
    static let xPositionMultipliers: Array<CGFloat> = [1.0, 2.5, 4.0]
    static let discWidthFraction: CGFloat = 0.95
    static let discHeightFraction: CGFloat = baseHeightFraction * 2.6
    
    var discs: Array<Disc>!
    var bases: Array<Base>!
    
    class Disc: NSObject {
        var color: UIColor
        var size: Int
        var base: Int
        var node: SKShapeNode?
        
        init(color: UIColor, size: Int) {
            self.color = color
            self.size = size
            self.base = 0
            self.node = nil
        }
    }
    
    class Base: NSObject {
        var node: SKShapeNode?
        var discStack: [Disc]
        
        init(node: SKShapeNode) {
            self.node = node
            self.discStack = []
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
            if i == discCount {
                break
            }
            discs.append(Disc(color: color, size: 8 - i))
        }
        self.discs = discs
    }
    
    private func setupBases() {
        let maxX = CGRectGetMaxX(self.frame)
        let maxY = CGRectGetMaxY(self.frame)
        let xPositionMultipliers = GameScene.xPositionMultipliers
        
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
        self.bases = baseNodes.map { Base(node: $0) }
    }
    
    private func setupDiscs() {
        let maxX = CGRectGetMaxX(self.frame)
        let maxY = CGRectGetMaxY(self.frame)
        let baseWidth = maxX * GameScene.baseWidthFraction
        let baseHeight = maxY * GameScene.baseHeightFraction
        let xPositionMultipliers = GameScene.xPositionMultipliers
        let discHeight = GameScene.discHeightFraction * maxY
        let discs = self.discs.sort { (disc1, disc2) -> Bool in
            disc1.size > disc2.size
        }
        
        for disc in discs {
            let baseNum = disc.base
            let base = self.bases[baseNum]
            let discPositionInStack = base.discStack.count
            base.discStack.append(disc)
            let discWidth = GameScene.discWidthFraction * baseWidth * CGFloat(disc.size) / 8.0
            let xPosition = xPositionMultipliers[baseNum] * maxX * GameScene.baseXDistanceFraction - (discWidth / 2.0)
            let baseYPosition = GameScene.baseYDistanceFraction * maxY + baseHeight
            let yOffsetForDiscs = (CGFloat(discPositionInStack) * discHeight) + 1.0 * (CGFloat)(discPositionInStack + 1)
            let yPosition = baseYPosition + yOffsetForDiscs
            let discRect = CGRect(x: xPosition, y: yPosition, width: discWidth, height: discHeight)
            let node = SKShapeNode(rect: discRect, cornerRadius: GameScene.discCornerRadius)
            node.fillColor = disc.color
            self.addChild(node)
            disc.node = node
        }
    }
}
