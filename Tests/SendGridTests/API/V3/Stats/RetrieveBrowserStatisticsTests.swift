@testable import SendGrid
import XCTest

class RetrieveBrowserStatisticsTests: XCTestCase {
    func date(day: Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "2017-09-\(day)")!
    }

    func testMinimalInitialization() {
        let request = RetrieveBrowserStatistics(startDate: date(day: 20))
        XCTAssertEqual(request.description, """
        # GET /v3/browsers/stats?start_date=2017-09-20

        + Request (application/json)

            + Headers

                    Accept: application/json
                    Content-Type: application/json

        """)
    }

    func testMaxInitialization() {
        let request = RetrieveBrowserStatistics(startDate: date(day: 20), endDate: date(day: 27), aggregatedBy: .week, browsers: "Safari", "Google Chrome")
        XCTAssertEqual(request.description, """
        # GET /v3/browsers/stats?aggregated_by=week&browsers=Safari&browsers=Google%20Chrome&end_date=2017-09-27&start_date=2017-09-20

        + Request (application/json)

            + Headers

                    Accept: application/json
                    Content-Type: application/json

        """)
    }

    func testValidation() {
        let good = RetrieveBrowserStatistics(startDate: date(day: 20), endDate: date(day: 27), aggregatedBy: .week)
        XCTAssertNoThrow(try good.validate())

        do {
            let request = RetrieveBrowserStatistics(startDate: date(day: 20), endDate: date(day: 19))
            try request.validate()
            XCTFail("Expected a failure to be thrown when the end date is before the start date, but nothing was thrown.")
        } catch SendGrid.Exception.Statistic.invalidEndDate {
            XCTAssertTrue(true)
        } catch {
            XCTFailUnknownError(error)
        }
    }
}
