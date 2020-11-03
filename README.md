
![atl text](rnlogo.png)

## RnMonitor Project
RnMonitor is the acronym of the project “Online Monitoring Infrastructure and Active Mitigation Strategies for Indoor Radon Gas in Public Buildings on the Northern Region of Portugal” that focus on the design of a Cyber-Physical System (CPS) for online monitoring and active mitigation of radon gas concentration inside granitic public buildings of the north region of Portugal.

More information at: 
<http://rnmonitor.ipvc.pt/>

#### Clone the project
Connect to your machine via ssh with root privileges<br>

> - Set active path to `/home`
> - Clone the project :  `git clone https://github.com/scoobie/RnMonitor_IPCA.git `
> - Change current directory : `cd RnMonitor_IPCA`

#### Variables setup
##### Postgres  
> - Edit the .env file: `nano .env`
> - Set the database name:  `DB_DATABASE_NAME= [YOUR DATABASE NAME]`
> - set the database user : `DB_PASSWORD=[YOUR DATABASE USER]`
> - set the database password : `DB_PASSWORD=[YOUR DATABASE PASSWORD]`
> - Save the changes

##### PDI 
> - Change current directory to: `cd /home/RnMonitor_IPCA/pdi`
> - Edit the kettle.properties file: `nano kettle.properties`
> - Set the API Token:  `Token= [YOUR TOKEN]`
> - set the API URL : `BASE_URL=http://[YOUR API IP]:3000/api/`
> - set the Postgres instance : `POSTGRES_DB_HOST=[YOUR POSGRES SERVICE NAME]`
> - set the Postgres port : `POSTGRES_DB_PORT=[YOUR POSTGRES PORT]`
> - set the Postgres user : `POSTGRES_DB_USER=[YOUR POSTGRES USER]`
> - set the Postgres database name : `POSTGRES_DB_NAME=[YOUR DATABASE NAME]`
> - set the Postgres password : `POSTGRES_DB_PASS=[YOUR DATABASE PASSWORD]`
> - Save the changes

##### Mondrian 
> - Change current directory to: `cd /home/RnMonitor_IPCA/mondrian/files`
> - Edit the mondrian-connections.json file: `nano mondrian-connections.json`
> - Set the JDBC:  `"Jdbc": "jdbc:postgresql://[POSTGRES CONTAINER NAME]/[DATABASE NAME]`
> - set the JDBC user : `"JdbcUser": "[YOUR POSTGRES USER]"`
> - set the  JDBC password : `"JdbcPassword": "[YOUR DATABASE PASSWORD]"`
> - Save the changes

#### Start the project
> - Change current directory to: `cd /home/RnMonitor_IPCA`
> - Build the project: `docker-compose build`
> - Start the containers: `docker-compose up -d`
> - You can check the containers: `docker container ls`
> - You can manually start the PDI container: `docker container run --network=rnmonitor_ipca_rnetwork --rm -v $(pwd):/jobs pdirn runj jobs/ETL_RNMONITOR.kjb`

#### CRON setup to start the PDI container automatically
Container execution will be scheduled for 1AM every day
> - Change current directory to: `cd /home/RnMonitor_IPCA/pdi`
> - Change Dockcron.sh file permissions: `chmod -R 755 /home/RnMonitor_IPCA/pdi`
> - Edit crontab: `crontab -e`
> - Set new cronjob: `* 1 * * * cd /home/RnMonitor_IPCA/pdi && ./Dockcron.sh > /home/RnMonitor_IPCA/result.txt 2>&1`
> - Cron logs will be saved into result.txt file on: `/home/RnMonitor_IPCA` directory