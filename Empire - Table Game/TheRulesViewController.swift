//
//  TheRulesViewController.swift
//  Empire - Table Game
//
//  Created by Aziz Zhandar on 15.06.2022.
//

import UIKit

class TheRulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

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
    
    func showAlert(with title: String,
                   message: String,
                   on viewController: FirstViewController) {
        guard let targetView = viewController.view else {
            return
        }
        
        mytargetView = targetView
        
        backgroundView.frame = targetView.bounds

        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40,
                                 y: -900,
                                 width: targetView.frame.size.width-60,
                                 height: 650)

//        alertView.backgroundColor = UIColor(patternImage: UIImage(named: "e-7")!)


        let titleLabel = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: alertView.frame.size.width,
                                               height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        alertView.addSubview(titleLabel)
        
        let messageLabel = UILabel(frame: CGRect(x: 20,
                                                 y: 70,
                                                 width: alertView.frame.size.width-40,
                                                 height: 520))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 15)
        alertView.addSubview(messageLabel)
        
        let button = UIButton(frame: CGRect(x: 0,
                                            y: alertView.frame.size.height-60,
                                            width: alertView.frame.size.width,
                                            height: 50))
        button.setTitle("Гуд, гоу начинать", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self,
                         action: #selector(dismissAlertTwo),
                         for: .touchUpInside)
        alertView.addSubview(button)

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
    
    @objc func dismissAlertTwo() {
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

}
