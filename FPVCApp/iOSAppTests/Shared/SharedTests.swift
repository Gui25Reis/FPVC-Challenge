//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import XCTest

/**
 Essa estrutura possue testes que são várias vezes durante os testes, seja na mesma função de teste ou até mesmo me outras classes.
 
 Com o objetivo de evitar repetição de código e facilitar ao realizar os testes.
 */
enum SharedTests {
    
}


// MARK: - + Coder
extension SharedTests {
    
    enum Coder {
        
        private static var coder: NSCoder { MockModels.makeValidCoder() }
        
        /// Implementação utilizada para as views, validando o inicializador de coder
        static func initializeFromCoder<T: UIView>(view: T.Type) -> T? {
            return view.init(coder: coder)
        }
        
        /// Implementação utilizada para as views, validando o inicializador de coder
        static func initializeFromCoder<T: UIViewController>(controller: T.Type) -> T? {
            return controller.init(coder: coder)
        }
    }
}

