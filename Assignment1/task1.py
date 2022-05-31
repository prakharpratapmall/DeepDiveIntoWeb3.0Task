import hashlib
from string import hexdigits
import time
target = "0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
string = input("Enter a String :")
start = time.time()
i = 0
string1 = ""
while True:
    string1 = string + str(i)
    encoded = string1.encode()
    result = (hashlib.sha256(encoded)).hexdigest()
    if(result <= target):
        # print(string1, encoded)
        timetaken = time.time()-start
        print("nonce value = ", i, "\nTime Taken =",
              timetaken, "\nCorresponding Hash = ", result)
        break
    i += 1
