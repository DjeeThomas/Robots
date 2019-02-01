# encoding: utf-8
from time import sleep
from datetime import date
import datetime
import os, errno
from os.path import dirname, realpath
import codecs
import sys
import json
import io
import platform

class JsonHandling():

    def __init__(self):
        """
        Class initialization

        """
        pass
    
    def read_json_file(self, filename=None, testing=False):
        """
            Reads a json file and returns a dictionary with its content
        """
        print ("Json stuff works!")
        folder = os.path.dirname(filename)
        if not os.path.isdir(folder) and folder:
            os.mkdir(folder)
            print ("Folder " + folder + " created")

        full_path = os.path.join(os.getcwd(), "resources")
        full_filename = os.path.join (full_path, filename)

        # if " " in full_filename:
        #     QAutoRobot.fail("The path and file name cannot contain spaces. " + full_filename)
        # print "Full path for users file" + full_filename
        # This gives the folder one level down from the current working folder
        RPA_path = dirname(realpath(os.getcwd()))
        
        try:
            with open(full_filename, 'r') as jsonfile:
                products_list = json.load(jsonfile)
        except IOError as e:
            return ("Error opening the file ({0}): {1}".format(e.errno, e.strerror))
        except ValueError:  # includes simplejson.decoder.JSONDecodeError
            return ("Error reading data from the json file")
        except:
            return ("Unexpected error:", sys.exc_info()[0])
            
        return products_list

    def json_logger(self, filename=None, robotname=None, message=None):
        """
        :param filename: Path to the .json file where the information will be saved. Must be full path.
        :param robotname: Name of the robot that generated the message to be saved
        :param time: Current timestamp
        :param message: Message to be saved to the filename
        -------------

        Constructs a string based on the message and time and saves it to the filename under the robotname key
        """

        #if not self.file_exists(filename):
            #[ e['Email'] for e in exceptions]
            # Result: "Comment: User "name" is missing "xx" days for this week
            # for i in message:
            #     step_list.append("".join(["{Steps:", i, "}"])) 

        robot_list = [{"Robot":robotname, "Sections":message}]
        print ("Type of robot_list" + str(type(robot_list)))
        print (robot_list)
        #else:
            #msg_to_save = [{"Robot": robotname, "Timestamp": unicode(time, "utf-8"), "Comment": message}]
        #if not(os.path.isfile(filename)):
            # If the file doesn't exist, the string to save needs to be in a special format
        #    msg_json = json.dumps(msg_to_save)


        self.append_to_json_file(filename, robot_list)
        #return msg_to_save
    
    def file_exists(self, filepath):
        return os.path.isfile(filepath)


    def append_to_json_file(self, filename=None, to_save=None):
        """
        :param filename: Path to the .json file where the information will be saved. Must be full path.
        :param to_save: Information to save to the json file
        -------------
        
        Constructs a string based on the message and time and saves it to the filename under the robotname key
        """

        try:
            with io.open(filename, "a", encoding='utf-8') as myfile:
                myfile.write(json.dumps(to_save, ensure_ascii=False, indent=4))
        except IOError as e:
            QAutoRobot.fail("Error writing data to the file ({0}): {1}".format(e.errno, e.strerror))
