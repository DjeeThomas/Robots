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