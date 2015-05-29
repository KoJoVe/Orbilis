//
//  GameScene.swift
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 23/05/15.
//  Copyright (c) 2015 Joao Nassar Galante Guedes. All rights reserved.
//

//        //De inicio, nao pode adicionar NADA
//        Welcome to orbilis!
//        You have one simple job.
//        Dont let the enviroment die with pollution.
//        Let`s see how you do this.
//        This is your organic matter. //Seta aponta para organic matter
//        You spend this to modify your enviroment.
//        Tap and hold the screen to open menu.
//        //Depois de abrir o menu
//        Lets add a tree. //Mostra seta na arvore
//        //Depois de adicionar arvore
//        Trees help decrease pollution
//        //Aparece uma fabrica
//        Once in a while, factorys will appear
//        They increase the pollution!
//        You will begin to see the...
//        pollution effects in the long term. //Chama funçao de fumaça (Joao implementa)
//        And that`s not good…
//        Lets remove this factory! //Some a fumaça
//        Tap and hold to open menu.
//        //Depois de abrir o menu
//        Tap on remove factory. //Seta aponta para fabric
//        Nice job!
//        Now, let`s add a herbivore
//        //Depois de adicionado
//        Herbivores eat trees and reproduce
//        You can add carnivores too!
//        They eat the herbivores and reproduce.
//        And, when they die…
//        …you get more organic matter!
//        Up there, is the number of days passed //Mostra para os dias
//        You can tap there…
//        …to change time speed!
//        Try to keep the environment running…
//        …for the maximum days you can!
//        Thats it! You can acess this tutorial…
//        …again, trhough the initial screen!
//        Good luck!
//
//        Transicao pra gamescene


import SpriteKit

class TutorialScene: SKScene {
    
    enum TutorialPhase{
        
        case WelcomePhase
        case AddTree
        case AddFactory
        case RemoveFactory
        case NiceJob
        case AddHerbivore
        case AddCarnivore
        case FinalPhase
        case SpeedUp
    }
    
    var currentPhase = TutorialPhase.WelcomePhase
    var currentString = 0
    let descriptionArray = ["Welcome to orbilis!","You have one simple job.","Dont let the enviroment die with pollution.","Let`s see how you do this.","This is your organic matter.","You spend this to modify your enviroment.","Lets add a tree. Tap on the add tree icon.","Trees help decrease pollution","Once in a while, factories will appear","They increase the pollution!","You will see the pollution effects in the long term.","And that`s not good…","Lets remove this factory!","Tap the remove factory icon.","Nice job!","Now, let's add a herbivore","Herbivores eat trees and reproduce","You can add carnivores too!","They eat the herbivores and reproduce.","And, when they die…","…you get more organic matter!","Up there, is the number of days passed","You can tap in the orb to change time speed!","Try to keep the environment running…", "…for the maximum days you can!","Thats it! You can acess this tutorial again.", "Just click in 'tutorial' in the initial screen!","Good luck!"]
    
    var pollutionLimits = [0,100,200,300,500]
    
    var sizeOfSprites: CGFloat = 20
    var tickTime = 2.0
    var tickTimer = NSTimer()
    var audioManager = AudioManager()
    
    var back = SKSpriteNode()
    
    var pointOrganicMatter = CGPointMake(0, 0)
    var pointOrganicMatterLabel = CGPointMake(0, 0)
    
    var screenPressed = false
    
    var islandRect = SKSpriteNode()
    
    var backgroundSprite = SKSpriteNode()
    var orbBackgroundBad = SKSpriteNode()
    var orbBackground = SKSpriteNode()
    var islandSprite = SKSpriteNode()
    var orbGlass = SKSpriteNode()
    var orbWaterBad = SKSpriteNode()
    var orbWaterFlood = SKSpriteNode()
    var orbWater = SKSpriteNode()
    var orbSand = SKSpriteNode()
    var orbCloud = SKSpriteNode()
    var orbSmoke = SKSpriteNode()
    
    var creaturesArray: Array<Lifeform> = []
    var buildingsArray: Array<Building> = []
    
    var pauseButton: SKSpriteNode?
    var organicMatterImage: SKSpriteNode?
    var descriptor: SKSpriteNode?
    var descriptorLabel: SKLabelNode?
    
    var theArrow: SKSpriteNode? //Seta apontando no tutorial
    
    var menuButtons: Array<SKSpriteNode> = []
    var menuCosts: Array<SKLabelNode> = []
    
    var organicMatterLabel: SKLabelNode?
    var presentTimeLabel: SKLabelNode?
    
    var presentTime = 0
    var pollution = 0
    var organicMatter = 400
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        var space:CGFloat = 15
        
