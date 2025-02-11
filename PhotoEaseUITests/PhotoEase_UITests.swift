import XCTest

final class PhotoEase_UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func test_PhotoEase_launchApp_fetchPhotos() {
        let listPhotoLoaded = app.staticTexts["Photo List"]
        XCTAssertTrue(listPhotoLoaded.waitForExistence(timeout: 5), "Should show the home screen")
    }
    
    func test_PhotoEase_searchPhoto_shouldNavigateToDetailScreen() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Search bar should exist")
        
        searchField.tap()
        searchField.typeText("Aut")
        
        let listPhoto = app.collectionViews
        let firstItem = listPhoto.cells.element(boundBy: 0)
        
        XCTAssertTrue(firstItem.waitForExistence(timeout: 5), "First item of filtered photos should appear")
        
        firstItem.tap()
        
        let detailScreenTitle = app.staticTexts["Photo Detail"]
        XCTAssertTrue(detailScreenTitle.waitForExistence(timeout: 5), "Should navigate to Photo Detail Screen")
    }
    
    func test_PhotoEase_should_toggle_favorite() {
        let listPhoto = app.collectionViews
        let firstItem = listPhoto.cells.element(boundBy: 0)
        
        
        let favoriteButton = firstItem.buttons.firstMatch
        XCTAssertTrue(favoriteButton.exists, "Favorite button should exist")
        
        favoriteButton.tap()
        
    }
    
    func test_PhotoEase_should_NavigateToPhotoDetail() {
        let listPhoto = app.collectionViews
        let firstItem = listPhoto.cells.element(boundBy: 1)
        
        firstItem.tap()
        
        let detailScreen = app.staticTexts["Photo Detail"]
        XCTAssertTrue(detailScreen.exists, "Should navigate to Photo Detail Screen")
    }
    
    
    func test_PhotoEase_navigationToDetailScreen_shouldDislikePhoto_shouldShowsAlertToConfirm() {
        let listPhoto = app.collectionViews
        let firstItem = listPhoto.cells.element(boundBy: 0)
        
        let favoriteButton = firstItem.buttons.firstMatch
        XCTAssertTrue(favoriteButton.exists, "Favorite button should exist")
        
        favoriteButton.tap()
        
        firstItem.tap()
        
        let detailScreen = app.staticTexts["Photo Detail"]
        XCTAssertTrue(detailScreen.exists, "Should navigate to Photo Detail Screen")
        
        let dislikeButton = app.buttons.element(boundBy: 1)
        
        dislikeButton.tap()
        
        let alert = app.alerts.firstMatch
        sleep(1)
        XCTAssertTrue(alert.waitForExistence(timeout: 2), "Alert should appear")
        
        let cancelButton = alert.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists, "Cancel button should exist")
        
        let confirmButton = alert.buttons["Sure"]
        XCTAssertTrue(confirmButton.exists, "Confirm button should exist")
        
        confirmButton.tap()
    }
}
