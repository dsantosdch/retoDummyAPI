@ignore
Feature: request the Dummy API

  Background:
    * url 'https://dummy.restapiexample.com/api/v1/'
    * configure retry = {count:5, interval:5000}

  Scenario: Get all employees
    Given path 'employees/'
    When method GET
    Then retry until status 200
    And match response contains {message:'Successfully! All records has been fetched.'}
    * print response

  Scenario: Get employee by id
    Given path 'employee/1'
    And retry until responseStatus == 200
    When method GET
    Then status 200
    And match response contains {"status":"success", "message":"Successfully! Record has been fetched."}
    * print response

  Scenario: Create employees with id and name
    Given path 'create/'
    And request {"id":"128", "name":"Luis"}
    When method POST
    Then assert status 200

  Scenario: Update employee by id
    Given path 'update/1'
    And request {employee_name:"Carlos Perez"}
    When method PUT
    Then status 200
    And match response contains {"status":"success", "message":"Successfully! Record has been updated."}

  Scenario Outline: Delete employee by <id>
    Given path 'delete/<id>'
    And retry until responseStatus == 200
    When method DELETE
    Then status 200
    And match response contains {"status":"success", "message":"Successfully! Record has been deleted"}

    Examples:
      |id   |
      |2    |
      |3    |

