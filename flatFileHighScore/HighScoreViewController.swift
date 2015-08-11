//
//  HigScoreViewController.swift
//  flatFileHighScore
//
//  Created by Russell Schmidt on 8/7/15.
//  Copyright (c) 2015 RussellSchmidt.net. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  let path = NSBundle.mainBundle().pathForResource("HighScores", ofType: "plist")!

  var scoreArray = NSArray()

  @IBOutlet weak var tetsLAbel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        var fileArray = NSArray(contentsOfFile: path)!

        scoreArray = fileArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var fileArray = NSArray(contentsOfFile: path)
    return fileArray!.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("scoreCell") as! UITableViewCell

      cell.textLabel?.text = "😃\(scoreArray[indexPath.row][0]). 🎯\(scoreArray[indexPath.row][1]). ⏰\(scoreArray[indexPath.row][2]). \(scoreArray[indexPath.row][3])"

      cell.textLabel?.numberOfLines = 0

    return cell

  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

  }

}
