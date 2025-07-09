# discovery-server-atendeia

**AtendeIA - Discovery Server**  
Este projeto é responsável pelo **Service Discovery** da plataforma **AtendeIA**, utilizando **Spring Cloud Netflix Eureka Server**. Ele permite o registro e descoberta dinâmica dos microsserviços que compõem o ecossistema.

---

## 📦 Tecnologias utilizadas

- Java 17
- Spring Boot 3.x
- Spring Cloud Netflix Eureka
- Maven
- Docker

---

## 🚀 Como executar

### 🧪 1. Executar localmente via Maven (IDE ou terminal)
```bash
mvn spring-boot:run
```

Acesse:
```
http://localhost:8761
```

---

### 🐳 2. Build e execução com Docker

#### 📌 2.1. Compile o projeto com Maven:
```bash
mvn clean package -DskipTests
```

#### 📌 2.2. Crie a imagem Docker:
```bash
docker build -t atendeia-discovery-server:latest .
```

#### 📌 2.3. Execute o container:
```bash
docker run -d -p 8761:8761 --name discovery-server atendeia-discovery-server:latest
```

Acesse:  
[http://localhost:8761](http://localhost:8761)

---

### 🔁 3. Build automático com script `build.sh`

O repositório inclui um script que automatiza o build e já aplica as tags com a versão do projeto.

#### 📌 3.1. Torne o script executável:
```bash
chmod +x build.sh
```

#### 📌 3.2. Execute o script:
```bash
./build.sh
```

Esse script irá:
- Obter a versão atual do `pom.xml`;
- Criar a imagem Docker com duas tags:
  - `atendeia-discovery-server:<versão>`
  - `atendeia-discovery-server:latest`

#### 📌 3.3. Executar a imagem:
```bash
docker run -d -p 8761:8761 --name discovery-server atendeia-discovery-server:<versão>
```

---

## 🧭 Função no ecossistema AtendeIA

Este serviço permite que os demais microsserviços (`auth-service-atendeia`, `ticket-service-atendeia`, etc.) se registrem automaticamente, facilitando a comunicação e escalabilidade da aplicação.

---

## 📁 Estrutura do pacote principal
```java
com.atendeia.discoveryserver
```

---

## 📄 Arquivo application.yml (resumo)

```yaml
server:
  port: 8761

spring:
  application:
    name: atendeia-discovery-server

eureka:
  instance:
    hostname: ${EUREKA_HOST:localhost}
    prefer-ip-address: true

  client:
    register-with-eureka: false
    fetch-registry: false

  server:
    wait-time-in-ms-when-sync-empty: 0
```

---

## 🧠 Sobre o AtendeIA

O AtendeIA é uma plataforma moderna de atendimento ao cliente que combina:

- IA para autoatendimento (chatbot),
- Geolocalização e envio de fotos nos chamados,
- Análise de sentimento e classificação automática,
- Arquitetura baseada em microserviços com mensageria (Kafka),
- Observabilidade com Prometheus e Grafana.

---

## 📄 Licença

Este projeto é open source e está sob a licença MIT.