*** Settings ***
Library  RequestsLibrary
Library  Collections
Resource  ../auth/bearer_token.robot

Test Setup  Get Bearer Token

*** Test Cases ***
Add a product to the cart
    [Documentation]  Test case to add a product to the shopper's cart
    Create Session    cart_session   ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${payload}=  Create Dictionary
    ...  productId=144
    ...  quantity=2

    ${response}=  POST On Session  cart_session   /shoppers/${SHOPPER_ID}/carts   headers=${header}   json=${payload}

    Should Be Equal As Integers  ${response.status_code}  201

    ${body}=  Set Variable  ${response.json()}
    ${item_id}=  Get From Dictionary  ${body}[data]  itemId
    ${product_id}=  Get From Dictionary  ${body}[data]  productId
    Set Suite Variable    ${ITEM_ID}  ${item_id}
    Set Suite Variable    ${PRODUCT_ID}  ${product_id}
    Log To Console    ${body}

Update product in cart
    [Documentation]  Test case to update the quantity of a product in the shopper's cart
    Create Session    cart_session   ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${payload}=  Create Dictionary
    ...  quantity=3

    ${response}=  PUT On Session  cart_session   /shoppers/${SHOPPER_ID}/carts/${ITEM_ID}   headers=${header}   json=${payload}

    Should Be Equal As Integers  ${response.status_code}  200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}
Get products in cart
    [Documentation]  Test case to fetch products in the shopper's cart
    Create Session    cart_session   ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${response}=  GET On Session  cart_session   /shoppers/${SHOPPER_ID}/carts   headers=${header}

    Should Be Equal As Integers  ${response.status_code}  200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}
Delete product from cart
    [Documentation]  Test case to delete a product from the shopper's cart
    Create Session    cart_session   ${BASE_URL}  verify=False
    ${header}=  Create Dictionary  Authorization=Bearer ${token}

    ${response}=  DELETE On Session  cart_session   /shoppers/${SHOPPER_ID}/carts/${PRODUCT_ID}   headers=${header}

    Should Be Equal As Integers  ${response.status_code}  200

