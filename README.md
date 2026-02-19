## Claude-Watsonx-Studio Quick Start
1. This is based of the watsonx data MCP retrievar server project (https://github.com/IBM/ibm-watsonxdata-mcp-server)
2. Pre-requisite
   ```text
    ├── Watsonx.data service (lite is enough, in a region of your choice)            
    ├── A vaild data API key for a watsonx.data user.
         ├──Should have access to the cluster resources, catalog etc.
         └── Should have access to the presto and spark engines
    ├── Watsonx-ai project if you want to use ibm granite models.
    ├── Watson-ai project key.
    └── Some credit in your anthropic account if you want to use anthropic claude models.

3. Edit `.env` file and add your API keys:
    ``` ini
    ANTHROPIC_API_KEY=<your-antropic-key> # if you want to use claude models

    # Base URL for watsonx.data service, this would be different for each region.
    # needed to configure MCP tool
    WATSONX_DATA_BASE_URL=https://us-south.lakehouse.cloud.ibm.com/lakehouse/api/
    WATSONX_DATA_API_KEY=#This is needed to connect to watsonx.data services
    WATSONX_DATA_INSTANCE_ID=<The CRN of your watsonx.data service>
    #Watsonx-ai settings need if you want to use the ibm granite models.
    WATSONX_API_KEY=<key to access your watsonx-ai project>
    WATSONX_PROJECT_ID=<Project of your watsonx-ai project, needed to use ibm granite models>
    #URL for watsonx ai and ml service, region specific.
    WATSONX_URL=https://us-south.ml.cloud.ibm.com

    #change these if you want a different login than default.
    WEBUI_ADMIN_EMAIL=admin@ibm.com #default, change if you want a different user.
    WEBUI_ADMIN_PASSWORD=pass123 #default, change if you want a different user.
    WEBUI_ADMIN_NAME=Admin #default, change if you want a different user.
    ```

4. Run:
   docker-compose up -d

5. Open http://localhost:3000

6. Start chatting with Claude about your watsonx.data! 🎉
