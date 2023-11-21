This script is designed to ensure consistency between environment variables declared in a Spring Boot application's `application.yml` file and a corresponding `values.yml` file, typically used in a GitOps workflow. The script is useful in a continuous integration/continuous deployment (CI/CD) pipeline to maintain alignment between application configuration and deployment configuration.

### Script Overview:

- **Filename:** `env_check_script.sh`
- **Purpose:** To verify that all environment variables required by a Spring Boot application (as defined in `application.yml`) are declared in the `values.yml` file used for deployment. It also checks for any variables in `values.yml` that are not used in `application.yml`, which might indicate outdated or redundant configuration.
- **Usage:** Integrate this script into a CI/CD pipeline, such as GitLab CI, to automate the verification process as part of your deployment workflow.

### How to Use in GitLab CI:

1. **Add the Script to Your Repository:**
   - Save the script as `env_check_script.sh` in your repository.

2. **Update GitLab CI Configuration:**
   - In your `.gitlab-ci.yml` file, create a job that executes this script. Example:
     ```yaml
     check_env_variables:
       stage: check
       script:
         - bash env_check_script.sh
     ```
   - This job should be placed in an appropriate stage of your pipeline, such as before deployment.

3. **Ensure File Paths:**
   - Make sure the `application_yml` and `values_yml` variables in the script point to the correct file paths in your repository.

### What the Script Does:

1. **Extract Environment Variables:**
   - From `application.yml`, it extracts all instances where environment variables are referenced (e.g., `${VARIABLE_NAME}`).

2. **List Variables in `values.yml`:**
   - Reads `values.yml` and lists all defined variables.

3. **Check for Unused Variables:**
   - Identifies variables in `values.yml` that are not used in `application.yml`, and outputs a warning for each.

4. **Check for Missing Variables:**
   - Checks each variable from `application.yml` against `values.yml`. If any are missing, it lists them.

5. **Fail on Missing Variables:**
   - If any required variables are missing in `values.yml`, the script exits with a status code of `1`, causing the CI job to fail.

### Best Practices for GitOps and CI/CD Integration:

- **Regularly Review Configurations:** Regularly review both `application.yml` and `values.yml` to ensure they reflect current application needs.
- **Automate Checks:** Use this script as part of your CI pipeline to automate configuration checks and reduce the risk of configuration drift or errors.
- **Document Changes:** Maintain clear documentation for any changes made to environment variables and ensure these changes are reflected across all relevant files and environments.
- **Secure Sensitive Data:** Avoid hardcoding sensitive information in your `application.yml` or `values.yml`. Use secrets management tools or CI/CD variables for sensitive data.

By following these practices and integrating this script into your CI/CD pipeline, you can enhance the reliability and consistency of your application deployments.
