# FROM python:3.9

# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# WORKDIR /app

# COPY requirements.txt .

# RUN pip install --no-cache-dir -r requirements.txt

# COPY . .

# EXPOSE 5000

# CMD ["python", "app.py"]
# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the application files to the container
COPY . .

# Install necessary dependencies
RUN pip install --no-cache-dir gunicorn flask flask_sqlalchemy

# Expose the port on which the app runs
EXPOSE 8000

# Command to run the application
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
