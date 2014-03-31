@ossec_client

Feature: Validate Client Installation

  I expect that I can connect to instance and verify that ossec client installation is complete

  Scenario: Instance is active, ossec client is installed and running
    Given a system has been initialized
    When I can ssh to the client as "vagrant"
    Then I should see the common "ossec-hids" services are "running"
    And I should see the "ossec-hids" client service is "running"
    And I should see a client configuration file located at "/var/ossec/etc/ossec.conf"

