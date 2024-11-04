import subprocess


def lambda_handler(event, context):
    # Better to add these as environmental variables in the Lambda environment
    # LD_LIBRARY_PATH=/opt/lib:/opt/lib64
    # PATH=/opt/bin
    # ...but here's how to invoke directly
    cmd = (
        "LD_LIBRARY_PATH=/opt/lib64:/opt/lib mysqldump --help "
    )

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

    # Step 7: Return the extracted text
    return {"statusCode": 200, "body": output}
