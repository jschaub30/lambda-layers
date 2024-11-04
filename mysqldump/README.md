# Lambda layers for mysqldump

`mysqldump` is a command-line utility for creating backups of MySQL databases by exporting
database structures and data to a SQL file.

The layer can be found at [layer/mysqldump-layer-x86_64.zip](layer/mysqldump-layer-x86_64.zip).

Use the [lambda_test_function.py](lambda_test_function.py) to test.  It should complete in around
13 seconds with the default Lambda memory settings.

### Details
mysqldump Ver 8.0.40 for Linux on x86_64

## Build it yourself
Create an EC2 instance using the amazonlinux:2023 AMI.

Copy and run the [`install_mysqldump.sh`](install_mysqldumkp.sh) script as the `root` user.

Run the [`create_layer.sh`](create_layer.sh) script.
