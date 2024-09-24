#!/bin/bash

# URL of your Tomcat server and global vars
BASE_URL="http://app:8080"

# Function to perform a GET request to a specific endpoint
function hit_endpoint() {
    local endpoint=$1
    echo "Hitting ${BASE_URL}${endpoint}"
    # Perform the curl request and save cookies
    response=$(curl -s -w "%{http_code} %{url_effective}\\n" "${BASE_URL}${endpoint}")
    echo "$response"
}

# Initial request to establish session and generate JSESSIONID
hit_endpoint "/home"

# Infinite loop to continuously send requests
while true; do
    # Home endpoint
    hit_endpoint "/home"
    sleep 1

    # Error endpoint
    hit_endpoint "/error"
    sleep 1

    # Fault endpoint
    hit_endpoint "/fault"
    sleep 1

    # Nonexistent endpoint
    hit_endpoint "/nonexistent"
    sleep 1

    # Adjust sleep duration as needed to simulate different load patterns
    sleep $((RANDOM % 5 + 1))
done