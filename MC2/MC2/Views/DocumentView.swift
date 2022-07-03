//
//  DocumentView.swift
//  MC2
//
//  Created by Widya Limarto on 29/06/22.
//

import SwiftUI

struct DocumentVCRepresentable: UIViewControllerRepresentable {
    var filePath: URL
    var fileName: String
    
    func makeCoordinator() -> Self.Coordinator { Coordinator() }
    
    class Coordinator {
        var parentObserver: NSKeyValueObservation?
    }
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Document", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "document") as! DocumentViewController
        controller.filePath = filePath
        controller.fileName = fileName
        
        context.coordinator.parentObserver = controller.observe(\.parent, changeHandler: { vc, _ in
            
        })
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct DocumentView: View {
    var filePath: URL
    var fileName: String
    var body: some View {
        VStack{
            
            DocumentVCRepresentable(filePath: filePath, fileName: fileName)
        }
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(filePath: URL(fileURLWithPath: ""), fileName: "")
    }
}
