# #!/bin/bash 

# if [ $# -ne 2 ]; then 
#     echo "Usage: $0 <student_name> <city>"
#     exit 1
# fi

# STUDENT_NAME=$1
# CITY=$2    

# echo "Student Name: $STUDENT_NAME"
# echo "City: $CITY"


pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/anantlaghane/shell-script1.git'
            }
        }

        stage('Run Shell Script') {
            steps {
                sh 'chmod +x student_info.sh && ./student_info.sh Anant Pune'
            }
        }
    }
}
