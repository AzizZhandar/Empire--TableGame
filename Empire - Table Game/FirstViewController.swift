//
//  FirstViewController.swift
//  Empire - Table Game
//
//  Created by Mukhamed-Aziz Zhandar on 30.08.2021.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var playersCount: UITextField!
    @IBOutlet weak var playingTheme: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        playersCount.delegate = self
        playingTheme.delegate = self
        
        goButton.layer.cornerRadius = 15
        goButton.layer.borderWidth = 0.5
        goButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile number validation
        if textField == playersCount {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    
    @objc private func didTapButton() {
        let rootVC = SecondViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        rootVC.theme = playingTheme.text!
        rootVC.players = playersCount.text!
        
//        let destinationViewController = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
//        destinationViewController.a = playingTheme.text!
//        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
}

// MARK: - Second View Controller Class

class SecondViewController: UIViewController, UITextFieldDelegate {

    var theme = String()
    var players = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Тема игры - \(theme)"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Назад",
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(dismissSelf))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "Игрок \(players) введи свое слово"
        label.font = UIFont(name: "Avenir", size: 16)
        label.textColor = .systemBlue
        self.view.addSubview(label)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Notes
/*
 
DONE  - Нужно прописать playingTheme.text values во второй контроллер () - DONE
  - Нужно прописать как будут создаваться несколько одинаковых вьюшек (с изменениями лишь в label-е и чтобы когда был последний индекс players.count появилась новая кнопка (Готово)
 
 */
