pipeline {
  agent any
  stages {
    stage('test') {
      steps {
        echo 'Hello World'
        ws(dir: 'D:\\Work\\Jenkins\\workspace_1')
      }
    }

  }
  environment {
    branch = 'master'
  }
}