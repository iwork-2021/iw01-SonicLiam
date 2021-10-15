//
//  Calculator.swift
//  MyCaculator
//
//  Created by Liam on 2021/10/15.
//

import UIKit

class Calculator: NSObject {
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    
    var operations = [
        "+":Operation.BinaryOp{
            (op1, op2) in
            return op1+op2
        },
        "-":Operation.BinaryOp{
            (op1, op2) in
            return op1-op2
        },
        "*":Operation.BinaryOp{
            (op1, op2) in
            return op1*op2
        },
        "/":Operation.BinaryOp{
            (op1, op2) in
            return op1/op2
        },
        "=":Operation.EqualOp,
        "%":Operation.UnaryOp{
            op in
            return op/100
        },
        "Clear":Operation.UnaryOp{
            _ in
            return 0
        },
        "pi": Operation.Constant(3.14)
    ]
    
    struct InterMediate{
        var firstOp: Double
        var waitingOperation:(Double, Double)->Double
    }
    
    var pendingOp:InterMediate? = nil
    
    func performOperation(operation:String, operand:Double)->Double?{
        if let op = operations[operation]{
            switch(op){
            case .BinaryOp(let function):
                pendingOp = InterMediate(firstOp: operand, waitingOperation: function)
                return nil
            case .Constant(let value):
                return value
            case .EqualOp:
                return pendingOp!.waitingOperation(pendingOp!.firstOp, operand)
            case .UnaryOp(let function):
                return function(operand)
            }
        }
        return nil
    }
}
