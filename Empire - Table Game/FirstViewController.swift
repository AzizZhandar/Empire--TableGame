//
//  FirstViewController.swift
//  Empire - Table Game
//
//  Created by Mukhamed-Aziz Zhandar on 30.08.2021.
// MARK: - First View Controller Class

import UIKit
import AVFoundation

class FirstViewController: UIViewController, UITextFieldDelegate {

    let backgroundView = UIImageView()
    let welcomingLabel = UILabel()
    let inGameLabel = UILabel()
    let empireLabel = UILabel()
    let descriptionLabel = UILabel()
    let playersCount = UITextField()
    let playingTheme = UITextField()
    let goButton = UIButton()

    let buttonSFRule = UIButton()

    var player: AVAudioPlayer?
    var playerMinimum = 5

    override func viewDidLoad() {
        super.viewDidLoad()

        playersCount.delegate = self
        playingTheme.delegate = self

        playersCount.keyboardType = .numberPad
        playersCount.clearButtonMode = .always
        playingTheme.clearButtonMode = .always

        buttonStyle()
        buttonLayout()

        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        buttonSFRule.addTarget(self, action: #selector(buttonSF), for: .touchUpInside)

    }

// make a button with SF Symbol which will identify rule of game through smth

    func buttonStyle() {

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        welcomingLabel.translatesAutoresizingMaskIntoConstraints = false
        inGameLabel.translatesAutoresizingMaskIntoConstraints = false
        empireLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        playersCount.translatesAutoresizingMaskIntoConstraints = false
        playingTheme.translatesAutoresizingMaskIntoConstraints = false
        goButton.translatesAutoresizingMaskIntoConstraints = false
        buttonSFRule.translatesAutoresizingMaskIntoConstraints = false

        backgroundView.image = UIImage(named: "wave-haikei-7")
        backgroundView.contentMode = .scaleToFill

        welcomingLabel.text = "Добро пожаловать"
        welcomingLabel.numberOfLines = 0
        welcomingLabel.textColor = .link
        welcomingLabel.font = UIFont(name: "Avenir Heavy", size: 28)

        inGameLabel.text = "в игру"
        inGameLabel.numberOfLines = 0
        inGameLabel.textColor = .link
        inGameLabel.font = UIFont(name: "Avenir Heavy", size: 28)

        empireLabel.text = "Empire"
        empireLabel.numberOfLines = 0
        empireLabel.textColor = .black
        empireLabel.font = UIFont(name: "Avenir Heavy", size: 28)
        
        descriptionLabel.text = "Чтобы начать играть, укажите количество игроков, а также тематику игры:"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .gray
        descriptionLabel.font = UIFont(name: "Avenir Heavy", size: 20)
        
        playersCount.borderStyle = .roundedRect
        playersCount.placeholder = "введите количество игроков"
        playersCount.clearButtonMode = .always
        playersCount.font = UIFont(name: "Avenir Heavy", size: 14)
        playersCount.alpha = 0.8882
        
        playingTheme.borderStyle = .roundedRect
        playingTheme.placeholder = "введите тему игры"
        playingTheme.clearButtonMode = .always
        playingTheme.font = UIFont(name: "Avenir Heavy", size: 14)
        playingTheme.alpha = 0.8882

        goButton.backgroundColor = .link
        goButton.layer.cornerRadius = 15
        goButton.layer.borderWidth = 0.5
        goButton.setTitle("Начать", for: .normal)
        goButton.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 16)
    
        
        let largeConfig = UIImage.SymbolConfiguration(
            pointSize: 140,
            weight: .bold,
            scale: .large)
        
        let largeBoldDoc = UIImage(
            systemName: "questionmark.circle",
            withConfiguration: largeConfig)
        buttonSFRule.setImage(largeBoldDoc, for: .normal)
    }
    
