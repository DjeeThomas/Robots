*** Settings ***
    
Library    SeleniumLibrary  
    
*** Keywords ***
    
Setup
    Log    setup
    # Start recording    ${TEST NAME}

Teardown
    ${failure_image_path}=    Get failure image path    ${TEST NAME}
    Run Keyword If Test Failed    Take full screenshot    ${failure_image_path}

    # Stop recording
    
    ${documentation}=    Generate failure documentation    ${TEST_DOCUMENTATION}    ${TEST NAME}
    Run Keyword If Test Failed    Set test documentation    ${documentation}

Test suite setup
    ${DefaultBrowser}=    Open browser    ${BROWSER}
    Set suite variable    ${DefaultBrowser}    ${DefaultBrowser}

Test suite teardown
    Close all browsers

    