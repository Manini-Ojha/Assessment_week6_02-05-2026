*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../auth/bearer_token.robot

Test Setup  Get Bearer Token

*** Test Cases ***
Add a new Address for a Shopper
    [Documentation]  Test case to add a new address for a shopper
    Create Session    address_session  ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${payload}=  Create Dictionary
    ...  city=Bangalore
    ...  country=India
    ...  firstName=Courage
    ...  lastName=Pinky
    ...  phone=9876543210
    ...  state=KA
    ...  zoneId=ALPHA

    ${response}=  POST On Session  address_session   /shoppers/${SHOPPER_ID}/address   headers=${header}   json=${payload}

    Should Be Equal As Integers  ${response.status_code}  201

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}

    ${address_id}=  Get From Dictionary  ${body}[data]  addressId
    Set Global Variable    ${ADDRESS_ID}  ${address_id}
Get All Addresses of a Shopper
    [Documentation]  Test case to fetch all addresses of a shopper
    Create Session    address_session    ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${response}=  GET On Session  address_session   /shoppers/${SHOPPER_ID}/address  headers=${header}

    Should Be Equal As Integers  ${response.status_code}  200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}
Update an existing Address of a Shopper
    [Documentation]  Test case to update an existing address of a shopper
    Create Session    address_session    ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${payload}=  Create Dictionary
    ...  city=Mumbai
    ...  country=India
    ...  firstName=Courage
    ...  lastName=Pinky
    ...  phone=9876543210
    ...  state=MH
    ...  zoneId=ALPHA

    ${response}=  PUT On Session  address_session   /shoppers/${SHOPPER_ID}/address/${ADDRESS_ID}   headers=${header}   json=${payload}

    Should Be Equal As Integers  ${response.status_code}  200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}
Get a specific Address of a Shopper
    [Documentation]  Test case to fetch a specific address of a shopper using address_id
    Create Session    address_session    ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${response}=  GET On Session  address_session   /shoppers/${SHOPPER_ID}/address/${ADDRESS_ID}   headers=${header}

    Should Be Equal As Integers  ${response.status_code}  200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}
Delete a specific Address of a Shopper
    [Documentation]  Test case to delete a specific address of a shopper using address_id
    Create Session    address_session    ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${response}=  DELETE On Session  address_session   /shoppers/${SHOPPER_ID}/address/${ADDRESS_ID}   headers=${header}
    Should Be Equal As Integers  ${response.status_code}  204

    Log To Console    Address with ID ${ADDRESS_ID} deleted successfully