from  JsonHandling import JsonHandling
import re

class HelperFunctions():
    def __init__(self):
        """
        Pagemodel initialization

        """
        pass
    
    def string_matches (self, str1, str2):
        """
        Helper function to check if str1 is included in str2
        
        """
        if str1 in str2:
            return True
        else:
            return False

    def convert_to_float(self, num_str):
        """
        Converts a string into a float if the separating characters are , or . 
        If there is no decimals, it returns the number as an integer
        If the string has more than two parts, it returns 0
        """

        num_list = re.split('[, .]',num_str)
        if len (num_list) == 2:
            number = float(int(num_list[0]) + int(num_list[1])/100 )
        elif len (num_list) == 1:
            number = int(num_list[0])
        else:
            number = 0
        return number

    def compare_price(self, target_price, current_price):
        target = self.convert_to_float(target_price)
        price = self.convert_to_float(current_price)
        if price <= target:
            print ("You found it! " + "Target: " + str(target) + " Current price: " + str(price))
            return True
        else:
             print ("Major bummer! Maybe next time! " + "Target: " + str(target) + " Current price: " + str(price))
             return False
    
    def save_report(self, product, address, is_match, current_price, filename):
        
        report = JsonHandling()
        print (type(is_match))
        if is_match == True:
            print ("Well, look at that!")
            found_in_page = address["Title"]
        else:
            return "Not a match. Nothing to save"

        
        if report.file_exists(filename):
            print ("File exists!")
            # Load existing file to a list
            product_list = report.read_json_file(filename)
            print (product_list)
            #int_list = []
            for prod in product_list:
                if prod["Product Name"] ==  product["Product Name"]:
                    print ("Holly crap! You found one! Well done!")
                    prod["Pages Checked"].append({"Title": found_in_page,"Current Price": current_price})
                    prod["Price Target"]["Found in"].append(found_in_page)
            report.write_to_json_file(filename, product_list)
            # Find if it has the product
            # If it does, add the information there
        else:
            #print ("File doesn't exist! Creating one...")
            d1 = {k: product[k] for k in product.keys() & {'Product Name', 'Product Model'}}
            d1.update({"Pages Checked": [{"Title": address["Title"], "Current Price": current_price}], "Price Target":{"Target": product["Price Target"], "Found in":[found_in_page]}})
            prod_to_save = [d1]
            report.append_to_json_file(filename, prod_to_save)
            print (prod_to_save)
            return "Report file didn't exist! A new one was created."

