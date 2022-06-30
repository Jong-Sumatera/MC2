//
//  DocumentViewController.swift
//  MC2
//
//  Created by Widya Limarto on 29/06/22.
//

import UIKit
import PDFKit

class DocumentViewController: UIViewController {
    var filePath: URL?
    var pdfView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pdfView = PDFView(frame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: self.view.bounds.height-50))
            pdfView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(pdfView!)
            pdfView!.document = PDFDocument(url: filePath!)
        // Do any additional setup after loading the view.
        
        let tap = TouchUpGestureRecogniser(target: self, action: #selector(tapHandler))
        tap.delegate = self
//                tap.minimumPressDuration = 0
        pdfView.addGestureRecognizer(tap)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(onSelectionChanged), name: .PDFViewSelectionChanged, object: nil)
    }
    
    
    @objc func tapHandler(gesture: UIGestureRecognizer) {
        // there are seven possible events which must be handled
        print(gesture.location(in: pdfView))
//                if gesture.state == .began {
//                    print("tap began")
//                    return
//                }
//
//                if gesture.state == .changed {
//                    print("very likely, just that the finger wiggled around while the user was holding down the button. generally, just ignore this")
//                    return
//                }
//
//                if gesture.state == .possible || gesture.state == .recognized {
//                    print("in almost all cases, simply ignore these two, unless you are creating very unusual custom subclasses")
//                    return
//                }
//
        //                // the three remaining states are
        //                // .cancelled, .failed, and .ended
        //                // in all three cases, must return to the normal button look:
        //                print("ended")
            }
    
    @objc func doSomething() {
        let menuItem = UIMenuItem(title: "Custom Action", action: #selector(doSomething))
        UIMenuController.shared.menuItems = [menuItem]
    }
            
            @objc func onSelectionChanged() {
                print("selection change")
                
                let menuItem = UIMenuItem(title: "Custom Action", action: #selector(doSomething))
                UIMenuController.shared.menuItems = [menuItem]
                
                
                guard let selections = pdfView!.currentSelection
                     else { return }
                
                selections.color = .yellow
//                print(selections.bounds(for: selections.pages[0]))
//        let highlight = PDFAnnotation(bounds: selections.bounds(for: selections.pages), forType: .highlight, withProperties: nil)
//                         highlight.color = .yellow
//        selections.pages.addAnnotation(highlight)
//        selections.forEach({ selection in
//             // Loop over the pages encompassed by each selection
//            selection.color = .red
//             selection.pages.forEach({ page in
//                 print(page.label
//                 )
//                 // Create a new highlight annotation with the selection's bounds and add it to the page
//                 let highlight = PDFAnnotation(bounds: selection.bounds(for: page), forType: .highlight, withProperties: nil)
//                 highlight.color = .yellow
//                 page.addAnnotation(highlight)
//             })
//         })
    }
}

extension PDFView {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
            return false
        }
    
    
}

extension DocumentViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


class TouchUpGestureRecogniser: UIGestureRecognizer {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = UIGestureRecognizer.State(rawValue: 3)!
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = UIGestureRecognizer.State(rawValue: 4)!
    }
    
}
