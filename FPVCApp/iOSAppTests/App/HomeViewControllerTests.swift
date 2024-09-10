//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

@testable import FPVCApp
import XCTest

import KingsFoundation


final class HomeViewControllerTests: XCTestCase {
    
    var controller: HomeViewController!
    
    var handler: HomeCollectionHandlerMock!
    var viewModel: HomeViewModelMock!
    var navigation: NavigationSpy!
    var dispatcher: KFDispatchQueueMock!
    
    
    // MARK: -  Ciclo de Vida
    override func setUp() {
        super.setUp()
        handler = HomeCollectionHandlerMock()
        viewModel = HomeViewModelMock()
        navigation = NavigationSpy()
        dispatcher = KFDispatchQueueMock()
        
        controller = HomeViewController()
        controller.collectionHandler = handler
        controller.viewModel = viewModel
        controller.dispatcher = KFDispatcherQueue(provider: dispatcher)
    }
    
    override func tearDown() {
        handler.clearVariables()
        
        dispatcher = nil
        viewModel = nil
        navigation = nil
        handler = nil
        controller = nil
        super.tearDown()
    }
    
    
    // MARK: - Testes
    func test_init() {
        /* Validations */
        XCTAssertNotNil(controller.tabBarItem.title)
        XCTAssertNotNil(controller.tabBarItem.image)
    }
    
    func test_init_coder() {
        /* Action */
        let sut = SharedTests.Coder.initializeFromCoder(
            controller: HomeViewController.self
        )
        
        /* Validations */
        XCTAssertNil(sut)
    }
    
    
    // MARK: Atributos
    func test_controllerTitle() {
        /* Prepare */
        
        /* Action */
        let title = controller.controllerTitle
        
        /* Validations */
        XCTAssertNotNil(title)
    }
    
    func test_screen() {
        /* Prepare */
        
        /* Action */
        let screen = controller.screen
        
        /* Validations */
        XCTAssertNotNil(screen.delegate)
        XCTAssertIdentical(screen.delegate, controller)
    }
    
    func test_searchHandler() {
        /* Prepare */
        
        /* Action */
        let search = controller.searchHandler
        
        /* Validations */
        XCTAssertTrue(viewModel.didCallCreateSearchController)
        XCTAssertIdentical(search, viewModel.controllerToReturn)
    }
    
    
    // MARK: Ciclo de Vida
    func test_loadView() {
        /* Prepare */
        
        /* Action */
        controller.loadView()
        
        /* Validations */
        XCTAssertIdentical(controller.view, controller.screen)
    }
    
    func test_viewDidLoad() {
        /* Prepare */
        controller.collectionHandler = handler
        
        /* Action */
        controller.viewDidLoad()
        
        /* Validations */
        XCTAssertNotNil(controller.collectionHandler)
        XCTAssertNotIdentical(controller.collectionHandler, handler)
        
        XCTAssertTrue(viewModel.didCallFetchData)
    }
    
    
    func test_viewWillAppear() {
        /* Prepare */
        let tabBar = UITabBarController()
        tabBar.viewControllers = [controller]
        
        controller.collectionHandler = handler
        
        /* Action */
        controller.viewWillAppear(false)
        
        /* Validations */
        XCTAssertTrue(handler.didCallUpdateLastSelectedCellIfNeeded)
        
        XCTAssertEqual(false, controller.tabBarController?.tabBar.isHidden)
        XCTAssertTrue(controller.navigationItem.hidesSearchBarWhenScrolling)
        XCTAssertEqual(controller.navigationItem.title, controller.controllerTitle)
        XCTAssertNotNil(controller.navigationItem.title)
    }
    
    
    // MARK: HomePresenter
    func test_updateCollectionData() {
        /* Prepare */
        let dataMock = [MockModels.Marvel.makeCharacterData()]
        let statusMock = true
        
        /* Action */
        controller.updateCollectionData(with: dataMock, canLoadMoreData: statusMock)
        
        /* Validations */
        XCTAssertTrue(handler.didCallNewData)
        XCTAssertIdentical(handler?.dataReceived?.first, dataMock.first)
        
        XCTAssertTrue(handler.didSetCanLoadMoreData)
        XCTAssertEqual(handler.canLoadMoreDataMock, statusMock)
        
        XCTAssertTrue(dispatcher.didCallAsync)
        XCTAssertNotNil(controller.navigationItem.searchController)
        XCTAssertIdentical(controller.searchHandler, controller.navigationItem.searchController)
    }
    
