pipeline{
    agent any
    stages{
        stage('create release'){
            steps{
                deleteDir()
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/rusun01/test-repository']]])
                script{
                    sh 'ls -la'
                    env.nextRelease = sh script: ''' #!/bin/bash
                        source ./create-release.sh
                        githubURL='https://github.com/rusun01/test-repository'
                        getNextRelease $(getLatestRelease)
                    ''', returnStdout: true

                    sh """#!/bin/bash
                        source ./create-release.sh
                        githubURL='https://github.com/rusun01/test-repository'
                        makeNewRelease ${env.nextRelease}
                    """
                }

            }
        }
    }
}