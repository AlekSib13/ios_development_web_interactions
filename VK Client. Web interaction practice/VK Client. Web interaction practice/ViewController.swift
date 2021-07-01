////
////  ViewController.swift
////  VK Client. Web interaction practice
////
////  Created by Aleksandr Malinin on 21.06.2021.
////
//
//import UIKit
//
//
//
//class ViewController: UIViewController {
//
//    var checker = vkClientEntrance()
//
//    @IBOutlet weak var mainView: UIView!
//
//    @IBOutlet weak var mainLabel: UILabel!
//    @IBOutlet weak var loginLabel: UILabel!
//    @IBOutlet weak var loginField: UITextField!
//    @IBOutlet weak var passwordLabel: UILabel!
//    @IBOutlet weak var passwordField: UITextField!
//    @IBOutlet weak var enterButton: UIButton!
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewSetUp()
//    }
//
//
//    func viewSetUp() {
//        mainView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//
//        mainLabel.text = "VK"
//        mainLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        mainLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        mainLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
//
//        loginLabel.text = "Login"
//        loginLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//        passwordLabel.text = "Password"
//        passwordLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//        enterButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0.7889876962, blue: 1, alpha: 1)
//        enterButton.layer.cornerRadius = 10.0
//        enterButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        enterButton.setTitle("Enter", for: .normal)
//    }
//
//    @IBAction func switchToMainPage() {
//        guard let userLogin = loginField.text,  let userPassword = passwordField.text else {return}
//
//        if checker.checkEntrance(login: userLogin, password: userPassword) {
//            print("You may enter")
//
//                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//                                let mainPageViewScene = storyboard.instantiateViewController(identifier: "MainPageView")
//                                self.present(mainPageViewScene, animated: true, completion: nil)
//        }
//    }
//}
//
//
//
//
