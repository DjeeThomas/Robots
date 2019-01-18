*** Variables ***
${BROWSER}    firefox
${STOVE_MODEL}    Electrolux EKI55951OW
${PRODUCT_JSON}    Products.json

# List of web elements
${VK_KODINKONEET}    id=sidebar-item-19a
${SEARCH_INPUT}    name=query
${SEARCH_BUTTON}    name=submit
${CLICK_PRODUCT}    css=.list-product-info__link
${VK_ALLOW_COOKIES}    name=allow-cookies
#${VK_PRODUCT_PRICE}    css=.price-tag-price__euros
${VK_PRODUCT_PRICE}    css=.price-tag-content__price-tag-price--current