//
//  DocumentViewController.swift
//  MC2
//
//  Created by Widya Limarto on 29/06/22.
//

import UIKit
import PDFKit
import CoreData

class DocumentViewController: UIViewController {
    var fileName: String?
    var filePath: URL?
    var file: File?
    var pdfView: PDFView!
    var isHiddenSideView: Bool = true
    var highLightsIsOpen: [Bool] = []
    var highlights: [Highlight] = []
    var highlightsTranslations: [String] = []
    
    var defaultColor: UIColor = UIColor.yellow
    
    @IBOutlet weak var contentPdfView: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var hLTableView: UITableView!
    
    let context : NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideView.applyShadow(cornerRadius: 0)
        self.setupPdfView()
        self.setupTableViewCell()
        do {
            self.highlights = try context.fetch(Highlight.fetchRequest())
            self.highLightsIsOpen = Array(repeating: false, count: highlights.count)
            self.highlightsTranslations = Array(repeating: "", count: highlights.count)
        } catch {
            print(error.localizedDescription
            )
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.parent!.navigationItem.title = fileName ?? ""
        self.parent!.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupTableViewCell() {
        let nib = UINib(nibName: "HighlightTableViewCell", bundle: nil)
        self.hLTableView.register(nib, forCellReuseIdentifier: "HighlightTableViewCell")
        self.hLTableView.dataSource = self
        self.hLTableView.delegate = self
        self.hLTableView.estimatedRowHeight = 50
        self.hLTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func setupPdfView() {
        let menuItem = UIMenuItem(title: "Add Highlight", action: #selector(addHighlight))
        UIMenuController.shared.menuItems = [menuItem]
        let _ = filePath!.startAccessingSecurityScopedResource()
        
        pdfView = PDFView(frame: self.contentPdfView.bounds)
        self.contentPdfView.addSubview(pdfView)
        pdfView!.document = PDFDocument(url: filePath!)
        
        filePath!.stopAccessingSecurityScopedResource()
        
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @objc func addHighlight() {
        
        let selections = pdfView!.currentSelection
        //munculin sidebar kanan
        self.toggleSideBar(isHide: false)
        //highlight di page dikasih warna default
        highlightSelection(selections: selections)
        //simpan posisi highlight dan selection line di core data
        let highlight = addHighlightToCoreData(selections: selections)
        highlights.insert(highlight, at: 0)
        highLightsIsOpen.insert(true, at: 0)
        
        
        //get translated text
        
        self.getTranslation(q: (selections?.string)!)
    }
    
    func getTranslation(q: String) -> String {
        var res = "loading"
        GTranslation.shared.translateText(q: q, targetLanguage: "id", callback: { text in
            self.highlightsTranslations.insert(text, at: 0)
            DispatchQueue.main.async {
                self.hLTableView.reloadData()
            }
        })
        return res
    }
    
    func addHighlightToCoreData(selections: PDFSelection?) -> Highlight {
        //highlight text simpan di core data
        let hl = Highlight(context: context)
        hl.color = defaultColor.encode()
        hl.file = file
        hl.id = UUID()
        hl.text = selections?.string
        print(hl.text)
        hl.fileName = fileName
        hl.createdDate = Date()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        return hl
    }
    
    //:") baru segini aj lama hmmmmmfafafafafsad
    
    func highlightSelection(selections: PDFSelection?) {
        
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
    
    func toggleSideBar(isHide: Bool) {
        self.isHiddenSideView = isHide
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1,
            options: [],
            animations: {
                self.sideView.isHidden = self.isHiddenSideView
                self.sideView.alpha = self.isHiddenSideView ? 0 : 1
            },
            completion: nil
        )
    }
    
    
}

extension DocumentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.highlights.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
        let setIsHidden = !highLightsIsOpen[indexPath.row]
        self.highLightsIsOpen[indexPath.row] = setIsHidden
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightTableViewCell", for: indexPath) as! HighlightTableViewCell
        cell.hLDetailStackView.isHidden = !self.highLightsIsOpen[indexPath.row]
        cell.hLText.text = highlights[indexPath.row].text
        cell.translationText.text = highlightsTranslations[indexPath.row] ?? ""
//        cell.hlDetailView.alpha = self.highLights[indexPath.row] ? 0 : 1
//        cell.hlDetailView.isHidden = true
//        cell.contentView.frame.width = cell.contentView.frame.width - 50
        return cell
            
            
        }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50
    }
        
}
