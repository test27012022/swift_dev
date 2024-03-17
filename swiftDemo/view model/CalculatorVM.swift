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
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        input.tipPublisher.sink { tip in
            print("tip percent \(tip)")
        }.store(in: &cancellables)
        
        let result = Result(
            amountPerPerson: 10,
            totalBill: 23,
            totalTip: 50)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher() )
    }
}
