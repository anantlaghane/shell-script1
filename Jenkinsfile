pipeline {
    agent any

    parameters {
        string(name: 'STUDENT_NAME', defaultValue: 'Anant', description: 'Enter student name')
        choice(name: 'CITY', choices: ['Pune', 'Mumbai', 'Delhi', 'Bangalore'], description: 'Select city')
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/master']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/your-username/linux-repo.git',
                            credentialsId: 'your-jenkins-credentials-id' // Use Jenkins credentials
                        ]]
                    ])
                }
            }
        }

        stage('Run Shell Script') {
            steps {
                sh 'chmod +x student_info.sh'
                sh './student_info.sh ${params.STUDENT_NAME} ${params.CITY}'
            }
        }
    }
}
