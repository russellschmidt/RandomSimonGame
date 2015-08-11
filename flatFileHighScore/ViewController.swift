//
//  ViewController.swift
//  flatFileHighScore
//
//  Created by Russell Schmidt on 8/6/15.
//  Copyright (c) 2015 RussellSchmidt.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var time: UILabel!
  @IBOutlet weak var score: UILabel!
  @IBOutlet weak var name: UITextField!

  @IBOutlet weak var upperLeftButtonOutlet: UIButton!
  @IBOutlet weak var upperRightButtonOutlet: UIButton!
  @IBOutlet weak var lowerLeftButtonOutlet: UIButton!
  @IBOutlet weak var lowerRightButtonOutlet: UIButton!

  let counterStart = 100 //starting tenth of seconds
  var redSquareInterval = 5 // milliseconds between new red squares appearing
  var counter = 0
  var points = 0
  var timer = NSTimer()

  let path = NSBundle.mainBundle().pathForResource("HighScores", ofType: "plist")!


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // set the counter variable to the starting timer allotment
    counter = counterStart

    self.time.text = "\(counter)"
    self.score.text = "\(points)"

    // set background color
    self.lowerRightButtonOutlet.backgroundColor = UIColor.grayColor()
    self.upperLeftButtonOutlet.backgroundColor = UIColor.grayColor()
    self.upperRightButtonOutlet.backgroundColor = UIColor.grayColor()
    self.lowerLeftButtonOutlet.backgroundColor = UIColor.grayColor()
    // set text color
    self.lowerRightButtonOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    self.upperLeftButtonOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    self.upperRightButtonOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    self.lowerLeftButtonOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func startGameButton(sender: AnyObject) {
    // launch timer with launches game

    // if the counter already reached zero, restart game on press
    if counter == 0 {
      counter = counterStart
      points = 0
      score.text = "\(points)"
      time.text = "\(counterStart)"
    }

    timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("countdownCounter"), userInfo: nil, repeats: true)


  }
  @IBAction func upperLeftButton(sender: AnyObject) {
    // if the color is red, and button is pressed, record a point.
    if upperLeftButtonOutlet.backgroundColor == UIColor.redColor() {
      scorePoint()
      upperLeftButtonOutlet.backgroundColor = UIColor.grayColor()
    }
  }
  @IBAction func upperRightButton(sender: AnyObject) {
    if upperRightButtonOutlet.backgroundColor == UIColor.redColor() {
      scorePoint()
      upperRightButtonOutlet.backgroundColor = UIColor.grayColor()
    }
  }
  @IBAction func lowerLeftButton(sender: AnyObject) {
    if lowerLeftButtonOutlet.backgroundColor == UIColor.redColor() {
      scorePoint()
      lowerLeftButtonOutlet.backgroundColor = UIColor.grayColor()
    }
  }
  @IBAction func lowerRightButton(sender: AnyObject) {
    if lowerRightButtonOutlet.backgroundColor == UIColor.redColor() {
      scorePoint()
      lowerRightButtonOutlet.backgroundColor = UIColor.grayColor()
    }
  }

  func randomColor() {
    var randomColorNumber = Int(arc4random_uniform(UInt32(5)))
    switch randomColorNumber {
    case 0:
      self.lowerRightButtonOutlet.backgroundColor = UIColor.redColor()
    case 1:
      self.upperLeftButtonOutlet.backgroundColor = UIColor.redColor()
    case 2:
      self.upperRightButtonOutlet.backgroundColor = UIColor.redColor()
    case 3:
      self.lowerLeftButtonOutlet.backgroundColor = UIColor.redColor()
    default:
      self.lowerRightButtonOutlet.backgroundColor = UIColor.redColor()
      self.upperLeftButtonOutlet.backgroundColor = UIColor.redColor()
      self.upperRightButtonOutlet.backgroundColor = UIColor.redColor()
      self.lowerLeftButtonOutlet.backgroundColor = UIColor.redColor()
    }
  }


  func countdownCounter () {
    // handles countdown output and launches save game function at zero
    // also handles random background colors



    if counter == 0 {
      // stop timer at 0
      timer.invalidate()
      // save score to high score plist
      saveScore()
    } else {
    counter--
    self.time.text = "\(counter)"
      if counter % redSquareInterval == 0 {
        randomColor()
      }
    }
  }

  func scorePoint () {
    // no cheating! only tap buttons while timer is running
    if (counter > 0) && (counter < counterStart) {
      points++
      self.score.text = "\(points)"
    }
  }

  func outputUserNameForHighScore() -> String {
    // format the user name with a timestamp and allow for lazy no-name users
    var transformedName = ""
    var timeString = ""

    /*
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.timeStyle = .MediumStyle
    timeString = formatter.stringFromDate(date)
    */
    
    if name.text != "" {
      transformedName = "\(name.text)" //\(timeString)"
    } else {
      transformedName = "Lazy No-Name" // \(timeString)"
    }

    return transformedName
  }

  func saveScore() {

    var scoreArray = NSMutableArray()

    scoreArray = [outputUserNameForHighScore(),
      score.text!,
      "\(counterStart/10) sec",
      "PPS: \(10 * (Double(points)/Double(counterStart)))"
    ]

    var myPListArray = NSMutableArray(contentsOfFile: path)!
    myPListArray.addObject(scoreArray)

    var didISave = myPListArray.writeToFile(path, atomically: true)
    if (!didISave) {
      println("cant save")
    }
  }

}