    func test_updateCollectionData_noSearchSetup() {
        /* Prepare */
        let dataMock = [MockModels.Marvel.makeCharacterData()]
        let statusMock = true
        
        let searchMock = UISearchController()
        controller.navigationItem.searchController = searchMock
        
        /* Action */
        controller.updateCollectionData(with: dataMock, canLoadMoreData: statusMock)
        
        /* Validations */
        XCTAssertTrue(handler.didCallNewData)
        XCTAssertIdentical(handler?.dataReceived?.first, dataMock.first)
        
        XCTAssertTrue(handler.didSetCanLoadMoreData)
        XCTAssertEqual(handler.canLoadMoreDataMock, statusMock)
        
        XCTAssertTrue(dispatcher.didCallAsync)
        XCTAssertNotNil(controller.navigationItem.searchController)
        
        XCTAssertNotIdentical(controller.searchHandler, controller.navigationItem.searchController)
        XCTAssertIdentical(searchMock, controller.navigationItem.searchController)
    }
    
    func test_updateCollectionData_emptyData() {
        /* Prepare */
        let dataMock = [MarvelCharacterData]()
        let statusMock = true
        
        /* Action */
        controller.updateCollectionData(with: dataMock, canLoadMoreData: statusMock)
        
        /* Validations */
        XCTAssertTrue(handler.didCallNewData)
        XCTAssertNotNil(handler?.dataReceived)
        XCTAssertEqual(true, handler?.dataReceived?.isEmpty)
        
        XCTAssertTrue(handler.didSetCanLoadMoreData)
        XCTAssertEqual(handler.canLoadMoreDataMock, statusMock)
        
        XCTAssertFalse(dispatcher.didCallAsync)
        XCTAssertNil(controller.navigationItem.searchController)
    }
    
    
    // MARK: HomeCollectionHandlerDelegate
    func test_fetchMoreData() {
        /* Prepare */
        
        /* Action */
        controller.fetchMoreData()
        
        /* Validations */
        XCTAssertTrue(viewModel.didCallFetchMoreData)
        XCTAssertFalse(viewModel.didCallFetchData)
    }
    
    func test_routeToInfos() {
        /* Prepare */
        let data = MockModels.Marvel.makeCharacterData()
        navigation.pushViewController(controller, animated: false)
        
        /* Action */
        controller.routeToInfos(with: data)
        
        /* Validations */
        XCTAssertTrue(navigation.pushActionCalled)
        XCTAssertEqual(true, navigation.animatedStatusReceived)
    }
    
    
    // MARK: HomeScreenDelegate
    func test_tryAgainAction() {
        /* Prepare */
        controller.screen.showEmptyView()
        
        /* Action */
        controller.tryAgainAction()
        
        /* Validations */
        XCTAssertFalse(viewModel.didCallFetchMoreData)
        XCTAssertFalse(viewModel.didCallFetchData)
        XCTAssertTrue(viewModel.didCallTryNewFetchAgain)
        
        XCTAssertTrue(controller.screen.emptyView.isHidden)
        XCTAssertNotNil(controller.screen.collection.loadingIndicator)
    }
    
    
    // MARK: Invalid Test
    func test_fake() {
        /* Prepare */
        
        /* Action */
        controller.viewWillDisappear(false)
        
        /* Validations */
        
    }
}
