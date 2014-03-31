@ossec_server

Feature: Validate Server Installation

  I expect that I can connect to instance and verify that ossec server installation is complete and that the client is connected

  Scenario: Instance is active, ossec server is installed and running
    Given a system has been initialized
    When I can ssh to the server as "vagrant"
    Then I should see the common "ossec-hids" services are "running"
    And I should see the "ossec-hids" server services are "running"
    And I should see a server configuration file located at "/var/ossec/etc/ossec.conf"
    And I should see the client "ossec-client.acme.com" connected with an "Active" status

