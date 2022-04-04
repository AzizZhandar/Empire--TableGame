//
//  InstructionsViewController.swift
//  Empire - Table Game
//
//  Created by Mukhamed-Aziz Zhandar on 04.10.2021.
//

import UIKit

class InstructionsViewController {

        struct Constants {
            static let backgroundAlphaTo: CGFloat = 0.6
        }

        private let backgroundView: UIView = {
            let backgroundView = UIView()
            backgroundView.backgroundColor = .black
            backgroundView.alpha = 0
            return backgroundView
        }()
        
        private let alertView: UIView = {
            let alert = UIView()
            alert.backgroundColor = .white
            alert.layer.masksToBounds = true
            alert.layer.cornerRadius = 12
            return alert
        }()
        
        private var mytargetView: UIView?
/*
        func showAlert(with title: String,
                       message: String,
                       on viewController: FirstViewController) {
            guard let targetView = viewController.view else {
                return
            }
*/
            func showAlert(image: String,
                       on viewController: FirstViewController) {
            guard let targetView = viewController.view else {
                return
            }
            
            mytargetView = targetView
            
            backgroundView.frame = targetView.bounds
            targetView.addSubview(backgroundView)
            
            targetView.addSubview(alertView)
            alertView.frame = CGRect(x: 40,
                                     y: -300,
                                     width: targetView.frame.size.width-80,
                                     height: 300)

            let image = UIImageView()
            
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
            image.image = UIImage(named: "FirstScreenShot")

            NSLayoutConstraint.activate([
                image.heightAnchor.constraint(equalTo: alertView.heightAnchor, multiplier: 0),
                image.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0)
            ])
            alertView.addSubview(image)
            
            UIView.animate(withDuration: 0.25,
                           animations: {
                            
                            self.backgroundView.alpha = Constants.backgroundAlphaTo
                           }, completion: { done in
                            if done {
                                UIView.animate(withDuration: 0.25, animations: {
                                    self.alertView.center = targetView.center
                                })
                            }
                           })
        }
        
        @objc func dismissAlert() {
            guard let targetView = mytargetView else {
                return
            }
            
            UIView.animate(withDuration: 0.25,
                           animations: {
                            
                            self.alertView.frame = CGRect(x: 40,
                                                          y: targetView.frame.size.height,
                                                     width: targetView.frame.size.width-80,
                                                     height: 300)

                            }, completion: { done in
                            if done {
                                UIView.animate(withDuration: 0.25, animations: {
                                    self.backgroundView.alpha = 0
                                }, completion: { done in
                                    if done {
                                        self.alertView.removeFromSuperview()
                                        self.backgroundView.removeFromSuperview()
                                    }
                                })
                            }
                           })
        }

    
//    override func viewDidLoad() {
//        super.viewDidLoad()

        // Do any additional setup after loading the view.
//    }
}
