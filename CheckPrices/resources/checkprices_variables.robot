*** Variables ***
${BROWSER}    firefox
${PRODUCT_JSON}    Products.json

# List of web elements for Verkkokauppa.com
${VK_KODINKONEET}    id=sidebar-item-19a
${VK_SEARCH_INPUT}    name=query
${VK_SEARCH_BUTTON}    name=submit
${VK_CLICK_PRODUCT}    css=.list-product-info__link
${VK_ALLOW_COOKIES}    name=allow-cookies
${VK_PRODUCT_PRICE}    css=.price-tag-content__price-tag-price--current

# List of web elements for Gigantti.fi
${GG_SEARCH_INPUT}    id=main-search
${GG_SEARCH_BUTTON}    css=button.button.svg-icon
${GG_PRODUCT_PRICE}    css=div.product-price-container > span

# List of web elements for Power.fi
${PO_ALLOW_COOKIES}    id=cookie-notification-accept
${PO_SEARCH_INPUT}    id=search-input
${PO_SEARCH_BUTTON}    id=search-button
${PO_PRODUCT}    id=short-desc-test-a
${PO_PRODUCT_PRICE}    css=.nomargin:nth-child(1)
${PO_PROMO_POPUP_OPEN}    id=sleeky-open
${PO_PROMO_POPUP_CLOSE}    id=sleeky-close