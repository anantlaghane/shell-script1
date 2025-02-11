pipeline {
    agent any

    parameters {
        string(name: 'STUDENT_NAME', defaultValue: 'Anant', description: 'Enter student name')
        choice(name: 'CITY', choices: ['Pune', 'Mumbai', 'Delhi', 'Bangalore'], description: 'Select city')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/your-username/linux-repo.git'
            }
        }

        stage('Run Shell Script') {
            steps {
                sh 'chmod +x student_info.sh'
                sh './student_info.sh "$STUDENT_NAME" "$CITY"'
            }
        }
    }
}
