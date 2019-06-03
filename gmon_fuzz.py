#!/usr/bin/python

from boofuzz import *

host = '10.0.0.130'    # Windows XP target
port = 9999            # VulnServer port

def main():
	session = Session(target = Target(connection = SocketConnection(host, port, proto='tcp')))
	
	s_initialize("GMON")    # Session name
	
	s_string("GMON", fuzzable = False)    # These strings are fuzzqable by default, so here instead of blank, we specify 'false'
	s_delim(" ", fuzzable = False)        # We don't want to fuzz the space between "GMON" and our arg
	s_string("FUZZ")                      # This value is arbitrary as we did not specify 'False' for fuzzing. Boofuzz will fuzz this string now.
	
	session.connect(s_get("GMON"))        # Having our 'session' variable connect following the guidelines established in "GMON"
	session.fuzz()                        # Calling this function actually performs the fuzzing

if __name__ == "__main__":
	main()
