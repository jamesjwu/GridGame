//
//  SquareGameBoard.swift
//  GridGame
//
//  Created by James Wu on 10/7/14.
//  Copyright (c) 2014 James Wu. All rights reserved.
//

import Foundation
/// Taken from swift-2048

/// A struct representing a square gameboard. Because this struct uses generics, it could conceivably be used to
/// represent state for many other games without modification.
struct SquareGameboard<T> {
  let dimension: Int
  var boardArray: [T]
  
  init(dimension d: Int, initialValue: T) {
    dimension = d
    boardArray = [T](count:d*d, repeatedValue:initialValue)
  }
  
  subscript(row: Int, col: Int) -> T {
    get {
      assert(row >= 0 && row < dimension)
      assert(col >= 0 && col < dimension)
      return boardArray[row*dimension + col]
    }
    set {
      assert(row >= 0 && row < dimension)
      assert(col >= 0 && col < dimension)
      boardArray[row*dimension + col] = newValue
    }
  }
  
  // We mark this function as 'mutating' since it changes its 'parent' struct.
  mutating func setAll(item: T) {
    for i in 0..<dimension {
      for j in 0..<dimension {
        self[i, j] = item
      }
    }
  }
}