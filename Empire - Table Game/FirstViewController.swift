//
//  FirstViewController.swift
//  Empire - Table Game
//
//  Created by Mukhamed-Aziz Zhandar on 30.08.2021.
// MARK: - First View Controller Class

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var playersCount: UITextField!
    @IBOutlet weak var playingTheme: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersCount.delegate = self
        playingTheme.delegate = self
        
        playersCount.keyboardType = .numberPad
        playersCount.clearButtonMode = .always
        playingTheme.clearButtonMode = .always
        
        goButton.layer.cornerRadius = 15
        goButton.layer.borderWidth = 0.5
        goButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile number validation
        if textField == playersCount {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    let customAlert = myAlert()
    
    @objc private func didTapButton() {
        if playingTheme.text!.isEmpty || playersCount.text!.isEmpty {
            customAlert.showAlert(with: "Ошибка", message: "Чтобы пройти дальше, нужно заполнить параметры: \n1) количество игроков; \n2) тематику игры", on: self)
        } else {
            let rootVC = SecondViewController(playerNumber, players: playersCount.text!, theme: playingTheme.text!)
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
            rootVC.theme = playingTheme.text!
            rootVC.players = playersCount.text!
        }
    }
    
    @objc func dismissAlert() {
        customAlert.dismissAlert()
    }
}

//MARK: - Alert Class

class myAlert {
    
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
                                 y: -300,
                                 width: targetView.frame.size.width-80,
                                 height: 300)

        let titleLabel = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: alertView.frame.size.width,
                                               height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let messageLabel = UILabel(frame: CGRect(x: 20,
                                                 y: 70,
                                                 width: alertView.frame.size.width-40,
                                                 height: 170))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .center
        alertView.addSubview(messageLabel)
        
        let button = UIButton(frame: CGRect(x: 0,
                                            y: alertView.frame.size.height-60,
                                            width: alertView.frame.size.width,
                                            height: 50))
        button.setTitle("Окей, понятно", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self,
                         action: #selector(dismissAlert),
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
}

// MARK: - Second View Controller Class

var playerNumber = 1

class SecondViewController: UIViewController, UITextFieldDelegate {

    var theme = String()
    var players = String()
    var playerNumber = 1

    let backgroundView = UIImageView()
    let label = UILabel()
    let textField = UITextField()
    let button = UIButton()
    
    init(_ playerNumber: Int, players: String, theme: String) {
        self.playerNumber = playerNumber
        self.players = players
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Тема игры - \(theme)"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Назад",
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(dismissSelf))
                
        style()
        layout()
        button.addTarget(self, action: #selector(didTapButton2), for: .touchUpInside)
        print("\(players) игроков")
    }
    
    @objc private func didTapButton2() {
        if playerNumber < Int(players)! {
            let rootVC = SecondViewController(playerNumber, players: players, theme: theme)
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
            playerNumber = playerNumber + 1

//            playerNumber = playerNumber + 1
        }
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

    
}
    extension SecondViewController {

        func style() {
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.image = UIImage(named: "waves")
            backgroundView.contentMode = .scaleAspectFill
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Игрок №\(playerNumber), введите свое слово"
//            label.backgroundColor = .systemFill
//            label.layer.shadowColor = UIColor.orange.cgColor
            label.numberOfLines = 0
            label.textColor = .white
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 20)
            playerNumber += 1
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.borderStyle = .roundedRect
            textField.placeholder = "Ваше слово"
//            textField.backgroundColor = .systemFill
//            textField.layer.shadowRadius = 3.0
//            textField.layer.cornerRadius = 15
//            textField.layer.borderWidth = 0.5
            textField.clearButtonMode = .always
//            textField.layer.shadowColor = UIColor.orange.cgColor
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .link
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 0.5
            button.setTitle("Дальше", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            
        }
        
        func layout() {
            
            view.addSubview(backgroundView)
            view.addSubview(label)
            view.addSubview(textField)
            view.addSubview(button)
            
            NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 30),
                label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 10),
                view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 10),
//                label.heightAnchor.constraint(equalToConstant: 50),
                
                textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                textField.widthAnchor.constraint(equalToConstant: 250),
                textField.heightAnchor.constraint(equalToConstant: 50),
                textField.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 4),
                
                button.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 8),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 50),
                button.widthAnchor.constraint(equalToConstant: 150)
            
            ])
        }
    }

// MARK: - Notes
/*
   - Нужно прописать как будут создаваться несколько одинаковых вьюшек (с изменениями лишь в label-е и чтобы когда был последний индекс players.count появилась новая кнопка (Готово)
  - Функционал кнопки Готово - чтобы прописывалась функция из ViewController.swift с диктовкой всех передаваемых слов
*/
