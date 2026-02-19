FROM ghcr.io/open-webui/open-webui:main

USER root

# 1. Install Python and the Watsonx MCP package
RUN apt-get update && apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip install ibm-watsonxdata-mcp-server

# 2. Create the specific config directory Claude looks for
RUN mkdir -p /root/.config/Claude/

# 3. Create the claude_desktop_config.json DIRECTLY in the image
# This embeds your Watsonx MCP server into the Claude CLI logic
RUN echo '{ \
  "mcpServers": { \
    "IBM watsonx.data": { \
      "command": "python3", \
      "args": ["-m", "ibm_watsonxdata_mcp_server", "--transport", "stdio"], \
      "env": { \
        "WATSONX_DATA_BASE_URL": "https://us-south.lakehouse.cloud.ibm.com/lakehouse/api/", \
        "WATSONX_DATA_API_KEY": "0D32g0p6KcCnUUYM5xscgvOwnYujdE8SozkNLUEBf7Lj", \
        "WATSONX_DATA_INSTANCE_ID": "crn:v1:bluemix:public:lakehouse:us-south:a/d31f6393983442ab8a9f7ff7b54b6056:3748e36c-9693-4af3-89b1-672f69c89e9d::" \
      } \
    } \
  } \
}' > /root/.config/Claude/claude_desktop_config.json

# 4. Copy your SSL certificate to the expected path
RUN mkdir -p /app/mcp
COPY cabundle.crt /app/mcp/cabundle.crt
ENV SSL_CERT_FILE=/app/mcp/cabundle.crt

# Standard Open WebUI port
EXPOSE 8080

ENTRYPOINT ["bash", "/app/backend/start.sh"]