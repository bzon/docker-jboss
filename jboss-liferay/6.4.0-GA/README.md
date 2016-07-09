#### General Usage
`docker-compose -f mysql-compose/default.yml up -d`

`docker-compose up -d`

Access the host from your web browser: `http://localhost:8080/liferay`

The page should display that you need to enter your Trial License.

#### Enabling License
`docker cp LiferayTrial_x_x.li liferay:/opt/jboss/deploy/`

Then watch the license gets deployed using `docker logs` 

Access the page again and you should now be able to proceed with the Liferay Wizard.

