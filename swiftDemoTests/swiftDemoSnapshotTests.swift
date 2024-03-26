//
//  swiftDemoSnapshotTests.swift
//  swiftDemoTests
//
//  Created by Dmitry P on 26.03.24.
//

import XCTest
import SnapshotTesting
@testable import swiftDemo

final class swiftDemoSnapshotTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        //given
        let size = CGSize(width: screenWidth, height: 48) //iphone 15 pro
        //when
        let view = LogoView()
        //then
        assertSnapshot(of: view, as: .image(size: size), record: false)
        
    }
    
    func testInitialResultView() {
        //given
        let size = CGSize(width: screenWidth, height: 224) //iphone 15 pro
        //when
        let view = ResultView()
        //then
        assertSnapshot(of: view, as: .image(size: size), record: false)
        
    }
    
    func testInitialTipInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16) //iphone 15 pro
        //when
        let view = ResultView()
        //then
        assertSnapshot(of: view, as: .image(size: size), record: false)
        
    }
    
    
}
