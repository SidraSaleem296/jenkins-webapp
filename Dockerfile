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




FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    curl \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies directly
RUN pip install virtualenv selenium flask

# Create a virtual environment
RUN python3 -m venv /venv

# Set the path for the virtual environment
ENV PATH="/venv/bin:$PATH"

# Copy the application code into the container
COPY . .

# Install Flask and any additional dependencies
RUN pip install flask
