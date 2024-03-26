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
    
    func testResultViewWithValues() {
        //given
        let size = CGSize(width: screenWidth, height: 224) //iphone 15 pro
        let result = Result(
            amountPerPerson: 100,
            totalBill: 45,
            totalTip: 60)
        //when
        let view = ResultView()
        view.configure(result: result)
        //then
        assertSnapshot(of: view, as: .image(size: size), record: false)
    }
    
    func testInitialBillInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56) //iphone 15 pro
        //when
        let view = BillInputView()
        //then
        assertSnapshot(of: view, as: .image(size: size), record: false)
    }
    
    func testBillInputViewWithValues() {
        //given
        let size = CGSize(width: screenWidth, height: 56) //iphone 15 pro
        //when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "123"
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
    
    func testTipInputViewWithValues() {
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16) //iphone 15 pro
        //when
        let view = ResultView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshot(of: view, as: .image(size: size), record: false)
    }
    
    
}


extension UIView {

/** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
        func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
            var all = [T]()
            func getSubview(view: UIView) {
                if let aView = view as? T{
                all.append(aView)
                }
                guard view.subviews.count>0 else { return }
                view.subviews.forEach{ getSubview(view: $0) }
            }
            getSubview(view: self)
            return all
        }
    }
