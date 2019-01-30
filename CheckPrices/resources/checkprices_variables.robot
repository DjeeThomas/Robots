*** Variables ***
${BROWSER}    firefox
${STOVE_MODEL}    Electrolux EKI55951OW
${PRODUCT_JSON}    Products.json

# List of web elements for Verkkokauppa.com
${VK_KODINKONEET}    id=sidebar-item-19a
${SEARCH_INPUT}    name=query
${SEARCH_BUTTON}    name=submit
${CLICK_PRODUCT}    css=.list-product-info__link
${VK_ALLOW_COOKIES}    name=allow-cookies
#${VK_PRODUCT_PRICE}    css=.price-tag-price__euros
${VK_PRODUCT_PRICE}    css=.price-tag-content__price-tag-price--current

# List of web elements for Gigantti.fi
${GG_SEARCH_INPUT}    id=main-search
${GG_SEARCH_BUTTON}    css=button.button.svg-icon
${GG_PRODUCT_PRICE}    css=div.product-price-container > span