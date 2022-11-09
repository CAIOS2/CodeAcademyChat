//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var user: User!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        welcomeLabel.text = "Hello, \(user.username)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
