//
//  ViewController.swift
//  Goons
//
//  Created by Willy on 2022/1/10.
//

import UIKit

class ViewController: UIViewController {
    
    let button : UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.backgroundColor = UIColor.black
        button.frame = CGRect(x: 94, y: 215, width: 90, height: 40)
        button.center = view.center
        button.setTitle("下一頁", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(ButtonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
 
    }
    
    @objc func ButtonAction(_ sender: UIButton){
        
        if(sender.currentTitle == "下一頁"){
            print("下一頁")
            self.performSegue(withIdentifier: "segue_dog", sender: self)
        }
    }

}

