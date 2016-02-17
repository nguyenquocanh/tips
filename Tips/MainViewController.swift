//
//  MainViewController.swift
//  Tips
//
//  Created by Kasaki Nguyen on 2/17/16.
//  Copyright © 2016 Kasaki Nguyen. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    private weak var menu: MenuView!
    private var indexTipType: Int = 0
    private var tipType: ContentType!

    @IBOutlet weak var tipPercent1: UILabel!
    @IBOutlet weak var tipPercent2: UILabel!
    @IBOutlet weak var tipPercent3: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tip1Label: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMenu()
        tipType = tipTypes[NSUserDefaults.standardUserDefaults().objectForKey(kTipType) as! Int]
        title = tipType.description
        billField.placeholder = "0.00"
        tip1Label.text = "$0.00"
        tip2Label.text = "$0.00"
        tip3Label.text = "$0.00"
        
        calculate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        calculate()
    }
    
    func calculate() {
        let tipPercentages = tipType.percent
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip1 = billAmount + (billAmount * tipPercentages[0])
        let tip2 = billAmount + (billAmount * tipPercentages[1])
        let tip3 = billAmount + (billAmount * tipPercentages[2])
        
        tipPercent1.text = String(format: "%.0f %", tipPercentages[0] * 100)
        tipPercent2.text = String(format: "%.0f%", tipPercentages[1] * 100)
        tipPercent3.text = String(format: "%.0f%", tipPercentages[2] * 100)
        
        tip1Label.text = String(format: "$%.2f", tip1)
        tip2Label.text = String(format: "$%.2f", tip2)
        tip3Label.text = String(format: "$%.2f", tip3)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }

    private func loadMenu() {
        let menu = MenuView()
        menu.delegate = self
        menu.items = items
        menu.selectedIndex = NSUserDefaults.standardUserDefaults().objectForKey(kTipType) as? Int
        
        tableView.addSubview(menu)
        
        self.menu = menu
    }
    
    private let items = (0..<4 as Range).map {
        MenuItem(image: UIImage(named: "menu_icon_\($0)")!)
    }
    
    @IBAction func switchMenu(sender: AnyObject) {
        menu.setRevealed(!menu.revealed, animated: true)
    }
    
}

// MARK: - MenuViewDelegate
extension MainViewController: MenuViewDelegate {
    func menu(menu: MenuView, didSelectItemAtIndex index: Int) {
        NSUserDefaults.standardUserDefaults().setObject(index, forKey: kTipType)
        tipType = tipTypes[index]
        title = tipType.description
        calculate()
    }
}
