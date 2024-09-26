FROM amazonlinux:2023

# Set environment variables if needed (e.g., for non-interactive installs)
ENV DEBIAN_FRONTEND=noninteractive

# Copy the Tesseract installation script into the Docker image
RUN mkdir /install
COPY install_tesseract.sh /install/install_tesseract.sh

# Make sure the script is executable
RUN chmod +x /install/install_tesseract.sh

# Run the Tesseract installation script
RUN /install/install_tesseract.sh

# Ensure Tesseract is in the system path
RUN ldconfig

# Verify the installation
RUN tesseract --version

CMD [ "bash" ]
