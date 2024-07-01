#!/bin/bash

# URL of your Tomcat server and global vars
BASE_URL="http://localhost:8080/my-webapp"

# Cookie file to store session information
COOKIE_FILE=$(mktemp)

# Function to perform a GET request to a specific endpoint
function hit_endpoint() {
    local endpoint=$1
    echo "Hitting ${BASE_URL}${endpoint}"
    # Perform the curl request and save cookies
    response=$(curl -s -c $COOKIE_FILE -b $COOKIE_FILE -w "%{http_code} %{url_effective}\\n" "${BASE_URL}${endpoint}")
    echo "$response"
    # Check for JSESSIONID in the cookie file
    if grep -q 'JSESSIONID' $COOKIE_FILE; then
        echo "JSESSIONID found in cookies:"
        grep 'JSESSIONID' $COOKIE_FILE
    else
        echo "JSESSIONID not found"
    fi
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
    sleep 5

    # Fault endpoint
    hit_endpoint "/fault"
    sleep 10

    # Nonexistent endpoint
    hit_endpoint "/nonexistent"
    sleep 20

    # Adjust sleep duration as needed to simulate different load patterns
    sleep $((RANDOM % 5 + 1))
done

# Clean up the cookie file
trap "rm -f $COOKIE_FILE" EXIT
