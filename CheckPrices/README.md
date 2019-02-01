# Robot to check prices of products on various sites
The robot checks prices of specific products on different we pages. Currently supported ones are:
- Verkkokauppa: https://www.verkkokauppa.com
- Gigantti: https://www.gigantti.fi
- Power: https://www.power.fi

The main goal of this robot is to check if there are special discounts on a specific product. For this, the robot will need to run periodically. This will probably be accomplished by running it via Jenkins.

## Setting up the environment

### Required Software

- Python v3.6 or later
- Robot Framework v3.1.1 or later
- SeleniumLibrary for Robot Framework v3.3.1 or later
- Web browser with corresponding web driver. Developed using Firefox. 
- Selenium used to extract locators and other page information
- Selenium and the web driver taken from https://www.seleniumhq.org/download/

## How to use
The robot reads data from Products.json which is located in the resources folder. The information added should follow this format:
    {
        "Product Name": "Name of product",
        "Product Model": "Model to be used in the search",
		"Pages to Check": [
			{
				"Title": "Verkkokauppa",
                "Address": "https://www.verkkokauppa.com"
            },
            {
				"Title": "Another page",
                "Address": "Another URL"
            }
        ],
        "Price Target": "Desired price you want to pay for product"
    }

## Current progress
### The following features are implemented and working
- Read data from Products.json
- Search for the products in the pages specified on the json file. Only the pages mentioned in "Robot to check prices of products on various sites" are supported
- Current price for the product can be found from the Robot Framework report

### Planned features, not yet implemented
- Generate a report in json format with the results of the searches
- Flag the products that match the price criteria
- Run this robot in Jenkins. Make it periodically.
- Create a way of notifying the user if a deal is found, either via a a dashboard or an email message, or both
