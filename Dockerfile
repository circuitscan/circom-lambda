FROM public.ecr.aws/lambda/nodejs:20

COPY package.json ${LAMBDA_TASK_ROOT}/
COPY yarn.lock ${LAMBDA_TASK_ROOT}/

# Install pnpm
RUN npm install -g yarn

# Install NPM dependencies
RUN yarn install --prod

# Set the CMD to your handler
CMD ["index.handler"]

# Download circom executables
RUN curl -Lo /tmp/circom-v2.0.8 https://github.com/iden3/circom/releases/download/v2.0.8/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.0.9 https://github.com/iden3/circom/releases/download/v2.0.9/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.0 https://github.com/iden3/circom/releases/download/v2.1.0/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.1 https://github.com/iden3/circom/releases/download/v2.1.1/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.2 https://github.com/iden3/circom/releases/download/v2.1.2/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.3 https://github.com/iden3/circom/releases/download/v2.1.3/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.4 https://github.com/iden3/circom/releases/download/v2.1.4/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.5 https://github.com/iden3/circom/releases/download/v2.1.5/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.6 https://github.com/iden3/circom/releases/download/v2.1.6/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.7 https://github.com/iden3/circom/releases/download/v2.1.7/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.8 https://github.com/iden3/circom/releases/download/v2.1.8/circom-linux-amd64
RUN curl -Lo /tmp/circom-v2.1.9 https://github.com/iden3/circom/releases/download/v2.1.9/circom-linux-amd64

# Make the executables... well, executable
RUN chmod +x /tmp/circom-*

# Move the executables to a directory included in the PATH
RUN mv /tmp/circom-* /usr/local/bin

# src/utils.js#monitorProcessMemory uses ps
RUN dnf install procps -y

COPY template/* ${LAMBDA_TASK_ROOT}/template/
# Copy app source last for faster rebuilds
COPY index.js ${LAMBDA_TASK_ROOT}/index.js
COPY src/*.js ${LAMBDA_TASK_ROOT}/src/

