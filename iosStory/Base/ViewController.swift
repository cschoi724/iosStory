//
//  ViewController.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/10.
//

import UIKit

class ViewController: UIViewController {

    var fromUser : User!
    var toUser : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //테스트
        // Do any additional setup after loading the view.
    }

    @IBAction func oepnList(_ sender: Any) {
        let view = StoryListView()
        view.frame = UIScreen.main.bounds
        self.view.addSubview(view)
    }
    
    @IBAction func openSend(_ sender: Any) {
        let view = StorySendView()
        view.frame = UIScreen.main.bounds
        self.view.addSubview(view)
    }
}

