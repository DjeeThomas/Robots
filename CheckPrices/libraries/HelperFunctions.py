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

    def compare_price(self, product, current_price):
        target = self.convert_to_float(product["Price Target"])
        price = self.convert_to_float(current_price)
