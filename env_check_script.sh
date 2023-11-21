#!/bin/bash

application_yml="path/to/application.yml"
values_yml="path/to/values.yml"

application_envs=$(grep -o '\${[^}:]\+' $application_yml | tr -d '${}' | sort -u)
echo "Extracted environment variables from application.yml:"
echo "$application_envs"

values_envs=$(grep -o '^[^:]\+' $values_yml | sort -u)

# Check for variables in values.yml not used in application.yml
unused_envs=()
for key in $values_envs; do
    if ! echo "$application_envs" | grep -qx "$key"; then
        unused_envs+=("$key")
    fi
done

# Show warnings for unused variables
if [ ${#unused_envs[@]} -gt 0 ]; then
    echo -e "\nWarning: The following variables are defined in values.yml but not used in application.yml:"
    for env in "${unused_envs[@]}"; do
        echo $env
    done
fi

# Checking each environment variable from application.yml in values.yml
missing_envs=()
for key in $application_envs; do
    if ! grep -q "^$key:" $values_yml; then
        missing_envs+=("$key")
    fi
done

# Outputting results and failing if missing variables are found
if [ ${#missing_envs[@]} -eq 0 ]; then
    echo -e "\nAll environment variables from application.yml are present in values.yml"
else
    echo -e "\nMissing environment variables:"
    for env in "${missing_envs[@]}"; do
        echo $env
    done
    exit 1
fi
