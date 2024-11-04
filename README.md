# tjd3s-app

The Web app runs on Port 8090, PHP My Admin runs on port 8092 using a docker container
Run the commands in quatations in the following order

## Steps to run:
- "docker compose --build" - to build docker image
- "docker compose up" - to run docker container
- "docker exec -it tjd3s-web-app bash" - to enter docker container
- "mkdir imagem && mkdir -p imagem/{cript,decrypted,input,key,lixeira,pasteur1,pasteur2}" - to create image folder and necessary  files for file processing
- "chmod 777 * && chmod 777 php/* imagem/*" - Give full permissions to all files in the root docker conainer and everything in php and imagem folder
    
## Steps to install python for image processing:
- "cd /var/www/html" - make sure you are in the root docker container directory
- "python3 -m venv venv" - install python virtual environment
- "source venv/bin/activate" - activate python virtual Environment
- "cd php" - "change directory to /php"
- "pip install -r requirements.txt" - install all python dependency necessary for image processing