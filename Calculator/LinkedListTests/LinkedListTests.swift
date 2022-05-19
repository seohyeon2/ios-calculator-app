import XCTest
@testable import Calculator

class LinkedListTests: XCTestCase {
    // MARK: Setting
    var sut: DoublyLinkedList<Double>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DoublyLinkedList<Double>()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: Test_append(data: T)
    func testLinkedList에_값이_data에_저장_되는지() {
        // given
        sut.append(data: 1)
        // when
        let result = sut.head?.data
        // then
        XCTAssertEqual(result, 1)
    }
    
    func testLinkedList에_값을_추가했을_때_tail의_prev가_이전_노드를_가리키는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        // when
        let result = sut.tail?.prev?.data
        // then
        XCTAssertEqual(result, 2)
    }
    
    func testLinkedList에_값을_추가했을_때_이전_노드의_next가_tail을_가리키는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        // when
        let result = sut.tail?.prev?.next?.data
        // then
        XCTAssertEqual(result, 3)
    }
    
    func testLinkedList에_값을_추가했을_때_count가_잘_늘어나는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        // when
        let result = sut.count
        // then
        XCTAssertEqual(result, 3)
    }
    
    // MARK: Test_removeLast()
    func testLinkedList의_마지막_값이_삭제_되는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        sut.removeLast()
        // when
        let result = sut.tail?.data
        // then
        XCTAssertEqual(result, 2)
    }
    
    func testLinkedList가_비어있을_때_삭제해도_count값이_0인지() {
        // given
        sut.removeLast()
        sut.removeLast()
        // when
        let result = sut.count
        // then
        XCTAssertEqual(result, 0)
    }
    
    func testLinkedList가_비어있을_때_nil값을_반환하는지() {
        // given when
        let result = sut.removeLast()
        // then
        XCTAssertEqual(result, nil)
    }
    
    func testLinkedList에_값이_1개_있을_때_head가_잘_삭제되는지() {
        // given
        sut.append(data: 1)
        sut.removeLast()
        // when
        let result = sut.head?.data
        // then
        XCTAssertEqual(result, nil)
    }
    
    // MARK: Test_removeAll()
    func testLinkedList를_다_삭제할시_head값이_nil이_되는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        sut.removeAll()
        // when
        let result = sut.head?.data
        // then
        XCTAssertEqual(result, nil)
    }
    
    func testLinkedList를_다_삭제할시_tail값이_nil이_되는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        sut.removeAll()
        // when
        let result = sut.tail?.data
        // then
        XCTAssertEqual(result, nil)
    }
    
    func testLinkedList를_다_삭제할시_count값이_0이_되는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        sut.removeAll()
        // when
        let result = sut.count
        // then
        XCTAssertEqual(result, 0)
    }
    
    // MARK: Test_showData()
    func testLinkedList에_값이_없을_경우_빈_배열이_반환되는지() {
        // given when
        let result = sut.showData()
        // then
        XCTAssertEqual(result, [])
    }
    
    func testLinkedList에_값이_있을_경우_모든_값이_반환되는지() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        // when
        let result = sut.showData()
        // then
        XCTAssertEqual(result, [1,2,3])
    }
    
    func testLinkedList에_값이_있을_경우_모든_값이_반환되는지2() {
        // given
        sut.append(data: 1)
        sut.append(data: 2)
        sut.append(data: 3)
        sut.removeAll()
        // when
        let result = sut.showData()
        // then
        XCTAssertEqual(result, [])
    }
}
