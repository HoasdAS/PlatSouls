//
//  GameScene.swift
//  Platform Souls
//
//  Created by Alumnoids on 24/04/18.
//  Copyright © 2018 Alumnoids. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var isRight : Bool = false
    var isLeft : Bool = false
    
    
    var thePlayer:SKSpriteNode = SKSpriteNode()
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    
    override func didMove(to view: SKView) {
        
        tapRec.numberOfTouchesRequired = 2
        tapRec.numberOfTapsRequired = 3
        
        swipeRightRec.addTarget(self, action: #selector(GameScene.swipedRight) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        
        if let somePlayer:SKSpriteNode = self.childNode(withName: "Dude") as? SKSpriteNode {
            thePlayer = somePlayer
            thePlayer.physicsBody?.isDynamic = true
        }
     }
    
    //Esto detecta los gestos
    
    
    @objc func tappedView() {
        print("THREE TAPS")
    }
    
    @objc func swipedRight() {
        print("right")
    }
    
    @objc func swipedLeft() {
        print("left")
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    
    //lo    que hace que se pueda mover el personaje
    
    func touchDown(atPoint pos : CGPoint) {
        print("touched \( pos.x)")
        print("touched \( pos.y)")
        
        var wait:SKAction = SKAction.wait(forDuration: 0.01)
        //let walkAnimation:SKAction = SKAction(named: "TEST")
        
        var moveAction:SKAction
        
        if (pos.x < self.size.width/2){
            isLeft = true
            moveAction =  SKAction.moveBy(x: -30, y: 0, duration: 0.5)
            print("Left")
            thePlayer.run(moveAction)
        }
        
        if(pos.x > self.size.width/2){
            moveAction =  SKAction.moveBy(x: 30, y: 0, duration: 0.5)
            isRight = true
            print("Right")
            thePlayer.run(moveAction)
        }
        
        if (pos.x < self.size.width/2 ||  pos.y < self.size.width/2){
            isLeft = true
            moveAction =  SKAction.moveBy(x: -30, y: 20, duration: 0.5)
            wait = SKAction.wait(forDuration: 0.7)
            print("Left Up")
            thePlayer.run(moveAction)
            thePlayer.run(wait)
        }
        
        if(pos.x > self.size.width/2 ||  pos.y < self.size.width/2){
            moveAction =  SKAction.moveBy(x: 30, y: 20, duration: 0.5)
            wait = SKAction.wait(forDuration: 0.7)
            isRight = true
            print("Right Up")
            thePlayer.run(moveAction)
            thePlayer.run(wait)
        }
        
        
        
    }
    
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
}
