//
//  ConcentrationThemeChooserViewController.swift
//  ConcentrationApp
//
//  Created by Nick Khachatryan on 29.08.2022.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    
    //  MARK: - CUSTOM PROPERTIES
    let themes = [
        "Sports" : "⚽️🏀🏉⚾️🥎🏐🎱🏓⛷🎳⛳️",
        "Animals":"🐶🐔🦊🐼🦀🐫🐓🐋🐙🦄🐵",
        "Faces":"😀😂😎😩😰😴🙄🤔😘😷"]
    
    private var lastSeguedToConcentrationViewController : ConcentrationViewController?
    
    private var splitViewDetailConcentrationViewController : ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    
    //  MARK: - VC LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }

    
     //  MARK: - ACTIONS
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
        if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName] {
            cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
        performSegue(withIdentifier: "chooseTheme", sender: sender)
        }
    }
    
    
   //  MARK: - FUNCTIONS
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseTheme"{
            if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
}

