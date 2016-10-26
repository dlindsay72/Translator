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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewWord))
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        words.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveWords()
    }
    
    func saveWords() {
        
        if let defaults = UserDefaults(suiteName: "group.com.omnificCondition.Translator") {
            defaults.set(words, forKey: "Words")
        }
    }
    
    func addNewWord() {
        
        //create our alert controller
        let ac = UIAlertController(title: "Add new word", message: nil, preferredStyle: .alert)
        
        //add two text fields, one for english and one for french
        ac.addTextField { (textField) in
            textField.placeholder = "English"
        }
        
        ac.addTextField { (textField) in
            textField.placeholder = "French"
        }
        
        //create an Add Word button that submits user input
        let submitAction = UIAlertAction(title: "Add Word", style: .default) { [unowned self, ac] (action: UIAlertAction) in
            
            //pull out the english and french words, or an empty string if there was a problem
            let firstWord = ac.textFields?[0].text ?? ""
            let secondWord = ac.textFields?[1].text ?? ""
            
            //submit the english and french word to the insertFlashCard() method
            self.insertFlashCard(first: firstWord, second: secondWord)
        }
        
        //add the submit action, plus a cancel button
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        //present the alert controller to the user
        present(ac, animated: true, completion: nil)
    }
    
    func insertFlashCard(first: String, second: String) {
        
        guard first.characters.count > 0 && second.characters.count > 0 else { return }
        
        let newIndexPath = IndexPath(row: words.count, section: 0)
        
        words.append("\(first)::\(second)")
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        saveWords()
    }
    
    

}








