#!/bin/env python
import os

something=input("ENTER SOMETHING: ")
print(f'you entered {something}')
os.system(f"echo {something} | /usr/bin/xsel -b")
wait=input('wait')
