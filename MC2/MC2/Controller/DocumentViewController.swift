//
//  DocumentViewController.swift
//  MC2
//
//  Created by Widya Limarto on 29/06/22.
//

import UIKit
import PDFKit

class DocumentViewController: UIViewController {
    var fileName: String?
    var filePath: URL?
    var pdfView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuItem = UIMenuItem(title: "Add Highlight", action: #selector(addHighlight))
        UIMenuController.shared.menuItems = [menuItem]
        let _ = filePath!.startAccessingSecurityScopedResource()
        print("ViewDidLoad", filePath!)
        
        view.backgroundColor = UIColor.red
        pdfView = PDFView(frame: self.view.bounds)
        self.view.addSubview(pdfView)
        pdfView!.document = PDFDocument(url: filePath!)
        
        filePath!.stopAccessingSecurityScopedResource()

        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        let height: CGFloat = 50 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - height)
        
        self.parent!.navigationItem.title = fileName ?? ""
        self.parent!.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    @objc func addHighlight() {
        //munculin sidebar kanan
        //highlight di page dikasih warna default
        highlightSelection()
        //highlight text simpan di core data
        //simpan posisi highlight dan selection line di core data
    }
    
    func highlightSelection() {
        let selections = pdfView!.currentSelection
//        print(selections?.string)
//        let lines = selections?.selectionsByLine()
//        print(lines?.count)
        
        let lines = selections?.selectionsByLine()
        print(lines?.count ?? selections as Any)
        
        for selection in lines! {
            print (selection.pages)
            let highlight = PDFAnnotation(bounds: selection.bounds(for: selection.pages[0]), forType: .highlight, withProperties: nil)
            
            highlight.color = UIColor.yellow
            selection.pages[0].addAnnotation(highlight)
        }

    }
    
}
   
