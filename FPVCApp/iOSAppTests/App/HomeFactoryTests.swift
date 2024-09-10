//
//  Tests.swift
//  Tests
//
//  Created by Gui Reis on 10/09/24.
//

@testable import FPVCApp
import XCTest


final class HomeFactoryTests: XCTestCase {
    
    var controller: UIViewController!
    
    
    // MARK: -  Ciclo de Vida
    override func setUp() {
        super.setUp()
        controller = HomeFactory.makeController()
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    
    // MARK: - Testes
    func test_controller_dependecies() {
        /* Prepare */
        
        /* Action */
        guard let controller = controller as? HomeViewController else {
            return XCTFail(FailTexts.msg01)
        }
        
        /* Validations */
        XCTAssertNil(controller.collectionHandler, FailTexts.msg04)
        
        XCTAssertNotNil(controller.dispatcher, FailTexts.msg02)
        XCTAssertIdentical(controller.dispatcher?.provider, DispatchQueue.main, FailTexts.msg01)
        
        XCTAssertNotNil(controller.viewModel, FailTexts.msg02)
        XCTAssertNotNil(controller.viewModel as? HomeViewModel, FailTexts.msg01)
    }
    
    
    func test_viewModel_dependecies() {
        /* Prepare */
        let controller = controller as? HomeViewController
        
        /* Action */
        guard let viewModel = controller?.viewModel as? HomeViewModel else {
            return XCTFail(FailTexts.msg01)
        }
        
        /* Validations */
        XCTAssertNotNil(viewModel.mainBinding, FailTexts.msg02)
        XCTAssertIdentical(viewModel.mainBinding, controller, FailTexts.msg01)
        
        XCTAssertNotNil(viewModel.mainWorker, FailTexts.msg02)
        XCTAssertNotNil(viewModel.mainWorker as? MarvelCharacterWorker, FailTexts.msg01)
        
        XCTAssertNotNil(viewModel.searchWorker, FailTexts.msg02)
        XCTAssertNotNil(viewModel.searchWorker as? MarvelCharacterWorker, FailTexts.msg01)
        
        XCTAssertNotIdentical(viewModel.mainWorker, viewModel.searchWorker,  FailTexts.msg03)
    }
}



fileprivate enum FailTexts {
    
    static var msg01: String {
        "Dependência do tipo errada"
    }
    
    static var msg02: String {
        "Dependência nula!"
    }
    
    static var msg03: String {
        "Não podem ser da mesma referência pois são requests distintas"
    }
    
    static var msg04: String {
        "Dependências vai ser consfigurada depois, não deve ser configurada na factory!"
    }
}
