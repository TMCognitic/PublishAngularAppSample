FROM nginx AS base


FROM node AS build
#installation d'Angular
RUN npm install -g @angular/cli

WORKDIR /src

#Installation de git et récupération du repository
RUN apt-get update
RUN apt-get install -y git
RUN git clone https://github.com/TMCognitic/AngularAppTest.git .

#Installation des node_modules
RUN npm install

#build de l'application
#ng build crée l'application dans le répertoire dist/<nom de l'app>/browser
RUN ng build 

FROM base AS final

WORKDIR /usr/share/nginx/html
RUN rm *

#Copie l'application dans le répertoire de NGINX
COPY --from=build /src/dist/demoApp/browser/ .

