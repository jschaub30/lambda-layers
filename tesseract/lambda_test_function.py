import os
import subprocess

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
LIB_DIR = os.path.join(SCRIPT_DIR, 'lib')


def lambda_handler(event, context):
    cmds = [
            "LD_LIBRARY_PATH=/opt/lib64:/opt/lib /opt/bin/tesseract",
            ]
    
    for cmd in cmds:

        try:
            print(f'Start: {cmd}')
            output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
            print('Finish')
            print(output)
        except subprocess.CalledProcessError as e:
            print('Error')
            print(e.output)
        except Exception as e:
            print('Error e')
            print(e)
            raise e

    return {
        'statusCode': 200,
        'body': ""
    }
