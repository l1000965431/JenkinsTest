pipeline {
  agent any
  stages {
    stage('test') {
      steps {
        echo '${branch}'
      }
    }

  }
  environment {
    branch = 'master'
  }
}