    func buttonLayout() {
        
        view.addSubview(backgroundView)
        view.addSubview(welcomingLabel)
        view.addSubview(inGameLabel)
        view.addSubview(empireLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(playersCount)
        view.addSubview(playingTheme)
        view.addSubview(goButton)
        view.addSubview(buttonSFRule)

        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            welcomingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomingLabel.bottomAnchor.constraint(equalTo: inGameLabel.topAnchor, constant: -10),
            
            inGameLabel.topAnchor.constraint(equalToSystemSpacingBelow: welcomingLabel.bottomAnchor, multiplier: 6),
            inGameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20),
            inGameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            empireLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20),
            empireLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: inGameLabel.trailingAnchor, multiplier: 1),
            
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: inGameLabel.bottomAnchor, multiplier: 4),
            descriptionLabel.bottomAnchor.constraint(equalTo: playersCount.topAnchor, constant: -50),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            playersCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playersCount.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playersCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            playingTheme.topAnchor.constraint(equalToSystemSpacingBelow: playersCount.bottomAnchor, multiplier: 2),
            playingTheme.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playingTheme.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playingTheme.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.topAnchor.constraint(equalTo: playingTheme.bottomAnchor, constant: 50),
            goButton.heightAnchor.constraint(equalToConstant: 50),
            goButton.widthAnchor.constraint(equalToConstant: 175),
            
            buttonSFRule.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            buttonSFRule.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
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

    let customAlert = AlertForTheFirstViewController()
    var IntPlayersCount = 0
    
    @objc private func goButtonTapped(sender: UIButton) {
        
        goButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.goButton.alpha = 1.0
        }
        
        IntPlayersCount = Int(playersCount.text ?? "") ?? 0
        
        if playingTheme.text!.isEmpty || IntPlayersCount == 0 || IntPlayersCount < playerMinimum {
            customAlert.showAlert(with: "Ошибка", message: "Чтобы пройти дальше, нужно заполнить параметры: \n1) количество игроков (минимум 5); \n2) тематику игры", on: self)
        } else {
            let rootVC = SecondViewController(playerNumberOne, players: playersCount.text!, theme: playingTheme.text!)
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
    

// MARK: - Button where would be rules of game

    let alertGif = TheRulesViewController()
    @objc private func buttonSF(sender: UIButton) {
        
        buttonSFRule.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.buttonSFRule.alpha = 1.0
        }
        alertGif.showAlert(with: "Правила игры", message: "Цель игры в том, чтобы угадать, кто какое слово загадал и остаться неугаданным \n\n Группа людей определяется с тематикой игры. Каждый игрок прописывает свое слово и передает телефон следующему игроку (минимальное количество игроков - 5)\n\n После того как свое слово прописал последний игрок, телефон проговаривает все прописанные слова в рандомном порядке\n\n Игра сама определяет - какой игрок начинает ход. Если игрок в своем ходе угадал, то тот кого он угадал переходит к нему в команду, и они вместе, сообща - решают свой следующий ход\n\n Но если игрок в своем ходе не угадал, то игрок которого не угадали - начинает свой ход\n\nУдачи!", on: self)
    }
    @objc private func dismissAlertTwo() {
        alertGif.dismissAlertTwo()
    }
}

// MARK: - Second View Controller Class

var playerNumberOne = 1
var playerText: String  = ""
var dataArray = [String]()

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    let alert = myAlertSVC()
    let duplicate = duplicateAlert()

    var theme = String()
    var players = String()
    var playerNumber = 1
//    var dataArray = [String]()

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

        if textField.text!.isEmpty {

            alert.showAlert(with: "Упс! Так не выйдет", message: "Чтобы продолжить, впишите свое слово", on: self)

        } else if playerNumber < Int(players)! {
            
            let rootVC = SecondViewController(playerNumber, players: players, theme: theme)
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
            playerNumber = playerNumber + 1
            
            let entry = textField.text!
            if !dataArray.contains(entry) {
                dataArray.append(entry)
                textField.text = ""
//                dataArray.forEach { data in
//                    print(dataArray)
//                }
                print(dataArray)
            } else {
                duplicate.showAlert(with: "Упс! Ошибка", message: "Такое слово уже имеется в списке, напиши другое", on: self)
            }
            
        } else if dataArray.contains(textField.text!) {
            duplicate.showAlert(with: "Упс! Ошибка", message: "Такое слово уже имеется в списке, напишите другое", on: self)
        } else {
            
            let rootVCLast = ThirdViewController(playerNumber, playersLast: players, themeLast: theme)
            let navVCLast = UINavigationController(rootViewController: rootVCLast)
            navVCLast.modalPresentationStyle = .fullScreen
            present(navVCLast, animated: true)
            playerNumber = 1
//            print(dataArray)

            let entry = textField.text!
            if !dataArray.contains(entry) {
                dataArray.append(entry)
                textField.text = ""
//                dataArray.forEach { data in
//                    print(dataArray)
//                }
                print(dataArray)
            }

        }
    }
    
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
extension SecondViewController {
    