        var prop:CGFloat = self.frame.size.width/375.0
        
        sizeOfSprites = 30 * prop
        
        var background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        self.addChild(background)
        
        drawOrb()
        drawInfo()
        drawItensMenu()
        openItensMenu()
        updateTick()
    }
    
    func drawOrb() {
        //Joao
        var spacing: CGFloat = 0
        var islandW: CGFloat = 400
        var islandH: CGFloat = 230
        
        var prop: CGFloat = self.frame.size.width/640
        var deloc: CGFloat = -35 * prop
        
        islandW = islandW * prop
        islandH = islandH * prop
        
        backgroundSprite = SKSpriteNode(imageNamed: "NormalBackground")
        backgroundSprite.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        backgroundSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        backgroundSprite.zPosition = 0
        self.addChild(backgroundSprite)
        
        back = SKSpriteNode(imageNamed: "RectBlue")
        back.size = CGSizeMake(self.frame.size.width, self.frame.size.height/8)
        back.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - backgroundSprite.size.height/2 + back.size.height/2)
        back.alpha = 0.7
        back.zPosition = 29
        self.addChild(back)
        
        orbWater = SKSpriteNode(imageNamed: "NormalIsland")
        orbWater.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbWater.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbWater.zPosition = 0
        self.addChild(orbWater)
        
        orbGlass = SKSpriteNode(imageNamed: "GlassCover")
        orbGlass.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbGlass.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbGlass.zPosition = 6
        self.addChild(orbGlass)
        
        orbSmoke = SKSpriteNode(imageNamed: "Smoke")
        orbSmoke.size = CGSizeMake(self.frame.size.width - spacing, self.frame.size.width - spacing)
        orbSmoke.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        orbSmoke.zPosition = 5
        orbSmoke.alpha = 0
        self.addChild(orbSmoke)
        
        islandSprite = SKSpriteNode()
        islandSprite.size = CGSizeMake(islandW, islandH)
        islandSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - deloc)
        self.addChild(islandSprite)
    }
    
    func drawInfo() {
        //Joao
        var textSize:CGFloat = 30
        
        descriptor = SKSpriteNode()
        descriptor!.size = CGSizeMake(self.frame.size.width/4, self.frame.size.width/4)
        descriptor!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 70)
        descriptor!.alpha = 0
        descriptor!.zPosition = 50
        self.addChild(descriptor!)
        
        redrawDescriptorText(descriptionArray[0])
        
        redrawOrganicMatter()
        
        redrawPresentTime()
        
        
    }
    
    func redrawDescriptorText(text: String) {
        
        var space:CGFloat = 0
        
        descriptorLabel?.removeFromParent()
        descriptorLabel = SKLabelNode()
        descriptorLabel!.text = text
        descriptorLabel!.fontName = "Avenir-Black"
        descriptorLabel!.fontSize = 12
        descriptorLabel!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - backgroundSprite.size.height/2 + self.frame.height/16)
        descriptorLabel!.alpha = 1
        descriptorLabel!.zPosition = 50
        self.addChild(descriptorLabel!)
        
    }
    
    func redrawOrganicMatter() {
        
        organicMatterImage = SKSpriteNode(imageNamed: "OrganicImage")
        organicMatterImage!.size = CGSizeMake(self.frame.size.width/10, self.frame.size.width/10)
        organicMatterImage!.zPosition = 2
        self.addChild(organicMatterImage!)
        
        organicMatterLabel?.removeFromParent()
        organicMatterLabel = SKLabelNode()
        organicMatterLabel!.fontName = "Avenir-Roman"
        organicMatterLabel!.text = "\(organicMatter)"
        organicMatterLabel!.fontSize = 18
        organicMatterLabel!.zPosition = 2
        self.addChild(organicMatterLabel!)
        
        var space:CGFloat = 10
        
        var difference = organicMatterLabel!.frame.size.width - organicMatterImage!.frame.size.width + space/2
        
        var y = self.frame.height - (self.frame.height - (CGRectGetMidY(self.frame) + backgroundSprite.frame.size.height/2))/2 - 15
        var x = CGRectGetMidX(self.frame) - organicMatterImage!.frame.size.width/2 - difference
        
        organicMatterImage!.position = CGPointMake(x, y)
        pointOrganicMatter.x = organicMatterImage!.position.x
        pointOrganicMatter.y = organicMatterImage!.position.y
        
        organicMatterLabel!.position = CGPointMake(x + organicMatterLabel!.frame.size.width + space, y - organicMatterLabel!.frame.size.height/2)
        pointOrganicMatterLabel.x = organicMatterLabel!.position.x
        pointOrganicMatterLabel.y = organicMatterLabel!.position.y
    }
    
    func redrawPresentTime() {
        
        presentTimeLabel?.removeFromParent()
        presentTimeLabel = SKLabelNode()
        presentTimeLabel!.text = "\(presentTime)d"
        presentTimeLabel!.fontSize = 25
        presentTimeLabel!.name = "Time"
        presentTimeLabel!.fontName = "Avenir-Roman"
        presentTimeLabel!.position = CGPointMake(presentTimeLabel!.frame.size.width/2 + 10, self.frame.height - presentTimeLabel!.frame.size.height/2 - 20)
        presentTimeLabel!.zPosition = 2
        self.addChild(presentTimeLabel!)
    }
    
    func drawItensMenu() {
        
        var menuItens = Actions.getActionsArray()
        
        var count = CGFloat(menuItens.count)
        
        var textSize:CGFloat = 20
        
        var buttonSize:CGFloat = ((CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2 + 20) - (self.frame.size.width/10) - (textSize + 10))
        var buttonsSpace:CGFloat = 0
        
        if(buttonSize * CGFloat(menuItens.count) >= self.frame.size.width - 10) {
            buttonSize = buttonSize - 30
            buttonsSpace = (self.frame.size.width - (buttonSize * CGFloat(menuItens.count)))/CGFloat(menuItens.count + 1)
        } else {
            buttonsSpace = (self.frame.size.width - (buttonSize * CGFloat(menuItens.count)))/CGFloat(menuItens.count + 1)
        }
        
        var counter:CGFloat = 1
        
        for i in menuItens {
            
            var x = counter*buttonsSpace + buttonSize/2 + (counter-1)*buttonSize
            var y:CGFloat = (CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2 + 20)/2
            
            var button = Actions.getActionButton(i)
            button!.size = CGSizeMake(buttonSize, buttonSize)
            button!.position = CGPointMake(x, y)
            button!.name = i
            button!.alpha = 0
            button!.zPosition = 2
            menuButtons.append(button!)
            self.addChild(button!)
            
            var label = SKLabelNode()
            label.text = "\(Actions.getActionCost(i,timesExecuted: 0))"
            label.fontName = "Avenir-Roman"
            label.fontSize = 16
            label.position = CGPointMake(x, y - buttonSize/2 - label.frame.size.height/2 - (textSize - 10))
            label.alpha = 0
            label.zPosition = 2
            menuCosts.append(label)
            self.addChild(label)
            
            counter++
        }
    }
    
    func openItensMenu() {
            //Show itens menu
            var action = SKAction.fadeAlphaTo(1, duration: 0.2)
            var move = SKAction.moveTo(CGPointMake(pointOrganicMatter.x, CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2 + 20 - organicMatterImage!.frame.size.height/2), duration: 0.2)
            var moveText = SKAction.moveTo(CGPointMake(pointOrganicMatterLabel.x, CGRectGetMidY(self.frame) - backgroundSprite.frame.size.height/2 + 20 - organicMatterImage!.frame.size.height/2 - organicMatterLabel!.frame.size.height/2), duration: 0.2)
            
            for i in menuButtons {
                i.runAction(action)
            }
            for i in menuCosts {
                i.runAction(action)
            }
            
//            organicMatterImage?.runAction(move)
//            organicMatterLabel?.runAction(moveText)
            
            if (currentString == 6){
                updateTutorialForPhase()
            }
            
            if (currentString == 14){
                updateTutorialForPhase()
            }
            
        
    }
    
    func showDescriptorToMenu(type: String) {
        var action = SKAction.sequence([
            SKAction.fadeAlphaTo(1, duration: 0.2),
            SKAction.fadeAlphaTo(0, duration: 0.8)
            ])
        tickTime = 0.8
        descriptor!.runAction(action)
        descriptor!.texture = Actions.getActionDescriptor(type)
        descriptorLabel!.runAction(action)
        redrawDescriptorText(Actions.getActionText(type)!)
    }
    
    func hideDescriptor() {
        var action = SKAction.fadeAlphaTo(0, duration: 0.2)
        descriptor!.runAction(action)
        descriptorLabel!.runAction(action)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        println(currentString)
        if (currentPhase == TutorialPhase.WelcomePhase || currentPhase == TutorialPhase.AddFactory||currentPhase == TutorialPhase.NiceJob||currentPhase == TutorialPhase.FinalPhase){
            updateTutorialForPhase()
            return
        }
        for touch in (touches as! Set<UITouch>) {
            
            var name = nodeAtPoint(touch.locationInNode(self)).name
            
            
            if (currentString == 22){
                if (orbGlass.containsPoint(touch.locationInNode(self))){
                showDescriptorToMenu("2x")
                updateTutorialForPhase()
                }else{
                    return
                }
            }
            if (currentString == 6){
                if (name != "AddTree"){
                    return
                }
            }
            
            if (currentPhase == TutorialPhase.AddHerbivore){
                if (name != "AddHerb"){
                    return
                }
            }
            
            if (currentPhase == TutorialPhase.AddCarnivore){
                if (name != "AddCarn"){
                    return
                }
            }
            if (currentString == 13){
                if (name != "RemoveFactory"){
                   
                    return
                }
            }
            var options = Actions.getActionsArray()
            
            for i in options {
                if name == i { //Name = AddTree or AddHerb or AddCarn or RemoveFactory
                    if(organicMatter < Actions.getActionCost(i,timesExecuted: 0)) {
                        //Not enough matter
                    } else {
                        executeGameAction(i)
                        organicMatterLabel?.text = "\(organicMatter)"
                    }
                    
                }
            }
            
        }

        
    }
    
   
    
    func updateTutorialForPhase(){
        
        currentString++
        if (currentString < descriptionArray.count){
            redrawDescriptorText(descriptionArray[currentString])
        } else {
            endTut()
        }
        
        switch(currentString){
        case 4:
            addArrowForSprite(organicMatterLabel!)
            break
        case 5:
            theArrow?.alpha = 0.0
            break
        case 6:
            addArrowForSprite(menuButtons[0])
            currentPhase = TutorialPhase.AddTree
            break
        case 7:
            menuButtons[0].removeAllChildren()
            currentPhase = TutorialPhase.AddFactory
            break
        case 8:
            executeGameAction("AddFactory")
            break
        case 10:
            orbSmoke.runAction(SKAction.fadeAlphaTo(1.0, duration: 0.5))
            break
        case 13:
            currentPhase = TutorialPhase.RemoveFactory
            addArrowForSprite(menuButtons[3])
            break
        case 14:
            orbSmoke.runAction(SKAction.fadeAlphaTo(0, duration: 0.5))
            currentPhase = TutorialPhase.NiceJob
            menuButtons[3].removeAllChildren()
            break
        case 16:
            currentPhase = TutorialPhase.AddHerbivore
            addArrowForSprite(menuButtons[1])
            break
        case 17:
            currentPhase = TutorialPhase.FinalPhase
            menuButtons[1].removeAllChildren()
            break
        case 18:
            currentPhase = TutorialPhase.AddCarnivore
            addArrowForSprite(menuButtons[2])
            break
        case 19:
            currentPhase = TutorialPhase.FinalPhase
            menuButtons[2].removeAllChildren()
            break
        case 21:
            addArrowForSprite(presentTimeLabel!)
            break
        case 22:
            currentPhase = TutorialPhase.SpeedUp
            theArrow?.removeFromParent()
            break
        case 23:
            currentPhase = TutorialPhase.FinalPhase
            break
        default:
            break
        }
    }
    
    func addArrowForSprite(sprite:SKNode){
        
        theArrow?.removeFromParent()
        theArrow = SKSpriteNode(texture: SKTexture(imageNamed: "Seta"))
        theArrow?.size = CGSizeMake(30, 40)
        theArrow?.zPosition = 100
        
        if (sprite == presentTimeLabel){
            theArrow?.texture = SKTexture(imageNamed: "SetaUp")
            self.addChild(theArrow!)
            theArrow?.position = CGPointMake(30, self.view!.frame.size.height - 60)
        }
        else if (sprite == organicMatterLabel){
            theArrow?.position = CGPointMake(-20, 50)
            sprite.addChild(theArrow!)
        }else {
            theArrow?.position = CGPointMake(0, 50)
            sprite.addChild(theArrow!)
        }
        
    }
    
    func updateTick() {
        
        deleteMarkedEntities()
        checkForCollisions()
        moveAndAgeEntities()
        calculatePollution()
        
        presentTime++
        
        redrawPresentTime()
        
        tickTimer = NSTimer.scheduledTimerWithTimeInterval(tickTime, target: self, selector: Selector("updateTick"), userInfo: nil, repeats: false)
    }
    
    func deleteMarkedEntities() {
        
        //PODE TER ERRO AQUI!!!!!
        for var i = 0; i<creaturesArray.count; i++ {
            if(creaturesArray[i].aboutToDelete == 1) {
                creaturesArray[i].die()
                creaturesArray.removeAtIndex(i)
            }
        }
    }
    
    func checkForCollisions() {
        
        for var i = 0; i < creaturesArray.count; i++ {
            for var j = 0; j < creaturesArray.count; j++ {
                if(i != j) {
                    if(CGRectIntersectsRect(creaturesArray[i].frame, creaturesArray[j].frame)) {
                        if(creaturesArray[i].aboutToDelete == 0 && creaturesArray[j].aboutToDelete == 0)
                        {
                            manageCollision(creaturesArray[i],c2: creaturesArray[j])
                        }
                    }
                }
            }
        }
    }
    
    func manageCollision(c1: Lifeform, c2: Lifeform) {
        
        var interaction1 = c1.interact(c2)
        if(interaction1 == true) {
            var new = c1.reproduce()
            if(new != nil) {
                creaturesArray.append(new!)
                islandSprite.addChild(new!)
            }
        }
        
        var interaction2 = c2.interact(c1)
        if(interaction2 == true) {
            var new = c2.reproduce()
            if(new != nil) {
                creaturesArray.append(new!)
                islandSprite.addChild(new!)
            }
        }
    }
    
    func moveAndAgeEntities() {
        
        for i in creaturesArray {
            i.move(islandSprite.frame,time: tickTime)
            if(i.lifeTime > i.lifeTimeMax && i.aboutToDelete == 0) {
                i.animateToDie()
                i.aboutToDelete = 1
                organicMatter += i.organicProduction
                organicMatterLabel?.text = "\(organicMatter)"
            }
        }
    }
    
    func executeGameAction(type: String) {
        
        if (currentString == 6){
            updateTutorialForPhase()
            
        }
        
        if (currentString == 13){
            updateTutorialForPhase()
            
        }
        if (currentString == 16){
            updateTutorialForPhase()
            
        }
        if (currentString == 18){
            updateTutorialForPhase()
            
        }
        var new = Actions.executeAction(type, size: sizeOfSprites, rect: islandSprite.frame)
        
        if(new.node != nil) {
            if(new.type == "Lifeform") {
                creaturesArray.append(new.node! as! Lifeform)
                self.islandSprite.addChild(new.node! as! Lifeform)
                organicMatter -= Actions.getActionCost(type,timesExecuted: 0)
            } else if (new.type == "Building") {
                buildingsArray.append(new.node! as! Building)
                self.islandSprite.addChild(new.node! as! Building)
            } else if (new.type == "RemoveFactory") {
                if(buildingsArray.count >= 1) {
                    buildingsArray[0].destroy()
                    buildingsArray.removeAtIndex(0)
                    organicMatter -= Actions.getActionCost(type,timesExecuted: 0)
                }
            }
        }
    }
    
    func calculatePollution() {
        
        println(pollution)
        
        for i in buildingsArray {
            pollution += i.pollutionRate
        }
        
        for i in creaturesArray {
            pollution += i.pollutionIncrement
        }
        
        if(pollution < 0) {
            pollution = 0
        }
        
        if(pollution <= pollutionLimits[0]) {
            rain()
        } else if(pollution <= pollutionLimits[1]) {
            smoke()
        } else if(pollution <= pollutionLimits[2]) {
            acidRain()
        } else if(pollution <= pollutionLimits[3]) {
            darkenColor()
        } else if(pollution >= pollutionLimits[4]) {
            loseGame()
        }
        
        for i in creaturesArray {
            if(i.chanceToDie(pollution) == true) {
                i.animateToDie()
                i.aboutToDelete = 1
            }
        }
    }
    
    func chanceSpawnFactory() {
        //Chance de spawnar fabrica
        var r = random(1...10)
        
        if(r<=1) {
            executeGameAction("AddFactory")
        }
        
    }
    
    func rain() {
        
    }
    
    func smoke() {
        
    }
    
    func acidRain() {
        
    }
    
    func darkenColor() {
        
    }
    
    func loseGame() {
        //Anima enchete e abre proxima cena.

    }
    
    func endTut() {
        
        var action = SKAction.resizeToWidth(self.frame.width/3, height: self.frame.width/3, duration: 0.4)
        var action2 = SKAction.moveTo(CGPointMake(self.frame.width/2, self.frame.height/2 + 30), duration: 0.4)
        
        orbGlass.runAction(action)
        orbGlass.runAction(action2)
        backgroundSprite.runAction(action)
        backgroundSprite.runAction(action2)
        orbWater.runAction(action)
        orbWater.runAction(action2)
        
        for i in creaturesArray {
            i.removeFromParent()
        }
        
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("nextScene"), userInfo: nil, repeats: false)
    }
    
    func nextScene() {
        
        var scene = StartScene(size:self.size)
        
        self.scene!.view?.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.6))
        
    }
    
    func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
