//
//  FirstViewController.swift
//  Empire - Table Game
//
//  Created by Mukhamed-Aziz Zhandar on 30.08.2021.
// MARK: - First View Controller Class

import UIKit
import AVFoundation

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var playersCount: UITextField!
    @IBOutlet weak var playingTheme: UITextField!
    
    let buttonSFRule = UIButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        playersCount.delegate = self
        playingTheme.delegate = self
        
        playersCount.keyboardType = .numberPad
        playersCount.clearButtonMode = .always
        playingTheme.clearButtonMode = .always
        
        buttonStyle()
        buttonLayout()
        
        goButton.layer.cornerRadius = 15
        goButton.layer.borderWidth = 0.5
        goButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        buttonSFRule.addTarget(self, action: #selector(buttonSF), for: .touchUpInside)
        
    }
    
// make a button with SF Symbol which will identify rule of game through smth

    func buttonStyle() {
        
        let largeConfig = UIImage.SymbolConfiguration(
            pointSize: 140,
            weight: .bold,
            scale: .large)
        
        let largeBoldDoc = UIImage(
            systemName: "questionmark.circle",
            withConfiguration: largeConfig)
        
        buttonSFRule.setImage(largeBoldDoc, for: .normal)
        buttonSFRule.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buttonLayout() {
        
        view.addSubview(buttonSFRule)

        NSLayoutConstraint.activate([
                                        
            buttonSFRule.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: buttonSFRule.trailingAnchor, multiplier: 2),
            buttonSFRule.heightAnchor.constraint(equalToConstant: 40),
            buttonSFRule.widthAnchor.constraint(equalToConstant: 40)
        
        ])
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
    
    let customAlert = myAlertFVC()
    
    @objc private func didTapButton() {
        goButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.goButton.alpha = 1.0
        }
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

// Button where would be rules of game
    
    @objc func buttonSF() {

//        let insController = UIAlertController(title: "Instructions", message: "", preferredStyle: .alert)
//        let actionDone = UIAlertAction(title: "OK", style: .cancel, handler: { (action:UIAlertAction) in
//
//        })
//
//        let pageViewController: UIPageViewController
//        pageViewController.preferredContentSize.height = 180
//        insController.setValue(pageViewController, forKey: "contentViewController")
        
    }
    
    @objc func dismissAlert() {
        customAlert.dismissAlert()
    }
}

//MARK: - Alert Class for FirstViewController

class myAlertFVC {
    
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
        titleLabel.font = .boldSystemFont(ofSize: 17)
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
    
    let alert = myAlertSVC()

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
//        print("\(players) игроков")
    }
    
    @objc private func didTapButton2() {
        button.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.button.alpha = 1.0
        }
        if  textField.text!.isEmpty {
            
            alert.showAlert(with: "Так не выйдет", message: "Чтобы продолжить, введите слово", on: self)

        } else if playerNumber < Int(players)! {
            
            let rootVC = SecondViewController(playerNumber, players: players, theme: theme)
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
            playerNumber = playerNumber + 1

        } else {
            
            let rootVCLast = ThirdViewController(playerNumber, playersLast: players, themeLast: theme)
            let navVCLast = UINavigationController(rootViewController: rootVCLast)
            navVCLast.modalPresentationStyle = .fullScreen
            present(navVCLast, animated: true)
        }
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
/*    @IBAction func tapButton(_ sender: UIButton){
        
    }
*/
    
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

// MARK: - Notes - TO DO LIST
/*
  - Функционал кнопки Готово - чтобы прописывалась функция из ViewController.swift с диктовкой всех передаваемых слов (возможно для этого стоит создать глобальную переменную чтобы передавались значения переменной textfield)
  - Нужно создать UIAlertController и прописать внутри pageViewController - для того чтобы прописывалась инстраукция игры в buttonSF
  - Прописать анимированный LaunchScreen.storyboard
*/
// MARK: - Third View Controller

class ThirdViewController: UIViewController, UITextFieldDelegate {

    var theme = String()
    var players = String()
    var playerNumber = 1

    let backgroundView = UIImageView()
    let label = UILabel()
    let textField = UITextField()
    let buttonLast = UIButton()

    init(_ playerNumberLast: Int, playersLast: String, themeLast: String) {
        self.playerNumber = playerNumberLast
        self.players = playersLast
        self.theme = themeLast
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
                                                                   action: #selector(dismissSelfLast))

        styleLast()
        layoutLast()
        buttonLast.addTarget(self, action: #selector(didTapButtonLast), for: .touchUpInside)
    }
    
// Кнопка - отвечающая за проговорку всех слов, которые были переданы в textfield
    @objc private func didTapButtonLast() {
        
        buttonLast.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.buttonLast.alpha = 1.0
        }
        
        let utterance = AVSpeechUtterance(string: textField.text ?? "Nothing")
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        utterance.rate = 0.3
        
        let synthesis = AVSpeechSynthesizer()
        synthesis.speak(utterance)

    }
    
    @objc private func dismissSelfLast() {
        dismiss(animated: true, completion: nil)
    }

    
}

extension ThirdViewController {
    
    func styleLast() {
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.image = UIImage(named: "waves")
        backgroundView.contentMode = .scaleAspectFill

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Игрок №\(players), введите свое слово"
//            label.backgroundColor = .systemFill
//            label.layer.shadowColor = UIColor.orange.cgColor
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
//        playerNumber += 1
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ваше слово"
//            textField.backgroundColor = .systemFill
//            textField.layer.shadowRadius = 3.0
//            textField.layer.cornerRadius = 15
//            textField.layer.borderWidth = 0.5
        textField.clearButtonMode = .always
//            textField.layer.shadowColor = UIColor.orange.cgColor
        
        buttonLast.translatesAutoresizingMaskIntoConstraints = false
        buttonLast.backgroundColor = .systemGreen
        buttonLast.layer.cornerRadius = 15
        buttonLast.layer.borderWidth = 0.5
        buttonLast.setTitle("Готово", for: .normal)
        buttonLast.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)

        
    }
    
    func layoutLast() {
        
        view.addSubview(backgroundView)
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(buttonLast)

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
            
            buttonLast.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 8),
            buttonLast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLast.heightAnchor.constraint(equalToConstant: 50),
            buttonLast.widthAnchor.constraint(equalToConstant: 150)

        ])
    }
    
}

//MARK: - Alert Class for SecondViewController

class myAlertSVC {
    
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
                   on viewController: SecondViewController) {
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
        titleLabel.font = .boldSystemFont(ofSize: 17)
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

