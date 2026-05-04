*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../auth/bearer_token.robot

Test Setup  Get Bearer Token

*** Test Cases ***
Get Products in Wishlist
    [Documentation]  Test case to fetch products in shopper's wishlist
    Create Session    wishlist_session  ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${response}=  GET On Session  wishlist_session   /shoppers/${SHOPPER_ID}/wishlist   headers=${header}

    Should Be Equal As Integers  ${response.status_code}  200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}
Delete Product from Wishlist
    [Documentation]  Test case to delete a product from shopper's wishlist
    Create Session    wishlist_session  ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${response}=  DELETE On Session  wishlist_session   /shoppers/${SHOPPER_ID}/wishlist/144   headers=${header}

    Should Be Equal As Integers  ${response.status_code}  204
Add Product to Wishlist
    [Documentation]  Test case to add a product to shopper's wishlist
    Create Session    wishlist_session  ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${payload}=  Create Dictionary
    ...  productId=144

    ${response}=  POST On Session  wishlist_session   /shoppers/${SHOPPER_ID}/wishlist   headers=${header}   json=${payload}

    Should Be Equal As Integers  ${response.status_code}  201

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}