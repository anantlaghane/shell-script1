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
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/anantlaghane/shell-script1.git',
                            credentialsId: 'linux' // Use Jenkins credentials
                        ]]
                    ])
                }
            }
        }

        stage('Run Shell Script') {
            steps {
                script { 
               // sh 'chmod +x student_info.sh'
             //   sh './student_info.sh ${params.STUDENT_NAME} ${params.CITY}'
                sh 'sh student_info.sh ${params.STUDENT_NAME} ${params.CITY}'
                }
            }
        }
    }
}
