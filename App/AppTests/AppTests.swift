//
//  AppTests.swift
//  AppTests
//
//  Created by walterlee on 2019/12/24.
//  Copyright © 2019 walterlee. All rights reserved.
//

import XCTest
@testable import App

class AppTests: XCTestCase {
  let evalJs: String =
  """
  (function foo(param) {
    var _params = params,
        age = _params.age,
        level = _params.level,
        interests = _params.interests,
        interest = _params.interest,
        profession = _params.profession;

    /* to be generated
    const {age,level,interest,interests,profession} = param;
    */
    return (
      /**start**/
      age > 18 || age < 18 + 12 && level === '3' && interests.includes('出国游') && ['出国游', '看电影'].includes(interest) || !(profession === '上班族')
      /**end**/

    );
  })([{"age":19},{"level":"3"},{"interests":["出国游","看电影","逛街"]},{"interest":"看电影"},{"profession":"自由职业"}])
  """
  
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
