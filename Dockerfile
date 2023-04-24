# Utilize uma imagem base com Node.js e Java (Alpine para manter pequena)
FROM node:14-alpine

# Instale o OpenJDK 11
RUN apk add --no-cache openjdk11

# Defina a pasta de trabalho
WORKDIR /usr/src/app

# Copie o arquivo package.json e package-lock.json (se disponível)
COPY package*.json ./

# Instale as dependências do projeto
RUN npm ci

# Copie o restante dos arquivos do projeto
COPY . .

# Realize o build do projeto, se necessário
RUN npm run build

# Copie o artefato .jar para a pasta de trabalho
#COPY C:/Users/Mario/Documents/Docker/Unimed/unimed-devsecops.jar /usr/src/app/artifact.jar
COPY unimed-devsecops.jar /usr/src/app/artifact.jar

# Exponha a porta em que sua aplicação irá rodar
EXPOSE 3000

# Inicie a aplicação JavaScript e o artefato .jar
CMD ["sh", "-c", "npm start & java -jar artifact.jar"]
