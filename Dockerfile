FROM ghcr.io/open-webui/open-webui:main

USER root

# 1. Install Python and the Watsonx MCP package
RUN apt-get update && apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip install ibm-watsonxdata-mcp-server

# 2. Create the specific config directory Claude looks for
RUN mkdir -p /root/.config/Claude/

# 3. Create the claude_desktop_config.json DIRECTLY in the image
# This embeds your Watsonx MCP server into the Claude CLI logic

# 4. Copy your SSL certificate to the expected path
RUN mkdir -p /app/mcp
COPY cabundle.crt /app/mcp/cabundle.crt
ENV SSL_CERT_FILE=/app/mcp/cabundle.crt

# Standard Open WebUI port
EXPOSE 8080

ENTRYPOINT ["bash", "/app/backend/start.sh"]