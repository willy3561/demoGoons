//
//  DogViewController.swift
//  Goons
//
//  Created by Willy on 2022/1/10.
//

import UIKit

class DogViewController: UIViewController {
    
    var topBarHeight: CGFloat {
        let h = (self.navigationController?.navigationBar.frame.height ?? 0.0)
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + h
        } else {
            return UIApplication.shared.statusBarFrame.size.height + h
        }
    }
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .black
        sv.delegate = self
        return sv
    }()
    let labelNavBar = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Do any additional setup after loading the view.
        view.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1200/*cgfloatHeightRatio*/)
        scrollView.isScrollEnabled = true
        
        
        labelNavBar.backgroundColor = .white
        labelNavBar.alpha = 0
        labelNavBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)
        view.addSubview(labelNavBar)

        let labelNavTitle = UILabel()
        labelNavTitle.text = "果思設計"
        labelNavTitle.sizeToFit()
        labelNavTitle.center = labelNavBar.center
        labelNavTitle.frame = CGRect(x: labelNavTitle.frame.minX, y: labelNavTitle.frame.minY+10, width: labelNavTitle.frame.width, height: labelNavTitle.frame.height)

        labelNavBar.addSubview(labelNavTitle)
        
        
        
        let buttonBack = UIButton()
        buttonBack.setImage(UIImage(named: "icons8-back-24.png"), for: .normal)
        buttonBack.frame = CGRect(x: 20, y: 30, width: 24, height: 24)
        buttonBack.addTarget(self, action: #selector(ButtonAction(_:)), for: .touchUpInside)
        buttonBack.tag = 0
        view.addSubview(buttonBack)
        
        let dogImageView = UIImageView()
        dogImageView.image = UIImage(named: "dog.jpg")
        dogImageView.sizeToFit()
        let imageDogHeight = UIScreen.main.bounds.size.width / dogImageView.frame.width * dogImageView.frame.height
        let imageDogWidth = 300 / imageDogHeight * UIScreen.main.bounds.size.width
        dogImageView.frame = CGRect(x: -37.5, y: -20, width: imageDogWidth, height: 300)
        scrollView.addSubview(dogImageView)
        
        let labelGoonsTitle = UILabel()
        labelGoonsTitle.text = "果思設計"
        labelGoonsTitle.textColor = .white
        labelGoonsTitle.frame = CGRect(x: buttonBack.frame.minX, y: buttonBack.frame.height+buttonBack.frame.minY, width: 24, height: 24)
        labelGoonsTitle.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        labelGoonsTitle.sizeToFit()
        scrollView.addSubview(labelGoonsTitle)

        let labelGoonsSubtitle = UILabel()
        labelGoonsSubtitle.text = "iOS APP"
        labelGoonsSubtitle.textColor = .white
        labelGoonsSubtitle.frame = CGRect(x: buttonBack.frame.minX, y: labelGoonsTitle.frame.height+labelGoonsTitle.frame.minY, width: 24, height: 24)
        labelGoonsSubtitle.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        labelGoonsSubtitle.sizeToFit()
        scrollView.addSubview(labelGoonsSubtitle)
        
        let labelRed = UILabel()
        labelRed.backgroundColor = .red
        labelRed.frame = CGRect(x: 0, y: 230, width: UIScreen.main.bounds.size.width, height: 980)
        labelRed.layer.mask = self.configRectCorner(view: labelRed, corner: .topRight, radii: CGSize(width: 48, height: 48))
        scrollView.addSubview(labelRed)
        
        
 
    }
    
    func configRectCorner(view: UIView, corner: UIRectCorner, radii: CGSize) -> CALayer{
        
        let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: radii)
        let maskLayer = CAShapeLayer.init()
        
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        
        return maskLayer
    }
    
    @objc func ButtonAction(_ sender: UIButton){
        
        if(sender.tag == 0){
            print("buttonBack")
            let viewFake = UIView()
            let btnFake = UIButton()
            viewFake.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            viewFake.backgroundColor = .white
            btnFake.backgroundColor = UIColor.black
            btnFake.frame = CGRect(x: 94, y: 215, width: 90, height: 40)
            btnFake.center = viewFake.center
            btnFake.setTitle("下一頁", for: UIControl.State.normal)
            viewFake.addSubview(btnFake)
            
            self.view.superview?.insertSubview(viewFake, belowSubview: self.view)
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)

            UIView.animate(withDuration: 0.5,
                                  delay: 0.0,
                           options: .curveEaseInOut,
                             animations: {
                self.view.transform = CGAffineTransform(translationX: self.view.frame.size.width, y: 0)
                                    },
                            completion: { finished in
                                self.dismiss(animated: false)
                                        }
                            )
        }
    }
    
}

extension DogViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let panGestureRecognizer = scrollView.panGestureRecognizer
        let velocity = panGestureRecognizer.velocity(in: scrollView)
        let y = velocity.y

        if (y > 0) {
            print("scrollView.contentOffset.y =  \(scrollView.contentOffset.y)")
            if scrollView.contentOffset.y < 450 {
                if self.labelNavBar.alpha > 0 {
                    self.labelNavBar.alpha = self.labelNavBar.alpha - 0.025
                    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                }
            }
//            if (self.navigationController?.navigationBar.isHidden ?? false) {
//                self.navigationController?.setNavigationBarHidden(true, animated: true)
//            }
//            UIView.animate(withDuration: 1,
//                                  delay: 0.0,
//                                options: .curveEaseIn,
//                             animations: {
//                                self.labelNavBar.alpha = 0
//                                UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
//
//                            }
//                        )
        } else if (y < 0) {
            let satisfy = scrollView.contentOffset.y > 150
            if scrollView.contentSize.height > scrollView.frame.height + topBarHeight && satisfy {
//                print("上滑，畫面往下")
                if self.labelNavBar.alpha < 1 {
                    self.labelNavBar.alpha = self.labelNavBar.alpha + 0.025
                    UIApplication.shared.statusBarStyle = UIStatusBarStyle.darkContent
                }

//                UIView.animate(withDuration: 1,
//                                      delay: 0.0,
//                                    options: .curveEaseIn,
//                                 animations: {
//                                    self.labelNavBar.alpha = 1
//                                }
//                            )
//                if (navigationController?.navigationBar.isHidden ?? true) {
//                    self.navigationController?.setNavigationBarHidden(false, animated: true)
//                }
            }
           
        }else{
            if scrollView.contentOffset.y > 450 && self.labelNavBar.alpha != 1 {
                print("到底了")
                self.labelNavBar.alpha = 1
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.darkContent
            }else if scrollView.contentOffset.y < 150 && self.labelNavBar.alpha != 0{
                print("到頂了")
                self.labelNavBar.alpha = 0
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            }
        }
    }
}
