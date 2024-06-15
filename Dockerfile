## Use the official Python 3.10 image
FROM python:3.10.13

## set the working directory to /code
WORKDIR /code

## Copy the current directory contents in the container at /code
COPY ./requirements.txt /code/requirements.txt

## Install the requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Set up a new use named "user"
RUn useradd user

#Switch to the "user" user
USER user

# Ser home to the user's home directory

ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set the working directory to the user's home directory
WORKDIR $HOME/app

# Copy the current directory contents into the container at $HOME/app setting the owner to user
COPY --chown=user . $HOME/app    

## Start the FASTAPI App on port 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]