import requests
import sys
import json

class Colors:
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'

CS_API = "https://ciphersuite.info/api/cs/"

if len(sys.argv) != 2:
        exit(f"usage: {sys.argv[0]} <cipher_name>")

CIPHER_NAME = str(sys.argv[1])

def isCipherWeak(cipher):
        try:
                r = requests.get(CS_API + cipher).json()[cipher]
                security = r['security'].lower()
                if security == 'weak':
                        return True
                else:
                        return False
        except json.decoder.JSONDecodeError:
                print(f"> Error checking: {cipher}")
                return False


if isCipherWeak(CIPHER_NAME):
        print(f"[{Colors.OKBLUE}*{Colors.ENDC}] {Colors.BOLD}{CIPHER_NAME}{Colors.ENDC} is deemed to be: {Colors.FAIL}Weak{Colors.ENDC}")
        print(f"   -> https://ciphersuite.info/cs/{CIPHER_NAME} for more information.")
else:
        pass







