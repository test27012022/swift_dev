//
//  CalculatorVM.swift
//  swiftDemo
//
//  Created by Dmitry P on 8.03.24.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let anyPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    func transform(input: Input) -> Output {
        
        let result = Result(
            amountPerPerson: 10,
            totalBill: 23,
            totalTip: 50)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher() )
    }
   
    
    
// exercise
    
    private var cancellables = Set<AnyCancellable>()
    private func callToPublisher(input: Input) {
        input.billPublisher.sink { bill in
            print(" the bill in VM - \(bill)")
        }.store(in: &cancellables)

    }
}
