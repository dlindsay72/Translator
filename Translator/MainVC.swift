//
//  MainVC.swift
//  Translator
//
//  Created by Dan Lindsay on 2016-10-25.
//  Copyright © 2016 Dan Lindsay. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    var words = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleAttributes = [NSFontAttributeName: UIFont(name: "AmericanTypewriter", size: 22)!] //he has 2 t's in Typewriter"
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "TRANSLATOR"

        if let defaults = UserDefaults(suiteName: "group.com.omnificCondition.Translator") {
            
            if let savedWords = defaults.object(forKey: "Words") as? [String] {
                words = savedWords
            } else {
                saveInitialWords(to: defaults)
            }
        }
    }

   
    func saveInitialWords(to defaults: UserDefaults) {
        
        words.append("bear::l'ours")
        words.append("camel::le chameau")
        words.append("cow::la vache")
        words.append("fox::le renard")
        words.append("goat::la chevre")
        words.append("monkey::le singe")
        words.append("pig::le cochon")
        words.append("rabbit::le lapin")
        words.append("sheep::le mouton")
        
        defaults.set(words, forKey: "Words")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        
        cell.textLabel?.text = split[0]
        
        cell.detailTextLabel?.text = ""
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.detailTextLabel?.text == "" {
                let word = words[indexPath.row]
                let split = word.components(separatedBy: "::")
                
                cell.detailTextLabel?.text = split[1]
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
    }

}








