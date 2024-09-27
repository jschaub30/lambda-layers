import subprocess


def lambda_handler(event, context):
    image_path = "/opt/test/img.png"  # test image in the lambda layer
    output_txt_path = "/tmp/output_text"

    # Better to add these as environmental variables in the Lambda environment
    # LD_LIBRARY_PATH=/opt/lib:/opt/lib64
    # TESSDATA_PREFIX=/opt/tessdata
    # PATH=/opt/bin
    # ...but here's how to invoke directly
    cmd = (
        "LD_LIBRARY_PATH=/opt/lib64:/opt/lib TESSDATA_PREFIX=/opt/tessdata "
        + f"/opt/bin/tesseract {image_path} {output_txt_path}"
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
    result_txt_file = f"{output_txt_path}.txt"
    with open(result_txt_file) as f:
        ocr_text = f.read()

    # Step 7: Return the extracted text
    return {"statusCode": 200, "body": ocr_text}