        func style() {
            
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.image = UIImage(named: "imageBackground")
            backgroundView.contentMode = .scaleAspectFill
            
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Игрок №\(playerNumber), введите свое слово"
//            label.backgroundColor = .systemFill
//            label.layer.shadowColor = UIColor.orange.cgColor
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 20)
            label.font = UIFont(name: "Avenir Heavy", size: 20)
            playerNumber += 1
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.borderStyle = .roundedRect
            textField.placeholder = "Ваше слово"
//            textField.backgroundColor = .systemFill
//            textField.layer.shadowRadius = 3.0
//            textField.layer.cornerRadius = 15
//            textField.layer.borderWidth = 0.5
            textField.clearButtonMode = .always
            textField.font = UIFont(name: "Avenir Heavy", size: 14)
            textField.alpha = 0.8882
//            textField.layer.shadowColor = UIColor.orange.cgColor
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .link
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 0.5
            button.setTitle("Дальше", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 17)
            
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
//                label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 30),
                label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 10),
                label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -40),
                view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 10),
//                label.heightAnchor.constraint(equalToConstant: 50),
                
                textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                textField.widthAnchor.constraint(equalToConstant: 250),
                textField.heightAnchor.constraint(equalToConstant: 50),
                textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),

//                textField.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 4),
                
                button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 50),
                button.widthAnchor.constraint(equalToConstant: 150)
            
            ])
        }
}

// MARK: - Third View Controller



class ThirdViewController: UIViewController, UITextFieldDelegate {

//    static let shared = ThirdViewController(coder: nil)
    
    var theme = String()
    var players = String()
    var playerNumber = 1
    
    let alert = myAlertTVC()
    let duplicate = duplicateAlertTVC()

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
        dataArray.shuffle()
        buttonLast.addTarget(self, action: #selector(didTapButtonLast), for: .touchUpInside)
    }

    func styleLast() {
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.image = UIImage(named: "imageBackground")
        backgroundView.contentMode = .scaleAspectFill

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Игрок №\(players), введите свое слово"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ваше слово"
        textField.clearButtonMode = .always
        textField.font = UIFont(name: "Avenir Heavy", size: 14)
        textField.alpha = 0.8882
        
        buttonLast.translatesAutoresizingMaskIntoConstraints = false
        buttonLast.backgroundColor = .systemGreen
        buttonLast.layer.cornerRadius = 15
        buttonLast.layer.borderWidth = 0.5
        buttonLast.setTitle("Готово", for: .normal)
        buttonLast.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        buttonLast.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 17)

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
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 10),
            label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -40),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 10),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            buttonLast.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            buttonLast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLast.heightAnchor.constraint(equalToConstant: 50),
            buttonLast.widthAnchor.constraint(equalToConstant: 150)
        
        ])
    }
    
    // Кнопка - отвечающая за проговорку всех слов, которые были переданы в textfield
        @objc private func didTapButtonLast() {

            buttonLast.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.buttonLast.alpha = 1.0
            }
            dataArray.shuffle()

            if textField.text!.isEmpty {
                alert.showAlert(with: "Упс! Так не выйдет", message: "Чтобы продолжить, впишите свое слово", on: self)
            } else if dataArray.contains(textField.text!) {
                duplicate.showAlert(with: "Упс! Ошибка", message: "Такое слово уже имеется в списке, напишите другое", on: self)
            } else {
                let entry = textField.text!
                if !dataArray.contains(entry) {
                    dataArray.append(entry)
                    textField.text = ""
                    print(dataArray)
                }

                dataArray.shuffle()

                let str = "Тема игры - \(theme); Прописанные слова: \(dataArray)"

                let utterance = AVSpeechUtterance(string: str)
                utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
                utterance.rate = 0.3

                let synthesis = AVSpeechSynthesizer()
                synthesis.speak(utterance)

                let rootVC = LastViewController(playersLastView: players, themeLastView: theme)
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                present(navVC, animated: true)
                dataArray.removeAll()
            }
        }
        
        @objc private func dismissSelfLast() {
            dismiss(animated: true, completion: nil)
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
        messageLabel.font = .systemFont(ofSize: 15)

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

//MARK: - Alert Class for SecondViewController

class duplicateAlert {
    
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
        messageLabel.font = .systemFont(ofSize: 15)

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



//MARK: - Alert Class for ThirdViewController

class myAlertTVC {
    
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
                   on viewController: ThirdViewController) {
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
        messageLabel.font = .systemFont(ofSize: 15)

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

//MARK: - Alert Class for ThirdViewController

class duplicateAlertTVC {
    
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
                   on viewController: ThirdViewController) {
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
        messageLabel.font = .systemFont(ofSize: 15)

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
