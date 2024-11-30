# # Use a lightweight Python image
# FROM python:3.9-slim

# # Set the working directory
# WORKDIR /app

# # Copy the application files
# COPY . .

# # Install dependencies
# RUN pip install flask

# # Expose the application port
# EXPOSE 5000

# # Command to run the application
# CMD ["python", "app.py"]




# Use the official Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary system dependencies for Selenium and pip
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    curl \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install virtualenv to create isolated environments
RUN pip install virtualenv

# Create a virtual environment inside the container
RUN python3 -m venv /venv

# Ensure that the virtual environment is used
ENV PATH="/venv/bin:$PATH"

# Copy the app code into the container
COPY . .

# Install Flask and other app dependencies in the virtual environment
RUN pip install flask

# Install Selenium dependencies in the virtual environment
RUN pip install -r selenium-automate/requirements.txt

# Expose port for Flask app
EXPOSE 5000

# Set the command to run the Flask app
CMD ["python", "app.py"]
