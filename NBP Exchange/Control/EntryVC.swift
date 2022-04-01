//
//  by: Tymek (iTmi) on: 31/03/2022 | EntryVC.swift : NBP Exchange 
// Copyright (c) 2022, all rights reserved. UIID: DBFC1DB8-25C2-4C4F-9A06-6E024E744502 

import UIKit

class EntryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CursesButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCurses", sender: .none)
    }
    
    @IBAction func CalculatorButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCalculator", sender: .none)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
